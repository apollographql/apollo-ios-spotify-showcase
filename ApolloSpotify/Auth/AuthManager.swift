import AuthenticationServices
import CommonCrypto
import Foundation

actor AuthManager {
  
  // MARK: - Variables
  
  private let presentationAnchor = PresentationContextProvider()
  private var currentToken: AccessToken?
  private var tokenRefreshTask: Task<AccessToken, Error>?
  
  // MARK: - Initialization
  
  init() {
    currentToken = try? KeychainHandler.getToken()
  }
  
  // MARK: - Authorization Request
  
  private func authorizationRequest() async throws -> AccessToken {
    let codeVerifier = codeVerifier()
    let codeChallenge = codeChallenge(for: codeVerifier)
    let state = UUID().uuidString
    
    guard let authURL = authURL(with: codeChallenge, state: state) else {
      fatalError("Failed to build auth url.")
    }
    
    return try await withCheckedThrowingContinuation { continuation in
      let authSession = ASWebAuthenticationSession.init(
        url: authURL,
        callbackURLScheme: "apollo-ios-spotify-showcase") { responseURL, responseError in
          guard responseError == nil else {
            continuation.resume(throwing: OAuthError.authRequestFailed(responseError!))
            return
          }
          
          guard let url = responseURL else {
            continuation.resume(throwing: OAuthError.noResponseURL)
            return
          }
          
          guard let code = url.getQueryStringParameter("code") else {
            continuation.resume(throwing: OAuthError.noResponseCode)
            return
          }
          
          guard let responseState = url.getQueryStringParameter("state"),
                responseState == state else {
            continuation.resume(throwing: OAuthError.invalidState)
            return
          }
          
          // call to get access token
          Task {
            do {
              let accessToken = try await self.requestAccessToken(authCode: code, codeVerifier: codeVerifier)
              continuation.resume(returning: accessToken)
            } catch {
              continuation.resume(throwing: error)
            }
          }
        }
      
      Task {
        await MainActor.run {
          authSession.presentationContextProvider = presentationAnchor
          authSession.prefersEphemeralWebBrowserSession = true
          authSession.start()
        }
      }
    }
  }
  
  private func authURL(
    with codeChallenge: String,
    state: String
  ) -> URL? {
    let queryItems = [
      URLQueryItem(name: "response_type", value: "code"),
      URLQueryItem(name: "client_id", value: Constants.clientID),
      URLQueryItem(name: "scope", value: Constants.scopes),
      URLQueryItem(name: "state", value: state),
      URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
      URLQueryItem(name: "code_challenge", value: codeChallenge),
      URLQueryItem(name: "code_challenge_method", value: "S256")
    ]
    
    var urlComps = URLComponents(string: Constants.authURL)
    urlComps?.queryItems = queryItems
    return urlComps?.url
  }
  
  // MARK: - Token Handling
  
  func getAccessToken() async throws -> String {
    // if refresh task is active, await the return of that
    if let refreshTask = tokenRefreshTask {
      return try await refreshTask.value.accessToken
    }
    
    guard let token = currentToken else {
      return try await authorizationRequest().accessToken
    }
    
    if token.isTokenValid() {
      return token.accessToken
    }
    
    return try await refreshAccessToken().accessToken
  }
  
  private func requestAccessToken(
    authCode: String,
    codeVerifier: String
  ) async throws -> AccessToken {
    print("Requesting Access Token...")
    guard let bodyData = accessTokenRequestBody(authCode: authCode, codeVerifier: codeVerifier) else {
      fatalError()
    }
    
    let request = buildTokenRequest(with: bodyData)
    let (data, response) = try await URLSession.shared.data(for: request)
    return try processTokenAPIResponse(response, withData: data)
  }
  
  private func accessTokenRequestBody(
    authCode: String,
    codeVerifier: String
  ) -> Data? {
    let queryItems = [
      URLQueryItem(name: "grant_type", value: "authorization_code"),
      URLQueryItem(name: "code", value: authCode),
      URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
      URLQueryItem(name: "client_id", value: Constants.clientID),
      URLQueryItem(name: "code_verifier", value: codeVerifier)
    ]
    
    var urlComps = URLComponents()
    urlComps.queryItems = queryItems
    
    return urlComps.query?.data(using: .utf8)
  }
  
  private func refreshAccessToken() async throws -> AccessToken {
    print("Refreshing Access Token...")
    guard let currentToken = currentToken else {
      throw OAuthError.missingToken
    }
    
    if let refreshTask = tokenRefreshTask {
      return try await refreshTask.value
    }
    
    let task = Task { () throws -> AccessToken in
      defer {
        tokenRefreshTask = nil
      }
      
      guard let bodyData = refreshTokenRequestBody(refreshToken: currentToken.refreshToken) else {
        fatalError()
      }
      
      let request = buildTokenRequest(with: bodyData)
      let (data, response) = try await URLSession.shared.data(for: request)
      return try processTokenAPIResponse(response, withData: data)
    }
    
    tokenRefreshTask = task
    
    return try await task.value
  }
  
  private func refreshTokenRequestBody(
    refreshToken: String
  ) -> Data? {
    let queryItems = [
      URLQueryItem(name: "grant_type", value: "refresh_token"),
      URLQueryItem(name: "refresh_token", value: refreshToken),
      URLQueryItem(name: "client_id", value: Constants.clientID)
    ]
    
    var urlComps = URLComponents()
    urlComps.queryItems = queryItems
    
    return urlComps.query?.data(using: .utf8)
  }
  
  private func buildTokenRequest(
    with bodyData: Data
  ) -> URLRequest {
    guard let tokenURL = URL(string: Constants.tokenURL) else {
      fatalError()
    }
    
    let headers: [String: String] = ["content-type": "application/x-www-form-urlencoded"]
    var request = URLRequest(url: tokenURL)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = headers
    request.httpBody = bodyData
    
    return request
  }
  
  private func processTokenAPIResponse(
    _ response: URLResponse,
    withData data: Data
  ) throws -> AccessToken {
    let decoder = JSONDecoder()
    
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      let tokenErrorResponse = try decoder.decode(TokenErrorResponse.self, from: data)
      throw OAuthError.tokenError(tokenErrorResponse)
    }
    
    let accessToken = try decoder.decode(AccessToken.self, from: data)
    currentToken = accessToken
    do {
      let keychainResult = try KeychainHandler.storeToken(accessToken)
      if !keychainResult {
        print("Failed to store access token in keyhchain.")
      }
    } catch {
      print("Error storing access token in keychain: \(error)")
    }
    
    return accessToken
  }
  
  // MARK: - Code Challenge
  
  private func codeVerifier() -> String {
    var buffer = [UInt8](repeating: 0, count: 32)
    _ = SecRandomCopyBytes(kSecRandomDefault, buffer.count, &buffer)
    return Data(buffer)
      .base64EncodedString()
      .replacingOccurrences(of: "=", with: "")
      .replacingOccurrences(of: "+", with: "-")
      .replacingOccurrences(of: "/", with: "_")
      .trimmingCharacters(in: .whitespaces)
  }
  
  private func codeChallenge(for verifier: String) -> String {
    guard let data = verifier.data(using: .utf8) else {
      fatalError("Could not convert code verifier to data.")
    }
    var buffer = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
    data.withUnsafeBytes {
      CC_SHA256($0, CC_LONG(data.count), &buffer)
    }
    
    return Data(buffer)
      .base64EncodedString()
      .replacingOccurrences(of: "=", with: "")
      .replacingOccurrences(of: "+", with: "-")
      .replacingOccurrences(of: "/", with: "_")
      .trimmingCharacters(in: .whitespaces)
  }
  
}

// MARK: - Constants

struct Constants {
  static let authURL = "https://accounts.spotify.com/authorize"
  static let tokenURL = "https://accounts.spotify.com/api/token"
  static let redirectURI = "apollo-ios-spotify-showcase://spotify-login-callback"
  static let clientID = "9dd735b766a24ea192c773fac86caefa"
  static let scopes = [
    "playlist-modify-private",
    "playlist-modify-public",
    "playlist-read-collaborative",
    "playlist-read-private",
    "streaming",
    "user-follow-modify",
    "user-follow-read",
    "user-library-modify",
    "user-library-read",
    "user-modify-playback-state",
    "user-read-currently-playing",
    "user-read-email",
    "user-read-playback-position",
    "user-read-playback-state",
    "user-read-private",
    "user-read-recently-played",
    "user-top-read"
  ].joined(separator: " ")
}

// MARK: - Responses and Errors

enum OAuthError: LocalizedError {
  case authRequestFailed(Error)
  case invalidState
  case missingToken
  case noResponseCode
  case noResponseURL
  case tokenError(TokenErrorResponse)
  
  var errorDescription: String? {
    switch self {
    case .authRequestFailed(let error):
      return "OAuth authorization request failed: \(error.localizedDescription)"
    case .invalidState:
      return "An invalid state was returned from the authorization request that did not match local state."
    case .missingToken:
      return "No token was found."
    case .noResponseCode:
      return "Authorization response did not return an authorization code."
    case .noResponseURL:
      return "Authorization response did not include a url."
    case .tokenError(let tokenError):
      return "Access token request failed: \(tokenError.error) - \(tokenError.error_description)"
    }
  }
}

struct TokenErrorResponse: Codable {
  let error: String
  let error_description: String
}

// MARK: - PresentationContextProvider

fileprivate class PresentationContextProvider: NSObject, ASWebAuthenticationPresentationContextProviding {
  func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
    return ASPresentationAnchor()
  }
}

// MARK: - Extensions

extension URL {
  func getQueryStringParameter(_ parameter: String) -> String? {
    guard let url = URLComponents(string: self.absoluteString) else { return nil }
    return url.queryItems?.first(where: { $0.name == parameter })?.value
  }
}

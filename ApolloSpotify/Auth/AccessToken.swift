import Foundation

struct AccessToken: Codable {
  // JSON Response properties
  let accessToken: String
  let tokenType: String
  let scope: String
  let expiresIn: Int
  let refreshToken: String
  
  // Local properties
  let expirationTime: Int
  
  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case tokenType = "token_type"
    case scope = "scope"
    case expiresIn = "expires_in"
    case refreshToken = "refresh_token"
  }
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    accessToken = try container.decode(String.self, forKey: .accessToken)
    tokenType = try container.decode(String.self, forKey: .tokenType)
    scope = try container.decode(String.self, forKey: .scope)
    expiresIn = try container.decode(Int.self, forKey: .expiresIn)
    refreshToken = try container.decode(String.self, forKey: .refreshToken)
    
    expirationTime = Int(Date().timeIntervalSince1970) + expiresIn
  }
  
  func isTokenValid() -> Bool {
    return expirationTime > Int(Date().timeIntervalSince1970)
  }
  
}

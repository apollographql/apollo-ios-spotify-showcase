import Foundation

struct AccessToken: Codable {
  // JSON Response properties
  let accessToken: String
  let tokenType: String
  let scope: String
  let expiresIn: Int
  let refreshToken: String
  
  // Local properties
  private var expirationTime: Int = -1
  
  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case tokenType = "token_type"
    case scope = "scope"
    case expiresIn = "expires_in"
    case refreshToken = "refresh_token"
    case expirationTime
  }
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    accessToken = try container.decode(String.self, forKey: .accessToken)
    tokenType = try container.decode(String.self, forKey: .tokenType)
    scope = try container.decode(String.self, forKey: .scope)
    expiresIn = try container.decode(Int.self, forKey: .expiresIn)
    refreshToken = try container.decode(String.self, forKey: .refreshToken)
    expirationTime = try container.decodeIfPresent(Int.self, forKey: .expirationTime) ?? -1
    
    if expirationTime == -1 {
      expirationTime = Int(Date().timeIntervalSince1970) + expiresIn
    }
  }
  
  func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(self.accessToken, forKey: .accessToken)
    try container.encode(self.tokenType, forKey: .tokenType)
    try container.encode(self.scope, forKey: .scope)
    try container.encode(self.expiresIn, forKey: .expiresIn)
    try container.encode(self.refreshToken, forKey: .refreshToken)
    try container.encode(self.expirationTime, forKey: .expirationTime)
  }
  
  func isTokenValid() -> Bool {
    return expirationTime > Int(Date().timeIntervalSince1970)
  }
  
}

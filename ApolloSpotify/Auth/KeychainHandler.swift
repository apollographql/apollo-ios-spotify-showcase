import Foundation
import Security

class KeychainHandler {
  static let tokenService = "com.apollographql.spotify-showcase.service"
  static let tokenAccountTag = "com.apollographql.spotify-showcase.token"
  
  private static let baseQuery: [String: Any] = [
    kSecClass as String: kSecClassGenericPassword,
    kSecAttrAccount as String: tokenAccountTag,
    kSecAttrService as String: tokenService
  ]
  
  static func storeToken(_ token: AccessToken) throws -> Bool {
    let tokenData = try JSONEncoder().encode(token)
    var query = baseQuery
    query[kSecValueData as String] = tokenData
    
    let status = SecItemAdd(query as CFDictionary, nil)
    
    // if item already exists, update it instead
    if status == errSecDuplicateItem {
      let query = baseQuery
      let attributesToUpdate: [String: Any] = [kSecValueData as String: tokenData]
      
      let updateStatus = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
      
      if let errMsg = SecCopyErrorMessageString(updateStatus, nil) as? String{
          print(errMsg)
      }
      return updateStatus == errSecSuccess
    }

    return status == errSecSuccess
  }
  
  static func getToken() throws -> AccessToken? {
    var query = baseQuery
    query[kSecReturnData as String] = true
    
    var result: AnyObject?
    SecItemCopyMatching(query as CFDictionary, &result)
    
    guard let data = result as? Data else {
      return nil
    }
    
    let token = try JSONDecoder().decode(AccessToken.self, from: data)
    return token
  }
}

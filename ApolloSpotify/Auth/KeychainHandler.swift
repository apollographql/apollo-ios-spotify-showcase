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
  
  @discardableResult
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
  
  @discardableResult
  static func deleteToken() throws -> Bool {
    let query = baseQuery
    
    let status = SecItemDelete(query as CFDictionary)
    guard status == errSecSuccess || status == errSecItemNotFound else {
      return false
    }
    
    return true
  }
}

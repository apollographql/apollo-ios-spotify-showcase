import Foundation
import Apollo
import ApolloAPI

class AuthorizationInterceptor: ApolloInterceptor {
    var id: String = UUID().uuidString
  
    func interceptAsync<Operation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) where Operation : GraphQLOperation {
      Task {
        do {
          let accessToken = try await Network.shared.authManager.getAccessToken()
          request.addHeader(name: "Authorization", value: accessToken)
          
          chain.proceedAsync(
            request: request,
            response: response,
            interceptor: self,
            completion: completion
          )
        } catch {
          print("Authorization Interceptor Error - \(error)")
        }
      }
    }
    
}

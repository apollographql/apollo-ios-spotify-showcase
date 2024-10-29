import Foundation
import Apollo
import SpotifyAPI

class Network {
    
  static let shared = Network()

  let authManager = AuthManager()
  
  private(set) lazy var apollo: ApolloClient = {
    let client = URLSessionClient()
    let cache = InMemoryNormalizedCache()
    let store = ApolloStore(cache: cache)
    let provider = NetworkInterceptorProvider(client: client, store: store)
    let url = URL(string: "https://spotify-showcase-production.up.railway.app/")!
    let transport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)
    return ApolloClient(networkTransport: transport, store: store)
  }()
    
}

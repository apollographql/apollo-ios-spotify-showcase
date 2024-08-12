import SwiftUI
import SpotifyAPI
import Apollo

struct HomeView: View {
  
  @StateObject private var viewModel = HomeViewModel()
  
  var body: some View {

    VStack {
      Spacer()
      Text("Playlists")
        .font(.system(size: 18))
        .frame(alignment: .leading)
      PlaylistGridView(playlists: $viewModel.playlists, numItems: 6)
      
      Button("Get Profile") {
        
        Task {
          viewModel.fetchUserPlaylists()
        }
        
      }
      
      Spacer()
      
      Button("Clear Keychain") {
        _ = try? KeychainHandler.deleteToken()
      }
      
      Spacer()
    }
    
  }
}

//#Preview {
//    HomeView()
//}

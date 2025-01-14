import SwiftUI
import SpotifyAPI
import Apollo

struct HomeView: View {
  
  @StateObject private var viewModel = HomeViewModel()
  @State private var isNowPlayingPresented = false
  
  var body: some View {

    NavigationStack {
      VStack {
        Spacer()
        Text("Playlists")
          .font(.system(size: 18))
          .frame(alignment: .leading)
        PlaylistGridView(playlists: $viewModel.playlists, numItems: 6)
        
        Button("Get Playlists") {
          
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
      .background(Color(hex: "#212121"))
    }
    
  }
}

//#Preview {
//    HomeView()
//}

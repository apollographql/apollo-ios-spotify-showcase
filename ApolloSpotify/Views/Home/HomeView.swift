import SwiftUI
import SpotifyAPI
import Apollo

struct HomeView: View {
  
  @StateObject private var viewModel = HomeViewModel()
  
  var body: some View {

    VStack {
      Spacer()
//      if let playlist = viewModel.playlists.first {
//        HStack {
//          Spacer()
//          PlaylistCellView(playlist: playlist)
//            .frame(height: 60)
//          Spacer()
//        }
//      }
      
//      if viewModel.playlists.count > 0 {
      PlaylistGridView(playlists: $viewModel.playlists, numItems: 6)
//      }
      
      Button("Get Profile") {
        
        Task {
          viewModel.getUserProfile()
        }
        
      }
      
      Spacer()
    }
    
  }
}

//#Preview {
//    HomeView()
//}

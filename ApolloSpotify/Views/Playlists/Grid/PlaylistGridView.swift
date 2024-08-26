import SwiftUI
import Apollo
import SpotifyAPI

struct PlaylistGridView: View {
  
  @Binding var playlists: [PlaylistFragment]
  let numItems: Int

  let columns = [
    GridItem(.flexible(), spacing: 1),
    GridItem(.flexible())
  ]
  
  var body: some View {
    LazyVGrid(columns: columns, spacing: 1) {
      if !playlists.isEmpty {
        ForEach(playlists[0..<min(numItems, playlists.count)], id: \.self) { playlist in
          NavigationLink(destination: PlaylistView(playlistID: playlist.id)) {
            PlaylistGridCellView(playlist: playlist)
              .frame(height: 60)
              .frame(maxWidth: .infinity)
          }
          .navigationTitle("")
        }
      }
    }
  }
}

//#Preview {
//    PlaylistGridView(numItems: 6)
//}


import SwiftUI
import Apollo
import SpotifyAPI

struct PlaylistGridView: View {
  
  @Binding var playlists: [PlaylistFragment]
  let numItems: Int
//  let data = (1...100).map { "Item \($0)" }
  let columns = [
    GridItem(.flexible(), spacing: 1),
    GridItem(.flexible())
  ]
  
  var body: some View {
    LazyVGrid(columns: columns, spacing: 1) {
      if !playlists.isEmpty {
        ForEach(playlists[0..<min(numItems, playlists.count)], id: \.self) { playlist in
          PlaylistCellView(playlist: playlist)
            .frame(height: 60)
            .frame(maxWidth: .infinity)
        }
      }
    }
  }
}

//#Preview {
//    PlaylistGridView(numItems: 6)
//}


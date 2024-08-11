import SwiftUI
import SpotifyAPI

struct PlaylistCellView: View {
  
  let playlist: PlaylistFragment
  
  var body: some View {
    HStack {
      AsyncImage(url: URL(string: playlist.images?.last?.url ?? "")) { image in
        image.resizable().aspectRatio(contentMode: .fit)
      } placeholder: {
        Image(systemName: "music.note").resizable().aspectRatio(contentMode: .fit).padding(.all)
      }
      
      VStack {
        Spacer()
        Text(playlist.name)
          .font(.system(size: 12))
        Spacer()
      }
      
      Spacer()
    }
    .background(Color.init(hex: "212121"))
  }
}

//#Preview {
//    PlaylistCellView()
//}

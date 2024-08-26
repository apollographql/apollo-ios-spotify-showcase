import SwiftUI
import SpotifyAPI

struct PlaylistTrackCellView: View {
  
  let playlistTrack: PlaylistQuery.Data.Playlist.Tracks.Edge.Node
  
  var body: some View {
    HStack {
      AsyncImage(url: URL(string: playlistTrack.asTrack?.album.images.first?.url ?? "")) { image in
        image.resizable()
          .aspectRatio(contentMode: .fit)
      } placeholder: {
        Image(systemName: "music.note")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .padding(.all)
          .foregroundStyle(.white)
      }
      
      VStack {
        Spacer()
        Text(playlistTrack.name)
          .font(.system(size: 16))
          .fontWeight(.bold)
          .foregroundStyle(.white)
          .frame(maxWidth: .infinity, alignment: .leading)
        Text(playlistTrack.asTrack?.artists.first?.name ?? "Artist")
          .font(.system(size: 12))
          .foregroundStyle(.white)
          .frame(maxWidth: .infinity, alignment: .leading)
        Spacer()
      }
      
      Spacer()
    }
    .frame(height: 60)
    .background(Color.init(hex: "121212"))
  }
}

//#Preview {
//  PlaylistTrackCellView()
//}

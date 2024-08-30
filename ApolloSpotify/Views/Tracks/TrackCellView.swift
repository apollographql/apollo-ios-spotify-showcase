import SwiftUI
import SpotifyAPI

struct TrackCellView: View {
  
  let playlistTrack: TrackFragment
  
  var body: some View {
    HStack {
      AsyncImage(url: URL(string: playlistTrack.album.images.first?.url ?? "")) { image in
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
        Text(playlistTrack.artists.first?.name ?? "Artist")
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

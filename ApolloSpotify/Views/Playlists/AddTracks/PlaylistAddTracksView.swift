import SwiftUI
import SpotifyAPI

struct PlaylistAddTracksView: View {
  
  @Binding var isPresented: Bool
  @StateObject private var viewModel: PlaylistAddTracksViewModel
  @State private var searchText = ""
  
  private let playlistID: SpotifyAPI.ID
  
  init(
    isPresented: Binding<Bool>,
    playlistID: SpotifyAPI.ID,
    recommendationInput: RecommendationSeedInput,
    recommendationLimit: GraphQLNullable<Int> = .null
  ) {
    _isPresented = isPresented
    _viewModel = StateObject(wrappedValue: PlaylistAddTracksViewModel(
      recommendationInput: recommendationInput,
      recommendationLimit: recommendationLimit,
      playlistID: playlistID
    ))
    self.playlistID = playlistID
  }
  
  var body: some View {
    NavigationStack {
      recommendedSongView()
    }
    .padding(.all)
    .searchable(text: $searchText)
    .task {
      viewModel.fetchRecommendations()
    }

  }
  
  private func recommendedSongView() -> some View {
    VStack {
      Text("Suggested Songs")
        .font(.system(size: 16, weight: .bold))
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      List {
        ForEach(0..<viewModel.tracks.count, id: \.self) { index in
          TrackCellView(playlistTrack: viewModel.tracks[index])
            .listRowInsets(.init())
            .listRowSeparator(.hidden)
            .onTapGesture {
              print("Selected Track - \(viewModel.tracks[index].name)")
              viewModel.addTrackToPlaylist(viewModel.tracks[index])
            }
        }
      }
      .listStyle(.plain)
    }
    .padding(.all)
    .background(Color.init(hex: "121212"))
    .clipShape(.rect(cornerRadius: 8))
    
  }
  
}

//#Preview {
//    PlaylistAddTracksView()
//}

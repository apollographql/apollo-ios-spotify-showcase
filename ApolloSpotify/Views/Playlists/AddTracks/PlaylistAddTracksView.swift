import SwiftUI
import SpotifyAPI

struct PlaylistAddTracksView: View {
  
  @Binding var isPresented: Bool
  @StateObject private var viewModel: PlaylistAddTracksViewModel
  @State private var searchPresented: Bool = false
  
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
      VStack {
        Text(searchPresented ? "Search Results" : "Suggested Songs")
          .font(.system(size: 16, weight: .bold))
          .foregroundStyle(.white)
          .frame(maxWidth: .infinity, alignment: .leading)
        
        if searchPresented {
          searchTrackListView()
        } else {
          recommendedTrackListView()
        }
      }
      .padding(.all)
      .background(Color.init(hex: "121212"))
      .clipShape(.rect(cornerRadius: 8))
    }
    .padding(.all)
    .searchable(text: $viewModel.searchText, isPresented: $searchPresented)
    .onSubmit(of: .search) {
      guard !viewModel.searchText.isEmpty else {
        return
      }
      
      viewModel.searchCatalog(queryString: viewModel.searchText)
    }
    .onChange(of: searchPresented, { _, newValue in
      if !newValue {
        viewModel.cancelSearch()
      }
    })
    .task {
      viewModel.fetchRecommendations()
    }

  }
  
  private func recommendedTrackListView() -> some View {
    List {
      ForEach(0..<viewModel.recommendedTracks.count, id: \.self) { index in
        TrackCellView(
          playlistTrack: viewModel.recommendedTracks[index],
          actionProvider: actionProvider(forTrack: viewModel.recommendedTracks[index])
        )
          .listRowInsets(.init())
          .listRowSeparator(.hidden)
      }
    }
    .listStyle(.plain)
  }
  
  private func searchTrackListView() -> some View {
    List {
      ForEach(0..<viewModel.searchTracks.count, id: \.self) { index in
        TrackCellView(
          playlistTrack: viewModel.searchTracks[index],
          actionProvider: actionProvider(forTrack: viewModel.searchTracks[index])
        )
          .listRowInsets(.init())
          .listRowSeparator(.hidden)
      }
    }
    .listStyle(.plain)
  }
  
  private func actionProvider(forTrack track: TrackFragment) -> StateObject<AddTrackToPlaylistAction> {
    return StateObject(
      wrappedValue: AddTrackToPlaylistAction(
        playlistID: viewModel.playlistID,
        track: track
      )
    )
  }
  
}

//#Preview {
//    PlaylistAddTracksView()
//}

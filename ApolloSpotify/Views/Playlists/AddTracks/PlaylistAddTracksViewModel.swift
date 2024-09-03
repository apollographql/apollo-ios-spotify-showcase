import Foundation
import SpotifyAPI
import SwiftUI

class PlaylistAddTracksViewModel: ObservableObject {
  
  let recommendationInput: RecommendationSeedInput
  let recommendationLimit: GraphQLNullable<Int>
  let playlistID: SpotifyAPI.ID
  
  @Published var tracks = [TrackFragment]()
  
  init(
    recommendationInput: RecommendationSeedInput,
    recommendationLimit: GraphQLNullable<Int> = .null,
    playlistID: SpotifyAPI.ID
  ) {
    self.recommendationInput = recommendationInput
    self.recommendationLimit = recommendationLimit
    self.playlistID = playlistID
  }
  
  func fetchRecommendations() {
    Network.shared.apollo.fetch(
      query: RecommendationsQuery(
        seeds: recommendationInput,
        limit: recommendationLimit)
    ) { [weak self] result in
      switch result {
      case .success(let graphQLResult):
        if let tracks = graphQLResult.data?.recommendations?.tracks {
          self?.tracks = tracks.map { $0.fragments.trackFragment }
          
          for t in self!.tracks {
            print("Track - \(t.name)")
          }
        }
        
        if let errors = graphQLResult.errors {
          print("Recommendation track errors - \(errors)")
        }
      case .failure(let error):
          print("Recommendation error - \(error)")
      }
    }
  }
  
  func addTrackToPlaylist(_ track: TrackFragment) {
    let addTrackInput = AddItemsToPlaylistInput(
      playlistId: playlistID,
      uris: [track.uri]
    )
    
    Network.shared.apollo.perform(mutation: AddItemsToPlaylistMutation(input: addTrackInput)) { result in
      switch result {
      case .success(let graphQLResult):
        print("Successfully added track to playlist - \(graphQLResult.data?.addItemsToPlaylist?.playlist?.id)")
        
        if let errors = graphQLResult.errors {
          print("AddItemsToPlaylistMutation errors - \(errors)")
        }
      case .failure(let error):
        print("AddItemsToPlaylistMutation error - \(error)")
      }
    }
  }
  
}
  


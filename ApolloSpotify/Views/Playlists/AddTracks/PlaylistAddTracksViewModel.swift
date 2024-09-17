import Foundation
import SpotifyAPI
import SwiftUI

class PlaylistAddTracksViewModel: ObservableObject {
  
  let recommendationInput: RecommendationSeedInput
  let recommendationLimit: GraphQLNullable<Int>
  let playlistID: SpotifyAPI.ID
  
  @Published var recommendedTracks = [TrackFragment]()
  @Published var searchTracks = [TrackFragment]()
  @Published var searchText = ""
  
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
      guard let self = self else {
        return
      }
      
      switch result {
      case .success(let graphQLResult):
        if let tracks = graphQLResult.data?.recommendations?.tracks {
          self.recommendedTracks = tracks.map { $0.fragments.trackFragment }
          
          for t in self.recommendedTracks {
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
  
  func searchCatalog(
    queryString: String,
    limit: GraphQLNullable<Int> = .null
  ) {
    Network.shared.apollo.fetch(
      query: SearchQuery(
        q: queryString,
        type: [.init(SearchType.track)],
        limit: limit)
    ) { [weak self] result in
      switch result {
      case .success(let graphQLResult):
        if let tracks = graphQLResult.data?.search?.tracks?.edges {
          self?.searchTracks = tracks.map { $0.node.fragments.trackFragment }
          
          for t in self!.searchTracks {
            print("Search Track - \(t.name)")
          }
        }
        
        if let errors = graphQLResult.errors {
          print("Search track errors - \(errors)")
        }
      case .failure(let error):
          print("Search error - \(error)")
      }
    }
  }
  
  func cancelSearch() {
    self.searchTracks = []
  }
  
}
  


import Foundation
import SpotifyAPI
import SwiftUI

class PlaylistAddTracksViewModel: ObservableObject {
  
  let recommendationInput: RecommendationSeedInput
  let recommendationLimit: GraphQLNullable<Int>
  
  @Published var tracks = [TrackFragment]()
  
  init(
    recommendationInput: RecommendationSeedInput,
    recommendationLimit: GraphQLNullable<Int> = .null
  ) {
    self.recommendationInput = recommendationInput
    self.recommendationLimit = recommendationLimit
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
  
}
  


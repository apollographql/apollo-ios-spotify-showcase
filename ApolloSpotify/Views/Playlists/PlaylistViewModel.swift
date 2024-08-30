import Foundation
import SpotifyAPI
import SwiftUI

class PlaylistViewModel: ObservableObject {
  
  let playlistID: SpotifyAPI.ID
  
  @Published var playlistImageURL: URL?
  @Published var playlistName: String = ""
  @Published var playlistAuthor: String = ""
  @Published var playlistAuthorImageURL: URL?
  @Published var playlistLength: String = ""
  @Published var playlistTracks = [TrackFragment]() {
    didSet {
      let milliseconds = playlistTracks.reduce(0) { $0 + $1.durationMs }
      let interval = TimeInterval(milliseconds / 1000)
      playlistLength = interval.hoursAndMinutes
    }
  }
  
  private var playlist: PlaylistQuery.Data.Playlist? {
    didSet {
      self.playlistImageURL = URL(string: playlist?.images?.first?.url ?? "")
      self.playlistName = playlist?.name ?? ""
      self.playlistAuthor = playlist?.owner.displayName ?? ""
      self.playlistAuthorImageURL = URL(string: playlist?.owner.images?.first?.url ?? "")
      self.playlistTracks = playlist?.tracks.edges.compactMap { $0.node.asTrack?.fragments.trackFragment } ?? []
    }
  }
  
  init(playlistID: SpotifyAPI.ID) {
    self.playlistID = playlistID
  }
  
  func fetchPlaylist() {
    Network.shared.apollo.fetch(query: PlaylistQuery(playlistId: playlistID)) { [weak self] result in
      switch result {
      case .success(let graphQLResult):
        if let playlist = graphQLResult.data?.playlist {
          self?.playlist = playlist
        }
        
        if let errors = graphQLResult.errors {
          print("Playlist Query Errors - \(errors)")
        }
      case .failure(let error):
        print("Playlist Query Error - \(error)")
      }
    }
  }
  
  func getRecommendationInput() -> RecommendationSeedInput {
    var trackIDs = [SpotifyAPI.ID]()
    
    for i in 0..<min(5, playlistTracks.count) {
      trackIDs.append(playlistTracks[i].id)
    }
    
    return RecommendationSeedInput(seedTracks: .some(trackIDs))
  }
  
}

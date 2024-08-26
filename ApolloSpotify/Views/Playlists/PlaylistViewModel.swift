import Foundation
import SpotifyAPI
import SwiftUI

class PlaylistViewModel: ObservableObject {
  
  var playlistID: SpotifyAPI.ID
  
  @Published var playlistImageURL: URL?
  @Published var playlistName: String?
  @Published var playlistAuthor: String?
  @Published var playlistAuthorImageURL: URL?
  @Published var playlistLength: String = ""
  @Published var playlistTracks = [PlaylistQuery.Data.Playlist.Tracks.Edge]() {
    didSet {
      let milliseconds = playlistTracks.reduce(0) { $0 + $1.node.durationMs }
      let interval = TimeInterval(milliseconds / 1000)
      playlistLength = interval.hoursAndMinutes
    }
  }
  
  private var playlist: PlaylistQuery.Data.Playlist? {
    didSet {
      self.playlistImageURL = URL(string: playlist?.images?.first?.url ?? "")
      self.playlistName = playlist?.name
      self.playlistAuthor = playlist?.owner.displayName
      self.playlistAuthorImageURL = URL(string: playlist?.owner.images?.first?.url ?? "")
      self.playlistTracks = playlist?.tracks.edges ?? []
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
  
}

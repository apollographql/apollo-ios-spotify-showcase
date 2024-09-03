import Foundation
import Apollo
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
  
  private var playlistWatcher: GraphQLQueryWatcher<PlaylistQuery>?
  
  init(playlistID: SpotifyAPI.ID) {
    self.playlistID = playlistID
  }
  
  deinit {
    playlistWatcher?.cancel()
  }
  
  func fetchPlaylist() {
    playlistWatcher = Network.shared.apollo.watch(query: PlaylistQuery(playlistId: playlistID)) { [weak self] result in
      print("Playlist Query result handled")
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
  
  func removeTrackFromPlaylist(_ track: TrackFragment) {
    let removeTrackInput = RemoveItemFromPlaylistTrackInput(uri: track.uri)
    let removeFromPlaylistInput = RemoveItemFromPlaylistInput(
      playlistId: playlistID,
      tracks: [removeTrackInput]
    )
    
    Network.shared.apollo.perform(mutation: RemoveItemFromPlaylistMutation(input: removeFromPlaylistInput)) { [weak self] result in
      switch result {
      case .success(let graphQLResult):
        print("Successfully removed track from playlist - \(graphQLResult.data?.removeItemFromPlaylist?.playlist?.id)")
        self?.removeTrackFromLocalCache(track)
        
        if let errors = graphQLResult.errors {
          print("RemoveItemFromPlaylistMutation errors - \(errors)")
        }
      case .failure(let error):
        print("RemoveItemFromPlaylistMutation error - \(error)")
      }
    }
  }
  
  private func removeTrackFromLocalCache(_ track: TrackFragment) {
    Network.shared.apollo.store.withinReadWriteTransaction { [weak self] transaction in
      guard let self = self else {
        return
      }
      
      let cacheMutation = PlaylistEditNodeLocalCacheMutation(playlistId: self.playlistID)
      
      do {
        try transaction.update(cacheMutation) { (data: inout PlaylistEditNodeLocalCacheMutation.Data) in
          data.playlist?.tracks.edges.removeAll { $0.node.asTrack?.id == track.id }
        }
      } catch {
        print("Cache Mutation Error - \(error)")
      }
    }
  }
  
}

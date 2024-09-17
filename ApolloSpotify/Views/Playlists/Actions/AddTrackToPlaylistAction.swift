import Foundation
import SwiftUI
import SpotifyAPI

class AddTrackToPlaylistAction: ObservableObject, ActionViewProvider {
  
  let playlistID: SpotifyAPI.ID
  let track: TrackFragment
  
  private var actionComplete: Bool = false {
    didSet {
      self.objectWillChange.send()
    }
  }
  
  init(
    playlistID: SpotifyAPI.ID,
    track: TrackFragment
  ) {
    self.playlistID = playlistID
    self.track = track
  }
  
  var actionView: some View {
    Group {
      if !actionComplete {
        Button {
          self.addTrackToPlaylist()
        } label: {
          Image(systemName: "plus.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(.white)
        }
      } else {
        Image(systemName: "checkmark.circle")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .foregroundStyle(.white)
      }
    }
  }
  
  func addTrackToPlaylist() {
    let addTrackInput = AddItemsToPlaylistInput(
      playlistId: playlistID,
      uris: [track.uri]
    )
    
    Network.shared.apollo.perform(mutation: AddItemsToPlaylistMutation(input: addTrackInput)) { [weak self] result in
      switch result {
      case .success(let graphQLResult):
        print("Successfully added track to playlist - \(graphQLResult.data?.addItemsToPlaylist?.playlist?.id)")
        self?.actionComplete = true
        self?.addTrackToLocalCache()
        
        if let errors = graphQLResult.errors {
          print("AddItemsToPlaylistMutation errors - \(errors)")
        }
      case .failure(let error):
        print("AddItemsToPlaylistMutation error - \(error)")
      }
    }
  }
  
  
  private func addTrackToLocalCache() {
    Network.shared.apollo.store.withinReadWriteTransaction { [weak self] transaction in
      guard let self = self else {
        return
      }
      
      let cacheMutation = PlaylistEditNodeLocalCacheMutation(playlistId: self.playlistID)
      
      do {
        try transaction.update(cacheMutation) { (data: inout PlaylistEditNodeLocalCacheMutation.Data) in
          let asTrack = PlaylistEditNodeLocalCacheMutation.Data.Playlist.Tracks.Edge.Node.AsTrack(
            id: self.track.id,
            name: self.track.name,
            durationMs: self.track.durationMs,
            uri: self.track.uri,
            artists: self.track.artists,
            album: self.track.album
          )
          
          let edge = PlaylistEditNodeLocalCacheMutation.Data.Playlist.Tracks.Edge(node: asTrack.asRootEntityType)
          
          data.playlist?.tracks.edges.append(edge)
        }
      } catch {
        print("Cache Mutation Error - \(error)")
      }
    }
  }
  
}

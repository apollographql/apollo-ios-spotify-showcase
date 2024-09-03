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
    
    Network.shared.apollo.perform(mutation: AddItemsToPlaylistMutation(input: addTrackInput)) { [weak self] result in
      switch result {
      case .success(let graphQLResult):
        print("Successfully added track to playlist - \(graphQLResult.data?.addItemsToPlaylist?.playlist?.id)")
        self?.addTrackToLocalCache(track)
        
        if let errors = graphQLResult.errors {
          print("AddItemsToPlaylistMutation errors - \(errors)")
        }
      case .failure(let error):
        print("AddItemsToPlaylistMutation error - \(error)")
      }
    }
  }
  
  
  private func addTrackToLocalCache(_ track: TrackFragment) {
    Network.shared.apollo.store.withinReadWriteTransaction { [weak self] transaction in
      guard let self = self else {
        return
      }
      
      let cacheMutation = PlaylistEditNodeLocalCacheMutation(playlistId: self.playlistID)
      
      do {
        try transaction.update(cacheMutation) { (data: inout PlaylistEditNodeLocalCacheMutation.Data) in
          let asTrack = PlaylistEditNodeLocalCacheMutation.Data.Playlist.Tracks.Edge.Node.AsTrack(
            id: track.id,
            name: track.name,
            durationMs: track.durationMs,
            uri: track.uri,
            artists: track.artists,
            album: track.album
          )
          
          var node = PlaylistEditNodeLocalCacheMutation.Data.Playlist.Tracks.Edge.Node(__typename: "Track")
          node.asTrack = asTrack
          
          let edge = PlaylistEditNodeLocalCacheMutation.Data.Playlist.Tracks.Edge(node: node)
          
          data.playlist?.tracks.edges.append(edge)
          
          print("End Cache mutation")
        }
        
        let queryData = try transaction.read(
          query: PlaylistQuery(playlistId: playlistID)
        )
        
        print("End Cache Mutation Track Count - \(queryData.playlist?.tracks.edges.count)")
        print("End Cache Mutation Latest Track - \(queryData.playlist?.tracks.edges.last?.node.asTrack?.name)")
      } catch {
        print("Cache Mutation Error - \(error)")
      }
      
//      let queryData = try transaction.read(
//        query: Pl)
    }
  }
  
}
  


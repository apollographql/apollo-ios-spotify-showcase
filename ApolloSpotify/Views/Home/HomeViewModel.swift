import Foundation
import Apollo
import SpotifyAPI
import SwiftUI

class HomeViewModel: ObservableObject {
  
  @Published var playlists = [PlaylistFragment]()
  
  func fetchUserPlaylists() {
    Network.shared.apollo.fetch(query: UserPlaylistsQuery()) { [weak self] result in
      switch result {
      case .success(let graphQLResult):
        if let playlists = graphQLResult.data?.me?.playlists?.edges {
          if playlists.isEmpty {
            self?.fetchFeaturedPlaylists()
          } else {
            print("Playlist Count - \(playlists.count)")
            self?.playlists = playlists.map { $0.node.fragments.playlistFragment }
          }
        }
          
        if let errors = graphQLResult.errors {
          print("Playlist errors - \(errors)")
        }
      case .failure(let error):
          print("Playlist error - \(error)")
      }
    }
  }
  
  func fetchFeaturedPlaylists() {
    Network.shared.apollo.fetch(query: FeaturedPlaylistsQuery()) { result in
        switch result {
        case .success(let graphQLResult):
          if let playlists = graphQLResult.data?.featuredPlaylists?.edges {
            print("Feature Playlist Count - \(playlists.count)")
            for playlist in playlists {
              print("Playlist ID - \(playlist.node.id)")
              print("Playlist Name - \(playlist.node.name)")
              print("Playlist Images - \(playlist.node.images)")
            }
            self.playlists = playlists.map { $0.node.fragments.playlistFragment }
          }
            
          if let errors = graphQLResult.errors {
            print("Playlist errors - \(errors)")
          }
        case .failure(let error):
            print("Playlist error - \(error)")
        }
    }
  }
  
}

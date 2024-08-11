import Foundation
import SpotifyAPI
import SwiftUI

class HomeViewModel: ObservableObject {
  
  @Published var playlists = [PlaylistFragment]()
  
  init() {
    
  }
  
  func getUserProfile() {
    Network.shared.apollo.fetch(query: UserPlaylistsQuery()) { result in
        switch result {
        case .success(let graphQLResult):
          if let playlists = graphQLResult.data?.me?.playlists?.edges {
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

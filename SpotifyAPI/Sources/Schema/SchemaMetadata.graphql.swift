// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public typealias ID = String

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == SpotifyAPI.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == SpotifyAPI.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == SpotifyAPI.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == SpotifyAPI.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    switch typename {
    case "Query": return SpotifyAPI.Objects.Query
    case "CurrentUser": return SpotifyAPI.Objects.CurrentUser
    case "PlaylistConnection": return SpotifyAPI.Objects.PlaylistConnection
    case "PlaylistEdge": return SpotifyAPI.Objects.PlaylistEdge
    case "Playlist": return SpotifyAPI.Objects.Playlist
    case "Image": return SpotifyAPI.Objects.Image
    case "FeaturedPlaylistConnection": return SpotifyAPI.Objects.FeaturedPlaylistConnection
    case "FeaturedPlaylistEdge": return SpotifyAPI.Objects.FeaturedPlaylistEdge
    case "CurrentUserProfile": return SpotifyAPI.Objects.CurrentUserProfile
    case "User": return SpotifyAPI.Objects.User
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}

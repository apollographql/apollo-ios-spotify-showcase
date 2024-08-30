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
    case "Recommendations": return SpotifyAPI.Objects.Recommendations
    case "RecommendationSeed": return SpotifyAPI.Objects.RecommendationSeed
    case "Track": return SpotifyAPI.Objects.Track
    case "Episode": return SpotifyAPI.Objects.Episode
    case "Artist": return SpotifyAPI.Objects.Artist
    case "Album": return SpotifyAPI.Objects.Album
    case "Image": return SpotifyAPI.Objects.Image
    case "CurrentUser": return SpotifyAPI.Objects.CurrentUser
    case "PlaylistConnection": return SpotifyAPI.Objects.PlaylistConnection
    case "PlaylistEdge": return SpotifyAPI.Objects.PlaylistEdge
    case "Playlist": return SpotifyAPI.Objects.Playlist
    case "FeaturedPlaylistConnection": return SpotifyAPI.Objects.FeaturedPlaylistConnection
    case "FeaturedPlaylistEdge": return SpotifyAPI.Objects.FeaturedPlaylistEdge
    case "User": return SpotifyAPI.Objects.User
    case "CurrentUserProfile": return SpotifyAPI.Objects.CurrentUserProfile
    case "PlaylistTrackConnection": return SpotifyAPI.Objects.PlaylistTrackConnection
    case "PlaylistTrackEdge": return SpotifyAPI.Objects.PlaylistTrackEdge
    case "Show": return SpotifyAPI.Objects.Show
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}

// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct PlaylistFragment: SpotifyAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment PlaylistFragment on Playlist { __typename id name images { __typename url } }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Playlist }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", SpotifyAPI.ID.self),
    .field("name", String.self),
    .field("images", [Image]?.self),
  ] }

  /// The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids)
  /// for the playlist.
  public var id: SpotifyAPI.ID { __data["id"] }
  /// The name of the playlist.
  public var name: String { __data["name"] }
  /// Images for the playlist. The array may be empty or contain up to three images.
  /// The images are returned by size in descending order.
  /// See [Working with Playlists](https://developer.spotify.com/documentation/general/guides/working-with-playlists/).
  /// **Note**: If returned, the source URL for the image (`url`) is temporary and
  /// will expire in less than a day.
  public var images: [Image]? { __data["images"] }

  /// Image
  ///
  /// Parent Type: `Image`
  public struct Image: SpotifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Image }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("url", String.self),
    ] }

    /// The source URL of the image.
    public var url: String { __data["url"] }
  }
}

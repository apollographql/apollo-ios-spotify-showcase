// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct TrackFragment: SpotifyAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment TrackFragment on Track { __typename id name durationMs uri artists { __typename id name } album { __typename id images { __typename url } name } }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Track }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", SpotifyAPI.ID.self),
    .field("name", String.self),
    .field("durationMs", Int.self),
    .field("uri", String.self),
    .field("artists", [Artist].self),
    .field("album", Album.self),
  ] }

  /// The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the track.
  public var id: SpotifyAPI.ID { __data["id"] }
  /// The name of the track
  public var name: String { __data["name"] }
  /// The track length in milliseconds
  public var durationMs: Int { __data["durationMs"] }
  /// The [Spotify URI](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids)
  /// for the track.
  public var uri: String { __data["uri"] }
  /// The artists who performed the track.
  public var artists: [Artist] { __data["artists"] }
  /// The album on which the track appears.
  public var album: Album { __data["album"] }

  /// Artist
  ///
  /// Parent Type: `Artist`
  public struct Artist: SpotifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Artist }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("id", SpotifyAPI.ID.self),
      .field("name", String.self),
    ] }

    /// The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids)
    /// for the artist.
    public var id: SpotifyAPI.ID { __data["id"] }
    /// The name of the artist.
    public var name: String { __data["name"] }
  }

  /// Album
  ///
  /// Parent Type: `Album`
  public struct Album: SpotifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Album }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("id", SpotifyAPI.ID.self),
      .field("images", [Image].self),
      .field("name", String.self),
    ] }

    /// The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids)
    /// for the album.
    public var id: SpotifyAPI.ID { __data["id"] }
    /// The cover art for the album in various sizes, widest first.
    public var images: [Image] { __data["images"] }
    /// The name of the album. In case of an album takedown, the value may be an empty
    /// string.
    public var name: String { __data["name"] }

    /// Album.Image
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
}

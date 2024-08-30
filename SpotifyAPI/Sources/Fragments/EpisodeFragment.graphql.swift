// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct EpisodeFragment: SpotifyAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment EpisodeFragment on Episode { __typename id name durationMs uri show { __typename id name images { __typename url } } }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Episode }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", SpotifyAPI.ID.self),
    .field("name", String.self),
    .field("durationMs", Int.self),
    .field("uri", String.self),
    .field("show", Show.self),
  ] }

  /// The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the episode.
  public var id: SpotifyAPI.ID { __data["id"] }
  /// The name of the episode.
  public var name: String { __data["name"] }
  /// The episode length in milliseconds.
  public var durationMs: Int { __data["durationMs"] }
  /// The [Spotify URI](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids)
  /// for the episode.
  public var uri: String { __data["uri"] }
  /// The show containing the episode.
  public var show: Show { __data["show"] }

  /// Show
  ///
  /// Parent Type: `Show`
  public struct Show: SpotifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Show }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("id", SpotifyAPI.ID.self),
      .field("name", String.self),
      .field("images", [Image].self),
    ] }

    /// The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids)
    /// for the show.
    public var id: SpotifyAPI.ID { __data["id"] }
    /// The name of the episode.
    public var name: String { __data["name"] }
    /// The cover art for the show in various sizes, widest first.
    public var images: [Image] { __data["images"] }

    /// Show.Image
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

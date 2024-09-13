// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SearchQuery: GraphQLQuery {
  public static let operationName: String = "Search"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Search($q: String!, $type: [SearchType!]!, $limit: Int) { search(q: $q, type: $type, limit: $limit) { __typename tracks { __typename edges { __typename node { __typename ...TrackFragment } } } } }"#,
      fragments: [TrackFragment.self]
    ))

  public var q: String
  public var type: [GraphQLEnum<SearchType>]
  public var limit: GraphQLNullable<Int>

  public init(
    q: String,
    type: [GraphQLEnum<SearchType>],
    limit: GraphQLNullable<Int>
  ) {
    self.q = q
    self.type = type
    self.limit = limit
  }

  public var __variables: Variables? { [
    "q": q,
    "type": type,
    "limit": limit
  ] }

  public struct Data: SpotifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("search", Search?.self, arguments: [
        "q": .variable("q"),
        "type": .variable("type"),
        "limit": .variable("limit")
      ]),
    ] }

    /// Get Spotify catalog information about albums, artists, playlists, tracks, shows, episodes or audiobooks that match a keyword string.
    ///
    /// **Note: Audiobooks are only available for the US, UK, Ireland, New Zealand and Australia markets.**
    public var search: Search? { __data["search"] }

    /// Search
    ///
    /// Parent Type: `SearchResults`
    public struct Search: SpotifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.SearchResults }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("tracks", Tracks?.self),
      ] }

      /// The set of tracks returned from the search query. Only available if the search `type` includes `TRACK`.
      public var tracks: Tracks? { __data["tracks"] }

      /// Search.Tracks
      ///
      /// Parent Type: `SearchTracksConnection`
      public struct Tracks: SpotifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.SearchTracksConnection }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("edges", [Edge].self),
        ] }

        /// The list of tracks returned from the search
        public var edges: [Edge] { __data["edges"] }

        /// Search.Tracks.Edge
        ///
        /// Parent Type: `SearchTrackEdge`
        public struct Edge: SpotifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.SearchTrackEdge }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("node", Node.self),
          ] }

          /// The track returned in the search
          public var node: Node { __data["node"] }

          /// Search.Tracks.Edge.Node
          ///
          /// Parent Type: `Track`
          public struct Node: SpotifyAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Track }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .fragment(TrackFragment.self),
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
            public var artists: [TrackFragment.Artist] { __data["artists"] }
            /// The album on which the track appears.
            public var album: TrackFragment.Album { __data["album"] }

            public struct Fragments: FragmentContainer {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public var trackFragment: TrackFragment { _toFragment() }
            }
          }
        }
      }
    }
  }
}

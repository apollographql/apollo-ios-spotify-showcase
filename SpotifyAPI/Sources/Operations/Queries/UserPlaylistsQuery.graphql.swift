// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UserPlaylistsQuery: GraphQLQuery {
  public static let operationName: String = "UserPlaylists"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query UserPlaylists { me { __typename playlists { __typename edges { __typename node { __typename ...PlaylistFragment } } } } }"#,
      fragments: [PlaylistFragment.self]
    ))

  public init() {}

  public struct Data: SpotifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("me", Me?.self),
    ] }

    /// Information about the current logged-in user.
    public var me: Me? { __data["me"] }

    /// Me
    ///
    /// Parent Type: `CurrentUser`
    public struct Me: SpotifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.CurrentUser }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("playlists", Playlists?.self),
      ] }

      /// Playlists owned or followed by the current Spotify user.
      public var playlists: Playlists? { __data["playlists"] }

      /// Me.Playlists
      ///
      /// Parent Type: `PlaylistConnection`
      public struct Playlists: SpotifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.PlaylistConnection }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("edges", [Edge].self),
        ] }

        /// The set of playlists.
        public var edges: [Edge] { __data["edges"] }

        /// Me.Playlists.Edge
        ///
        /// Parent Type: `PlaylistEdge`
        public struct Edge: SpotifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.PlaylistEdge }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("node", Node.self),
          ] }

          /// The playlist
          public var node: Node { __data["node"] }

          /// Me.Playlists.Edge.Node
          ///
          /// Parent Type: `Playlist`
          public struct Node: SpotifyAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Playlist }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .fragment(PlaylistFragment.self),
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
            public var images: [PlaylistFragment.Image]? { __data["images"] }

            public struct Fragments: FragmentContainer {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public var playlistFragment: PlaylistFragment { _toFragment() }
            }
          }
        }
      }
    }
  }
}

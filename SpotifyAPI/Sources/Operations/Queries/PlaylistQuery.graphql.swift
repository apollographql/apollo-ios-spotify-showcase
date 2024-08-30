// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class PlaylistQuery: GraphQLQuery {
  public static let operationName: String = "Playlist"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Playlist($playlistId: ID!) { playlist(id: $playlistId) { __typename id name owner { __typename displayName id images { __typename url } } images { __typename url } tracks { __typename edges { __typename addedAt node { __typename ...EpisodeFragment ...TrackFragment } } } } }"#,
      fragments: [EpisodeFragment.self, TrackFragment.self]
    ))

  public var playlistId: ID

  public init(playlistId: ID) {
    self.playlistId = playlistId
  }

  public var __variables: Variables? { ["playlistId": playlistId] }

  public struct Data: SpotifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("playlist", Playlist?.self, arguments: ["id": .variable("playlistId")]),
    ] }

    /// A playlist owned by a Spotify user.
    public var playlist: Playlist? { __data["playlist"] }

    /// Playlist
    ///
    /// Parent Type: `Playlist`
    public struct Playlist: SpotifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Playlist }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", SpotifyAPI.ID.self),
        .field("name", String.self),
        .field("owner", Owner.self),
        .field("images", [Image]?.self),
        .field("tracks", Tracks.self),
      ] }

      /// The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids)
      /// for the playlist.
      public var id: SpotifyAPI.ID { __data["id"] }
      /// The name of the playlist.
      public var name: String { __data["name"] }
      /// The user who owns the playlist.
      public var owner: Owner { __data["owner"] }
      /// Images for the playlist. The array may be empty or contain up to three images.
      /// The images are returned by size in descending order.
      /// See [Working with Playlists](https://developer.spotify.com/documentation/general/guides/working-with-playlists/).
      /// **Note**: If returned, the source URL for the image (`url`) is temporary and
      /// will expire in less than a day.
      public var images: [Image]? { __data["images"] }
      /// The tracks of the playlist.
      public var tracks: Tracks { __data["tracks"] }

      /// Playlist.Owner
      ///
      /// Parent Type: `User`
      public struct Owner: SpotifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("displayName", String?.self),
          .field("id", SpotifyAPI.ID.self),
          .field("images", [Image]?.self),
        ] }

        /// The name displayed on the user's profile. `null` if not available.
        public var displayName: String? { __data["displayName"] }
        /// The [Spotify user ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for this user.
        public var id: SpotifyAPI.ID { __data["id"] }
        /// The user's profile image.
        public var images: [Image]? { __data["images"] }

        /// Playlist.Owner.Image
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

      /// Playlist.Image
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

      /// Playlist.Tracks
      ///
      /// Parent Type: `PlaylistTrackConnection`
      public struct Tracks: SpotifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.PlaylistTrackConnection }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("edges", [Edge].self),
        ] }

        /// Pagination information for the tracks belonging to a playlist
        public var edges: [Edge] { __data["edges"] }

        /// Playlist.Tracks.Edge
        ///
        /// Parent Type: `PlaylistTrackEdge`
        public struct Edge: SpotifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.PlaylistTrackEdge }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("addedAt", SpotifyAPI.DateTime?.self),
            .field("node", Node.self),
          ] }

          /// The date and time the track was added to the playlist
          public var addedAt: SpotifyAPI.DateTime? { __data["addedAt"] }
          /// The playlist track
          public var node: Node { __data["node"] }

          /// Playlist.Tracks.Edge.Node
          ///
          /// Parent Type: `PlaylistTrack`
          public struct Node: SpotifyAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Interfaces.PlaylistTrack }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .inlineFragment(AsEpisode.self),
              .inlineFragment(AsTrack.self),
            ] }

            public var asEpisode: AsEpisode? { _asInlineFragment() }
            public var asTrack: AsTrack? { _asInlineFragment() }

            /// Playlist.Tracks.Edge.Node.AsEpisode
            ///
            /// Parent Type: `Episode`
            public struct AsEpisode: SpotifyAPI.InlineFragment {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public typealias RootEntityType = PlaylistQuery.Data.Playlist.Tracks.Edge.Node
              public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Episode }
              public static var __selections: [ApolloAPI.Selection] { [
                .fragment(EpisodeFragment.self),
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
              public var show: EpisodeFragment.Show { __data["show"] }

              public struct Fragments: FragmentContainer {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public var episodeFragment: EpisodeFragment { _toFragment() }
              }
            }

            /// Playlist.Tracks.Edge.Node.AsTrack
            ///
            /// Parent Type: `Track`
            public struct AsTrack: SpotifyAPI.InlineFragment {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public typealias RootEntityType = PlaylistQuery.Data.Playlist.Tracks.Edge.Node
              public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Track }
              public static var __selections: [ApolloAPI.Selection] { [
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
}

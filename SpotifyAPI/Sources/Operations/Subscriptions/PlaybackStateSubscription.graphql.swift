// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class PlaybackStateSubscription: GraphQLSubscription {
  public static let operationName: String = "PlaybackState"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"subscription PlaybackState { playbackStateChanged { __typename context { __typename uri type } device { __typename id isActive name type } isPlaying progressMs repeatState shuffleState timestamp item { __typename ...EpisodeFragment ...TrackFragment } } }"#,
      fragments: [EpisodeFragment.self, TrackFragment.self]
    ))

  public init() {}

  public struct Data: SpotifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Subscription }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("playbackStateChanged", PlaybackStateChanged?.self),
    ] }

    public var playbackStateChanged: PlaybackStateChanged? { __data["playbackStateChanged"] }

    /// PlaybackStateChanged
    ///
    /// Parent Type: `PlaybackState`
    public struct PlaybackStateChanged: SpotifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.PlaybackState }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("context", Context?.self),
        .field("device", Device.self),
        .field("isPlaying", Bool.self),
        .field("progressMs", Int?.self),
        .field("repeatState", GraphQLEnum<SpotifyAPI.RepeatMode>.self),
        .field("shuffleState", Bool.self),
        .field("timestamp", SpotifyAPI.Timestamp.self),
        .field("item", Item?.self),
      ] }

      /// A context object.
      public var context: Context? { __data["context"] }
      /// The device that is currently active.
      public var device: Device { __data["device"] }
      /// If something is currently playing, return `true`.
      public var isPlaying: Bool { __data["isPlaying"] }
      /// Progress into the currently playing track or episode. Can be `null`
      public var progressMs: Int? { __data["progressMs"] }
      /// off, track, context
      public var repeatState: GraphQLEnum<SpotifyAPI.RepeatMode> { __data["repeatState"] }
      /// If shuffle is on or off.
      public var shuffleState: Bool { __data["shuffleState"] }
      /// Unix Millisecond Timestamp when data was fetched.
      public var timestamp: SpotifyAPI.Timestamp { __data["timestamp"] }
      /// The currently playing track or episode
      public var item: Item? { __data["item"] }

      /// PlaybackStateChanged.Context
      ///
      /// Parent Type: `PlaybackContext`
      public struct Context: SpotifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.PlaybackContext }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("uri", String.self),
          .field("type", GraphQLEnum<SpotifyAPI.PlaybackContextType>.self),
        ] }

        /// The [Spotify URI](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids)
        /// for the context.
        public var uri: String { __data["uri"] }
        /// The object type, e.g. "artist", "playlist", "album", "show".
        public var type: GraphQLEnum<SpotifyAPI.PlaybackContextType> { __data["type"] }
      }

      /// PlaybackStateChanged.Device
      ///
      /// Parent Type: `Device`
      public struct Device: SpotifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Device }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", SpotifyAPI.ID?.self),
          .field("isActive", Bool.self),
          .field("name", String.self),
          .field("type", String.self),
        ] }

        /// The device ID
        public var id: SpotifyAPI.ID? { __data["id"] }
        /// If this device is the currently active device.
        public var isActive: Bool { __data["isActive"] }
        /// A human-readable name for the device. Some devices have a name that the user
        /// can configure (e.g. "Loudest speaker") and some devices have a generic name
        /// associated with the manufacturer or device model.
        public var name: String { __data["name"] }
        /// Device type, such as "computer", "smartphone" or "speaker".
        public var type: String { __data["type"] }
      }

      /// PlaybackStateChanged.Item
      ///
      /// Parent Type: `PlaybackItem`
      public struct Item: SpotifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Interfaces.PlaybackItem }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .inlineFragment(AsEpisode.self),
          .inlineFragment(AsTrack.self),
        ] }

        public var asEpisode: AsEpisode? { _asInlineFragment() }
        public var asTrack: AsTrack? { _asInlineFragment() }

        /// PlaybackStateChanged.Item.AsEpisode
        ///
        /// Parent Type: `Episode`
        public struct AsEpisode: SpotifyAPI.InlineFragment {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public typealias RootEntityType = PlaybackStateSubscription.Data.PlaybackStateChanged.Item
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

        /// PlaybackStateChanged.Item.AsTrack
        ///
        /// Parent Type: `Track`
        public struct AsTrack: SpotifyAPI.InlineFragment {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public typealias RootEntityType = PlaybackStateSubscription.Data.PlaybackStateChanged.Item
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

// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class RecommendationsQuery: GraphQLQuery {
  public static let operationName: String = "Recommendations"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Recommendations($seeds: RecommendationSeedInput!, $limit: Int) { recommendations(seeds: $seeds, limit: $limit) { __typename seeds { __typename id initialPoolSize } tracks { __typename ...TrackFragment } } }"#,
      fragments: [TrackFragment.self]
    ))

  public var seeds: RecommendationSeedInput
  public var limit: GraphQLNullable<Int>

  public init(
    seeds: RecommendationSeedInput,
    limit: GraphQLNullable<Int>
  ) {
    self.seeds = seeds
    self.limit = limit
  }

  public var __variables: Variables? { [
    "seeds": seeds,
    "limit": limit
  ] }

  public struct Data: SpotifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("recommendations", Recommendations?.self, arguments: [
        "seeds": .variable("seeds"),
        "limit": .variable("limit")
      ]),
    ] }

    /// Recommendations for the current user.
    ///
    /// Recommendations are generated based on the available information for a given
    /// seed entity and matched against similar artists and tracks. If there is
    /// sufficient information about the provided seeds, a list of tracks will be
    /// returned together with pool size details.
    ///
    /// For artists and tracks that are very new or obscure there might not be enough
    /// data to generate a list of tracks.
    public var recommendations: Recommendations? { __data["recommendations"] }

    /// Recommendations
    ///
    /// Parent Type: `Recommendations`
    public struct Recommendations: SpotifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Recommendations }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("seeds", [Seed].self),
        .field("tracks", [Track].self),
      ] }

      /// An array of recommendation [seed objects](https://developer.spotify.com/documentation/web-api/reference/#object-recommendationseedobject).
      public var seeds: [Seed] { __data["seeds"] }
      /// An array of [track object (simplified)](https://developer.spotify.com/documentation/web-api/reference/#object-simplifiedtrackobject)
      /// ordered according to the parameters supplied.
      public var tracks: [Track] { __data["tracks"] }

      /// Recommendations.Seed
      ///
      /// Parent Type: `RecommendationSeed`
      public struct Seed: SpotifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.RecommendationSeed }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", SpotifyAPI.ID.self),
          .field("initialPoolSize", Int.self),
        ] }

        /// The id used to select this seed. This will be the same as the string used in
        /// the `seedArtists`, `seedTracks` or `seedGenres` parameter.
        public var id: SpotifyAPI.ID { __data["id"] }
        /// The number of recommended tracks available for this seed.
        public var initialPoolSize: Int { __data["initialPoolSize"] }
      }

      /// Recommendations.Track
      ///
      /// Parent Type: `Track`
      public struct Track: SpotifyAPI.SelectionSet {
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

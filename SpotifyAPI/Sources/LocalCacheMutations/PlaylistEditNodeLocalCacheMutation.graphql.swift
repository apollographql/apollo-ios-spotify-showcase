// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class PlaylistEditNodeLocalCacheMutation: LocalCacheMutation {
  public static let operationType: GraphQLOperationType = .query

  public var playlistId: ID

  public init(playlistId: ID) {
    self.playlistId = playlistId
  }

  public var __variables: GraphQLOperation.Variables? { ["playlistId": playlistId] }

  public struct Data: SpotifyAPI.MutableSelectionSet {
    public var __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("playlist", Playlist?.self, arguments: ["id": .variable("playlistId")]),
    ] }

    /// A playlist owned by a Spotify user.
    public var playlist: Playlist? {
      get { __data["playlist"] }
      set { __data["playlist"] = newValue }
    }

    public init(
      playlist: Playlist? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SpotifyAPI.Objects.Query.typename,
          "playlist": playlist._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(PlaylistEditNodeLocalCacheMutation.Data.self)
        ]
      ))
    }

    /// Playlist
    ///
    /// Parent Type: `Playlist`
    public struct Playlist: SpotifyAPI.MutableSelectionSet {
      public var __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Playlist }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", SpotifyAPI.ID.self),
        .field("tracks", Tracks.self),
      ] }

      /// The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids)
      /// for the playlist.
      public var id: SpotifyAPI.ID {
        get { __data["id"] }
        set { __data["id"] = newValue }
      }
      /// The tracks of the playlist.
      public var tracks: Tracks {
        get { __data["tracks"] }
        set { __data["tracks"] = newValue }
      }

      public init(
        id: SpotifyAPI.ID,
        tracks: Tracks
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SpotifyAPI.Objects.Playlist.typename,
            "id": id,
            "tracks": tracks._fieldData,
          ],
          fulfilledFragments: [
            ObjectIdentifier(PlaylistEditNodeLocalCacheMutation.Data.Playlist.self)
          ]
        ))
      }

      /// Playlist.Tracks
      ///
      /// Parent Type: `PlaylistTrackConnection`
      public struct Tracks: SpotifyAPI.MutableSelectionSet {
        public var __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.PlaylistTrackConnection }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("edges", [Edge].self),
        ] }

        /// Pagination information for the tracks belonging to a playlist
        public var edges: [Edge] {
          get { __data["edges"] }
          set { __data["edges"] = newValue }
        }

        public init(
          edges: [Edge]
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": SpotifyAPI.Objects.PlaylistTrackConnection.typename,
              "edges": edges._fieldData,
            ],
            fulfilledFragments: [
              ObjectIdentifier(PlaylistEditNodeLocalCacheMutation.Data.Playlist.Tracks.self)
            ]
          ))
        }

        /// Playlist.Tracks.Edge
        ///
        /// Parent Type: `PlaylistTrackEdge`
        public struct Edge: SpotifyAPI.MutableSelectionSet {
          public var __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.PlaylistTrackEdge }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("addedAt", SpotifyAPI.DateTime?.self),
            .field("node", Node.self),
          ] }

          /// The date and time the track was added to the playlist
          public var addedAt: SpotifyAPI.DateTime? {
            get { __data["addedAt"] }
            set { __data["addedAt"] = newValue }
          }
          /// The playlist track
          public var node: Node {
            get { __data["node"] }
            set { __data["node"] = newValue }
          }

          public init(
            addedAt: SpotifyAPI.DateTime? = nil,
            node: Node
          ) {
            self.init(_dataDict: DataDict(
              data: [
                "__typename": SpotifyAPI.Objects.PlaylistTrackEdge.typename,
                "addedAt": addedAt,
                "node": node._fieldData,
              ],
              fulfilledFragments: [
                ObjectIdentifier(PlaylistEditNodeLocalCacheMutation.Data.Playlist.Tracks.Edge.self)
              ]
            ))
          }

          /// Playlist.Tracks.Edge.Node
          ///
          /// Parent Type: `PlaylistTrack`
          public struct Node: SpotifyAPI.MutableSelectionSet {
            public var __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Interfaces.PlaylistTrack }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .inlineFragment(AsEpisode.self),
              .inlineFragment(AsTrack.self),
            ] }

            public var asEpisode: AsEpisode? {
              get { _asInlineFragment() }
              set { if let newData = newValue?.__data._data { __data._data = newData }}
            }
            public var asTrack: AsTrack? {
              get { _asInlineFragment() }
              set { if let newData = newValue?.__data._data { __data._data = newData }}
            }

            public init(
              __typename: String
            ) {
              self.init(_dataDict: DataDict(
                data: [
                  "__typename": __typename,
                ],
                fulfilledFragments: [
                  ObjectIdentifier(PlaylistEditNodeLocalCacheMutation.Data.Playlist.Tracks.Edge.Node.self)
                ]
              ))
            }

            /// Playlist.Tracks.Edge.Node.AsEpisode
            ///
            /// Parent Type: `Episode`
            public struct AsEpisode: SpotifyAPI.MutableInlineFragment {
              public var __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public typealias RootEntityType = PlaylistEditNodeLocalCacheMutation.Data.Playlist.Tracks.Edge.Node
              public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Episode }
              public static var __selections: [ApolloAPI.Selection] { [
                .fragment(EpisodeFragment.self),
              ] }

              /// The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the episode.
              public var id: SpotifyAPI.ID {
                get { __data["id"] }
                set { __data["id"] = newValue }
              }
              /// The name of the episode.
              public var name: String {
                get { __data["name"] }
                set { __data["name"] = newValue }
              }
              /// The episode length in milliseconds.
              public var durationMs: Int {
                get { __data["durationMs"] }
                set { __data["durationMs"] = newValue }
              }
              /// The [Spotify URI](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids)
              /// for the episode.
              public var uri: String {
                get { __data["uri"] }
                set { __data["uri"] = newValue }
              }
              /// The show containing the episode.
              public var show: EpisodeFragment.Show {
                get { __data["show"] }
                set { __data["show"] = newValue }
              }

              public struct Fragments: FragmentContainer {
                public var __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public var episodeFragment: EpisodeFragment {
                  get { _toFragment() }
                  _modify { var f = episodeFragment; yield &f; __data = f.__data }
                  @available(*, unavailable, message: "mutate properties of the fragment instead.")
                  set { preconditionFailure() }
                }
              }

              public init(
                id: SpotifyAPI.ID,
                name: String,
                durationMs: Int,
                uri: String,
                show: EpisodeFragment.Show
              ) {
                self.init(_dataDict: DataDict(
                  data: [
                    "__typename": SpotifyAPI.Objects.Episode.typename,
                    "id": id,
                    "name": name,
                    "durationMs": durationMs,
                    "uri": uri,
                    "show": show._fieldData,
                  ],
                  fulfilledFragments: [
                    ObjectIdentifier(PlaylistEditNodeLocalCacheMutation.Data.Playlist.Tracks.Edge.Node.self),
                    ObjectIdentifier(PlaylistEditNodeLocalCacheMutation.Data.Playlist.Tracks.Edge.Node.AsEpisode.self),
                    ObjectIdentifier(EpisodeFragment.self)
                  ]
                ))
              }
            }

            /// Playlist.Tracks.Edge.Node.AsTrack
            ///
            /// Parent Type: `Track`
            public struct AsTrack: SpotifyAPI.MutableInlineFragment {
              public var __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public typealias RootEntityType = PlaylistEditNodeLocalCacheMutation.Data.Playlist.Tracks.Edge.Node
              public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Track }
              public static var __selections: [ApolloAPI.Selection] { [
                .fragment(TrackFragment.self),
              ] }

              /// The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the track.
              public var id: SpotifyAPI.ID {
                get { __data["id"] }
                set { __data["id"] = newValue }
              }
              /// The name of the track
              public var name: String {
                get { __data["name"] }
                set { __data["name"] = newValue }
              }
              /// The track length in milliseconds
              public var durationMs: Int {
                get { __data["durationMs"] }
                set { __data["durationMs"] = newValue }
              }
              /// The [Spotify URI](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids)
              /// for the track.
              public var uri: String {
                get { __data["uri"] }
                set { __data["uri"] = newValue }
              }
              /// The artists who performed the track.
              public var artists: [TrackFragment.Artist] {
                get { __data["artists"] }
                set { __data["artists"] = newValue }
              }
              /// The album on which the track appears.
              public var album: TrackFragment.Album {
                get { __data["album"] }
                set { __data["album"] = newValue }
              }

              public struct Fragments: FragmentContainer {
                public var __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public var trackFragment: TrackFragment {
                  get { _toFragment() }
                  _modify { var f = trackFragment; yield &f; __data = f.__data }
                  @available(*, unavailable, message: "mutate properties of the fragment instead.")
                  set { preconditionFailure() }
                }
              }

              public init(
                id: SpotifyAPI.ID,
                name: String,
                durationMs: Int,
                uri: String,
                artists: [TrackFragment.Artist],
                album: TrackFragment.Album
              ) {
                self.init(_dataDict: DataDict(
                  data: [
                    "__typename": SpotifyAPI.Objects.Track.typename,
                    "id": id,
                    "name": name,
                    "durationMs": durationMs,
                    "uri": uri,
                    "artists": artists._fieldData,
                    "album": album._fieldData,
                  ],
                  fulfilledFragments: [
                    ObjectIdentifier(PlaylistEditNodeLocalCacheMutation.Data.Playlist.Tracks.Edge.Node.self),
                    ObjectIdentifier(PlaylistEditNodeLocalCacheMutation.Data.Playlist.Tracks.Edge.Node.AsTrack.self),
                    ObjectIdentifier(TrackFragment.self)
                  ]
                ))
              }
            }
          }
        }
      }
    }
  }
}

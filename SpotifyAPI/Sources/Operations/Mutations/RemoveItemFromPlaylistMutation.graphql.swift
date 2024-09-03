// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class RemoveItemFromPlaylistMutation: GraphQLMutation {
  public static let operationName: String = "RemoveItemFromPlaylist"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation RemoveItemFromPlaylist($input: RemoveItemFromPlaylistInput!) { removeItemFromPlaylist(input: $input) { __typename playlist { __typename id } } }"#
    ))

  public var input: RemoveItemFromPlaylistInput

  public init(input: RemoveItemFromPlaylistInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: SpotifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("removeItemFromPlaylist", RemoveItemFromPlaylist?.self, arguments: ["input": .variable("input")]),
    ] }

    /// Remove one or more items from a user's playlist.
    public var removeItemFromPlaylist: RemoveItemFromPlaylist? { __data["removeItemFromPlaylist"] }

    /// RemoveItemFromPlaylist
    ///
    /// Parent Type: `RemoveItemFromPlaylistPayload`
    public struct RemoveItemFromPlaylist: SpotifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.RemoveItemFromPlaylistPayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("playlist", Playlist?.self),
      ] }

      /// The playlist after the item was removed
      public var playlist: Playlist? { __data["playlist"] }

      /// RemoveItemFromPlaylist.Playlist
      ///
      /// Parent Type: `Playlist`
      public struct Playlist: SpotifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Playlist }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", SpotifyAPI.ID.self),
        ] }

        /// The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids)
        /// for the playlist.
        public var id: SpotifyAPI.ID { __data["id"] }
      }
    }
  }
}

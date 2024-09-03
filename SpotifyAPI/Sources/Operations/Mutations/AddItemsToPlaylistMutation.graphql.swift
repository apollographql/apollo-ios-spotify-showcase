// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class AddItemsToPlaylistMutation: GraphQLMutation {
  public static let operationName: String = "AddItemsToPlaylist"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation AddItemsToPlaylist($input: AddItemsToPlaylistInput!) { addItemsToPlaylist(input: $input) { __typename playlist { __typename id } } }"#
    ))

  public var input: AddItemsToPlaylistInput

  public init(input: AddItemsToPlaylistInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: SpotifyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("addItemsToPlaylist", AddItemsToPlaylist?.self, arguments: ["input": .variable("input")]),
    ] }

    /// Add one or more items to a user's playlist.
    public var addItemsToPlaylist: AddItemsToPlaylist? { __data["addItemsToPlaylist"] }

    /// AddItemsToPlaylist
    ///
    /// Parent Type: `AddItemsToPlaylistPayload`
    public struct AddItemsToPlaylist: SpotifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.AddItemsToPlaylistPayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("playlist", Playlist?.self),
      ] }

      /// The playlist that contains the newly added items
      public var playlist: Playlist? { __data["playlist"] }

      /// AddItemsToPlaylist.Playlist
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

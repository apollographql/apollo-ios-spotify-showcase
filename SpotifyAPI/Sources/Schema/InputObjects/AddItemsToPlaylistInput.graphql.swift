// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct AddItemsToPlaylistInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    playlistId: ID,
    uris: [String],
    position: GraphQLNullable<Int> = nil
  ) {
    __data = InputDict([
      "playlistId": playlistId,
      "uris": uris,
      "position": position
    ])
  }

  /// The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids)
  /// of the playlist.
  public var playlistId: ID {
    get { __data["playlistId"] }
    set { __data["playlistId"] = newValue }
  }

  /// A comma-separated list of [Spotify URIs](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids)
  /// to add, can be track or episode URIs. A maximum of 100 items can be added in
  /// one request.
  public var uris: [String] {
    get { __data["uris"] }
    set { __data["uris"] = newValue }
  }

  /// The position to insert the items, a zero-based index. For example, to insert
  /// the items in the first position: **position=0**; to insert the items in the
  /// third position: **position=2**. If omitted, the items will be appended to the
  /// playlist. Items are added in the order they are listed in the query string or
  /// request body.
  public var position: GraphQLNullable<Int> {
    get { __data["position"] }
    set { __data["position"] = newValue }
  }
}

// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct RemoveItemFromPlaylistInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    playlistId: ID,
    snapshotId: GraphQLNullable<ID> = nil,
    tracks: [RemoveItemFromPlaylistTrackInput]
  ) {
    __data = InputDict([
      "playlistId": playlistId,
      "snapshotId": snapshotId,
      "tracks": tracks
    ])
  }

  /// The [Spotify ID](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids)
  /// of the playlist.
  public var playlistId: ID {
    get { __data["playlistId"] }
    set { __data["playlistId"] = newValue }
  }

  /// The playlist's snapshot ID against which you want to make the changes. The API
  /// will validate that the specified items exist and in the specified positions
  /// and make the changes, even if more recent changes have been made to the
  /// playlist.
  public var snapshotId: GraphQLNullable<ID> {
    get { __data["snapshotId"] }
    set { __data["snapshotId"] = newValue }
  }

  /// An array of objects containing [Spotify URIs](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids)
  /// of the tracks or episodes to remove.
  public var tracks: [RemoveItemFromPlaylistTrackInput] {
    get { __data["tracks"] }
    set { __data["tracks"] = newValue }
  }
}

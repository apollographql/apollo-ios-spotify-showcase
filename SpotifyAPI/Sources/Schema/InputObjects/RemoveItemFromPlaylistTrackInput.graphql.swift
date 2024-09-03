// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct RemoveItemFromPlaylistTrackInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    uri: String
  ) {
    __data = InputDict([
      "uri": uri
    ])
  }

  public var uri: String {
    get { __data["uri"] }
    set { __data["uri"] = newValue }
  }
}

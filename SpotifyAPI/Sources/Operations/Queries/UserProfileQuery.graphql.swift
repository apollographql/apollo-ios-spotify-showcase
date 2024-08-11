// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UserProfileQuery: GraphQLQuery {
  public static let operationName: String = "UserProfile"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query UserProfile { me { __typename profile { __typename id displayName images { __typename url } } } }"#
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
        .field("profile", Profile.self),
      ] }

      /// Get detailed profile information about the current user (including the current user's username).
      public var profile: Profile { __data["profile"] }

      /// Me.Profile
      ///
      /// Parent Type: `CurrentUserProfile`
      public struct Profile: SpotifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SpotifyAPI.Objects.CurrentUserProfile }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", SpotifyAPI.ID.self),
          .field("displayName", String?.self),
          .field("images", [Image]?.self),
        ] }

        /// The [Spotify user ID](https://developer.spotify.com/documentation/web-api/concepts/spotify-uris-ids)
        /// for the user.
        public var id: SpotifyAPI.ID { __data["id"] }
        /// The name displayed on the user's profile. `null` if not available.
        public var displayName: String? { __data["displayName"] }
        /// The user's profile image.
        public var images: [Image]? { __data["images"] }

        /// Me.Profile.Image
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
    }
  }
}

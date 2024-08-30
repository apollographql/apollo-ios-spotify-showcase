// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct RecommendationSeedInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    seedArtists: GraphQLNullable<[ID]> = nil,
    seedGenres: GraphQLNullable<[String]> = nil,
    seedTracks: GraphQLNullable<[ID]> = nil
  ) {
    __data = InputDict([
      "seedArtists": seedArtists,
      "seedGenres": seedGenres,
      "seedTracks": seedTracks
    ])
  }

  /// A list of [Spotify IDs](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for seed artists. Up to 5 seed values may be provided in any combination of `seedArtists`, `seedTracks` and `seedGenres`.
  ///
  /// Example value: ["4NHQUGzhtTLFvgF5SZesLK"]
  public var seedArtists: GraphQLNullable<[ID]> {
    get { __data["seedArtists"] }
    set { __data["seedArtists"] = newValue }
  }

  /// A list of any genres in the set of available genre seeds. Up to 5 seed values may be provided in any combination of `seedArtists`, `seedTracks` and `seedGenres`.
  ///
  /// Example value: ["classical", "country"]
  public var seedGenres: GraphQLNullable<[String]> {
    get { __data["seedGenres"] }
    set { __data["seedGenres"] = newValue }
  }

  /// A list of [Spotify IDs](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids)
  /// for a seed track. Up to 5 seed values may be provided in any combination of
  /// `seedArtists`, `seedTracks` and `seedGenres`.
  ///
  /// Example value: ["0c6xIDDpzE81m2q797ordA"]
  public var seedTracks: GraphQLNullable<[ID]> {
    get { __data["seedTracks"] }
    set { __data["seedTracks"] = newValue }
  }
}

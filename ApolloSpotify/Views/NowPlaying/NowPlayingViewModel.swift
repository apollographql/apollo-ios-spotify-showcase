import Foundation
import Apollo
import SpotifyAPI
import SwiftUI

class NowPlayingViewModel: ObservableObject {
  
  @Published var albumImgURL: URL?
  @Published var albumName: String = ""
  @Published var trackName: String = ""
  @Published var artistName: String = ""
  @Published var trackLengthMs: Int = 1
  @Published var trackProgressString: String = ""
  @Published var trackRemainingString: String = ""
  @Published var isPlaying: Bool = false
  
  @Published var progressMs: Int = 0 {
    didSet {
      let progressInterval = TimeInterval(progressMs / 1000)
      trackProgressString = progressInterval.playbackTimestamp
      let remainingInterval = TimeInterval((trackLengthMs - progressMs) / 1000)
      trackRemainingString = String("-\(remainingInterval.playbackTimestamp)")
    }
  }
  
  private var track: TrackFragment? {
    didSet {
      albumImgURL = URL(string: track?.album.images.first?.url ?? "")
      albumName = track?.album.name ?? ""
      trackName = track?.name ?? ""
      artistName = track?.artists.first?.name ?? ""
      trackLengthMs = track?.durationMs ?? 0
    }
  }
  
  private var playbackStateSubscription: Cancellable?
  
  init() {
    startSubscription()
  }
  
  deinit {
    playbackStateSubscription?.cancel()
  }
  
  private func startSubscription() {
    playbackStateSubscription = Network.shared.apollo.subscribe(subscription: PlaybackStateSubscription()) { [weak self] result in
      guard let self = self else {
        return
      }
      switch result {
      case .success(let graphQLResult):
        if let device = graphQLResult.data?.playbackStateChanged?.device.name {
          print("Playback state device - \(device)")
        }
        if let track = graphQLResult.data?.playbackStateChanged?.item?.asTrack?.fragments.trackFragment {
          self.track = track
        }
        if let trackProgress = graphQLResult.data?.playbackStateChanged?.progressMs {
          self.progressMs = trackProgress
        }
        if let isPlaying = graphQLResult.data?.playbackStateChanged?.isPlaying {
          self.isPlaying = isPlaying
        }
        
        if let errors = graphQLResult.errors {
          print("Subscription Errors - \(errors)")
        }
      case .failure(let error):
        print("Subscription Error - \(error)")
      }
    }
  }
  
}

import Foundation
import SwiftUI
import SpotifyAPI

class TrackMenuAction: ObservableObject, ActionViewProvider {
  
  let track: TrackFragment
  @Binding var selectedTrack: TrackFragment?
  
  init(
    track: TrackFragment,
    selectedTrack: Binding<TrackFragment?>
  ) {
    self.track = track
    self._selectedTrack = selectedTrack
  }
  
  var actionView: some View {
    Button {
      self.selectedTrack = self.track
    } label: {
      Image(systemName: "ellipsis")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .foregroundStyle(.white)
    }
  }
  
}

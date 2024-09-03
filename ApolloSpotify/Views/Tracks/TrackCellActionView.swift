import SwiftUI

struct TrackCellActionView: View {
  
  let systemImageName: String
  let actionHandler: () -> Void
  
  var body: some View {
    Button {
      actionHandler()
    } label: {
      Image(systemName: systemImageName)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .foregroundColor(.white)
    }
  }
}

#Preview {
  TrackCellActionView(
    systemImageName: "ellipsis") {
      print("Action Handled")
    }
}

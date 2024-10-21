import Foundation

extension TimeInterval {
  var hoursAndMinutes: String {
    String(format: "%dh %dm", hours, minutes)
  }
  
  var hours: Int {
    Int((self / 3600).truncatingRemainder(dividingBy: 3600))
  }
  
  var minutes: Int {
    Int((self / 60).truncatingRemainder(dividingBy: 60))
  }
  
  var seconds: Int {
    Int(self.truncatingRemainder(dividingBy: 60))
  }
  
  var playbackTimestamp: String {
    String(format: "%d:%02d", minutes, seconds)
  }
}


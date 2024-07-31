import SwiftUI

struct HomeView: View {
  
  let authManager = AuthManager()
  
  var body: some View {
    // TODO: Temporary for test OAuth workflow
    Button("Open Auth") {
      Task {
        do {
          let token = try await authManager.getAccessToken()
          print("Access token - \(token)")
        } catch {
          print("OAuth Error - \(error.localizedDescription)")
        }
      }
    }
  }
}

#Preview {
    HomeView()
}

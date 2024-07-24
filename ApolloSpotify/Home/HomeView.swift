import SwiftUI

struct HomeView: View {
  
  let authManager = AuthManager()
  
  var body: some View {
    // TODO: Temporary for test OAuth workflow
    Button("Open Auth") {
      Task {
        do {
          _ = try await authManager.authorizationRequest()
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

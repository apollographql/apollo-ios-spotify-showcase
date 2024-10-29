import SwiftUI

struct MainTabView: View {
  var body: some View {
    TabView {
      HomeView()
        .tabItem {
          Label("Home", systemImage: "house")
        }
      Text("Search")
        .tabItem {
          Label("Search", systemImage: "magnifyingglass")
        }
      Text("Your Library")
        .tabItem {
          Label("Your Library", systemImage: "")
        }
    }
    .overlay(alignment: .bottom) {
      NowPlayingOverlayView()
        .offset(x: 0, y: -55)
    }
  }
}

#Preview {
    MainTabView()
}

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
    }
}

#Preview {
    MainTabView()
}

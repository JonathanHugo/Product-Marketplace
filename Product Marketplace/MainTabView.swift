import SwiftUI
struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            UserProfileView()
                .tabItem {
                    Label("Account", systemImage: "person")
                }
        }
    }
}

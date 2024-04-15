import SwiftUI
struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            AlbumListView()
                .tabItem {
                    Label("Albums", systemImage: "music.note.list")
                }
            UserProfileView()
                .tabItem {
                    Label("Account", systemImage: "person")
                }
            
        }
    }
}

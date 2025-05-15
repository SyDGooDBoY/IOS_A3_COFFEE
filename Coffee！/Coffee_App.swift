import SwiftUI

@main
struct Coffee_App: App {
    @StateObject private var db = LoginDatabase()
    @StateObject private var postStore = PostStore()
    @State private var isLoggedIn = false 

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                RootView(isLoggedIn: $isLoggedIn)
                    .environmentObject(db)
                    .environmentObject(postStore)
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
                    .environmentObject(db)
                    .environmentObject(postStore)
            }
        }
    }
}

import SwiftUI

@main
struct Coffee_App: App {
    @StateObject private var db = LoginDatabase()
    @StateObject private var postStore = PostStore()
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                RootView()
                    .environmentObject(db)
                    .environmentObject(postStore)
            } else {
                LoginView()
                    .environmentObject(db)
                    .environmentObject(postStore)
            }
        }
    }
}

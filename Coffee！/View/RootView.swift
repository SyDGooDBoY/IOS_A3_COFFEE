import SwiftUI

enum Tab: Int, CaseIterable {
    case ranking, allPosts, add, stats, profile

    var iconName: String {
        switch self {
        case .stats: return "chart.bar"
        case .allPosts: return "books.vertical"
        case .add: return "plus"
        case .ranking: return "calendar"
        case .profile: return "person.fill"
        }
    }
}

struct RootView: View {
    @Binding var isLoggedIn: Bool
    @State private var selection: Tab = .stats

    var body: some View {
        ZStack {
            Group {
                switch selection {
                case .stats: RankingView()
                case .ranking: CalenderView()
                case .allPosts: AllPostsView()
                case .add: NewPostView(selection: $selection)
                case .profile: ProfileView(isLoggedIn: $isLoggedIn) // ✅ pass binding
                }
            }
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.25), value: selection)

            VStack {
                Spacer()
                CustomTabBar(selection: $selection)
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

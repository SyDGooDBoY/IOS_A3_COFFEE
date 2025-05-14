//
//  RootView.swift
//  Coffee！
//
//  Created by HF on 11/5/2025.
//

import SwiftUI

enum Tab: Int, CaseIterable {
    case ranking, allPosts, add, stats, profile
    
    var iconName: String {
        switch self {
        case .stats:   return "chart.bar"          // 1st icon
        case .allPosts:     return "slider.horizontal.3"// 2nd icon
        case .add:     return "plus"               // Plus icon
        case .ranking: return "calendar"           // 4th icon
        case .profile: return "person.fill"        // 5th icon
        }
    }
}

struct RootView: View {
    // Default view
    @State private var selection: Tab = .stats
    
    var body: some View {
        ZStack {
            // swap views
            Group {
                switch selection {
                case .stats:   RankingView()
                case .ranking: CalenderView()
                case .allPosts:     AllPostsView()
                case .add: NewPostView(selection: $selection)
                case .profile: ProfileView()
                }
            }
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.25), value: selection)
            
            // Custom tab bar
            VStack {
                Spacer()
                CustomTabBar(selection: $selection)
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    RootView()
        .environmentObject(PostStore())
}

//
//  RootView.swift
//  Coffee！
//
//  Created by HF on 11/5/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = true

    var body: some View {
        RootView(isLoggedIn: $isLoggedIn)
            .environmentObject(LoginDatabase()) 
            .environmentObject(PostStore())
    }
}

#Preview {
    ContentView()
}

//
//  Coffee_App.swift
//  Coffee！
//
//  Created by HF on 5/5/2025.
//  LETS GET HD!!!

import SwiftUI

@main
struct Coffee_App: App {
    @StateObject private var postStore = PostStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(postStore)
        }
    }
}

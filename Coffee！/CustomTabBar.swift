//
//  RootView.swift
//  Coffee！
//
//  Created by HF on 11/5/2025.
//
import SwiftUI

struct CustomTabBar: View {
    @Binding var selection: Tab
    
    private let primaryColor  = Color.brown
    private let inactiveColor = Color(UIColor.systemGray2)
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Spacer()
                
                if tab == .add {
                    Button { selection = tab } label: {
                        Image(systemName: tab.iconName)
                            .font(.system(size: 24, weight: .bold))
                            .frame(width: 56, height: 56)
                            .background(primaryColor)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    .offset(y: -18)          
                } else {
                    Button { selection = tab } label: {
                        Image(systemName: tab.iconName)
                            .font(.system(size: 22))
                            .frame(width: 32, height: 32)
                            .foregroundColor(selection == tab ? primaryColor : inactiveColor)
                    }
                }
                
                Spacer()
            }
        }
        .padding(.top, 8)
        .background(
            Color(UIColor.systemBackground)
                .ignoresSafeArea(edges: .bottom)     // Extend background to buttom
                .shadow(color: .black.opacity(0.08), radius: 4, y: -2)
        )
    }
}

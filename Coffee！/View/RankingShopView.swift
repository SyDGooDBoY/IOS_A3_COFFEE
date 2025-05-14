//
//  RankingShopView.swift
//  Coffee！
//
//  Created by SyDGooDBoY on 14/5/2025.
//

import SwiftUI

/// 店铺详情页（仅店名 + 随机帖子）
struct RankingShopView: View {
    let shop: CoffeeShop
    
    @EnvironmentObject var postStore: PostStore
    
    /// 只显示当前店铺的帖子
    private var postsForShop: [CoffeePost] {
        postStore.posts.filter {
            $0.cafeName.compare(shop.name, options: .caseInsensitive) == .orderedSame
        }
    }

    
    var body: some View {
        ScrollView {
            // 顶部：店名三行显示
            VStack(alignment: .leading, spacing: 0) {
                ForEach(shop.name.split(separator: " "), id: \.self) { part in
                    Text(part.lowercased())
                        .font(.largeTitle.bold())
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            LazyVGrid(columns: [.init(.flexible(), spacing: 16),
                                .init(.flexible(), spacing: 16)],
                      spacing: 24) {
                ForEach(postsForShop) { post in          // ← 修改这里
                    PostCard(post: post)
                }
            }

            .padding(.horizontal)
            .padding(.bottom, 120) // 预留底栏
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Post 卡片
private struct PostCard: View {
    let post: CoffeePost
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(post.photoFilename)
                .resizable()
                .scaledToFill()
                .frame(height: 150)
                .clipped()
                .cornerRadius(8)
            Text(post.cafeName).font(.headline)
            Text("☕️ \(post.coffeeType)")
                .font(.footnote)
                .foregroundColor(.secondary)
            HStack(spacing: 6) {
                Image(systemName: "star.fill").foregroundColor(.orange)
                Text("\(post.cafeRating)")
                Spacer()
                Text(dateString(post.date))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
    
    private func dateString(_ d: Date) -> String {
        let f = DateFormatter()
        f.dateStyle = .medium
        return f.string(from: d)
    }
}

//
//  RankingShopView.swift
//  Coffee！
//
//  Created by SyDGooDBoY on 14/5/2025.
//

import SwiftUI
import MapKit

struct RankingShopView: View {
    let shop: CoffeeShop
    
    @EnvironmentObject var postStore: PostStore
    @Environment(\.openURL) private var openURL
        
    // map
    @State private var region: MKCoordinateRegion
    
    init(shop: CoffeeShop) {
        self.shop = shop
        
        _region = State(initialValue: MKCoordinateRegion(
                   center: .init(latitude: shop.latitude, longitude: shop.longitude),
                   span: .init(latitudeDelta: 0.005, longitudeDelta: 0.005)
               ))
    }
    
    var body: some View {
        ScrollView {
            // name and map
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 0) {
                        // seprate name with space
                        ForEach(shop.name.split(separator: " "), id: \.self) { part in
                            Text(part.lowercased())          // “coffee” / “shop”
                                .font(.largeTitle.bold())
                        }
                        Text("\(shop.rank)")                 // “1”
                            .font(.largeTitle.bold())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Map(coordinateRegion: $region, interactionModes: [])
                    .frame(width: 150, height: 150)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .onTapGesture {
                        let url = URL(string:
                            "http://maps.apple.com/?daddr=\(shop.latitude),\(shop.longitude)")!
                        openURL(url)
                    }
            }
            .padding()
            
            let randomPosts = Array(postStore.posts.shuffled().prefix(10))
                        
                        LazyVGrid(columns: [.init(.flexible(), spacing: 16),
                                            .init(.flexible(), spacing: 16)],
                                  spacing: 24) {
                            ForEach(randomPosts) { post in
                                PostCard(post: post)
                            }
                        }
            .padding(.horizontal)
            .padding(.bottom, 120)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// POST
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
            
            Text(post.cafeName)
                .font(.headline)
            
            Text("☕️ \(post.coffeeType)") 
                .font(.footnote)
                .foregroundColor(.secondary)
            
            HStack(spacing: 6) {
                Image(systemName: "star.fill")
                    .foregroundColor(.orange)
                Text("\(post.cafeRating)")
                Spacer()
                Text(formattedDate(post.date))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateStyle = .medium
        return f.string(from: date)
    }
}

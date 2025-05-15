//
//  RootView.swift
//  Coffee！
//
//  Created by HF on 11/5/2025.
//
import SwiftUI

struct CoffeeShop: Identifiable {
    let id = UUID()
    let rank: Int
    let name: String
    let rating: Int
}

// MARK: - Ranking
struct RankingView: View {
    @StateObject private var locationManager = LocationManager()
    @EnvironmentObject private var postStore: PostStore
    
    private var shops: [CoffeeShop] {
        let groups = Dictionary(grouping: postStore.posts) { $0.cafeName }
        
        var cafes: [CoffeeShop] = groups.map { name, posts in
            let avg = Int(round(Double(posts.map(\.cafeRating).reduce(0, +)) /
                                Double(posts.count)))
            return CoffeeShop(rank: 0, name: name, rating: avg)
        }
        
        cafes.sort {
            $0.rating == $1.rating
            ? $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            : $0.rating > $1.rating
        }
        
        for i in cafes.indices {
            cafes[i] = CoffeeShop(rank: i + 1,
                                  name: cafes[i].name,
                                  rating: cafes[i].rating)
        }
        return cafes
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // Logo
                HStack {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90)
                    Spacer()
                }
                .padding(.horizontal)
                
                
                // List
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(shops) { shop in
                            NavigationLink {
                                RankingShopView(shop: shop)
                            } label: {
                                ShopCard(shop: shop)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct ShopCard: View {
    let shop: CoffeeShop
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            
            Text("\(shop.rank)")
                .font(.system(size: 32, weight: .bold))
                .frame(width: 40, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(shop.name)
                    .font(.headline)
                
                
                Text(String(repeating: "⭐️", count: shop.rating))
                    .font(.subheadline)
                
                HStack(spacing: 8) {
                    Image(systemName: "figure.roll")   // 无障碍
                    Image(systemName: "wifi")          // Wi-Fi
                    Image(systemName: "house")         // 洗手间（占位）
                }
                .font(.subheadline)
                .foregroundStyle(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.headline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(UIColor.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}



#Preview {
    RankingView().environmentObject(PostStore())
}

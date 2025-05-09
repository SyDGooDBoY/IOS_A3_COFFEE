//
//  RankingView.swift
//  Coffee！
//
//  Created by Chelsea Wu💕 on 10/5/2025.
//

import SwiftUI


struct CoffeeShop: Identifiable {
    let id = UUID()
    let rank: Int
    let name: String
    let rating: Int
    let distance: Double
}

// main page
struct RankingView: View {
    @State private var currentLocation = ""
    
    // fake data for now
    private let shops: [CoffeeShop] = [
        .init(rank: 1, name: "Coffee shop", rating: 4, distance: 0.5),
        .init(rank: 2, name: "Brew Bros",    rating: 5, distance: 0.8),
        .init(rank: 3, name: "Latte Land",   rating: 4, distance: 1.2),
        .init(rank: 4, name: "Roast & Roll", rating: 3, distance: 1.5)
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // Logo
                HStack {
                    Image("coffeeBondLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90)
                    Spacer()
                }
                .padding(.horizontal)
                
                // current location text field(need to change to auto locate)
                TextField("Current location…", text: $currentLocation)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(6)
                    .overlay(RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1))
                    .padding(.horizontal)
                
                // ranking list
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(shops) { shop in
                            ShopCard(shop: shop)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// tab
struct ShopCard: View {
    let shop: CoffeeShop
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // rank
            Text("\(shop.rank)")
                .font(.system(size: 32, weight: .bold))
                .frame(width: 40, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 4) {
                // name
                Text(shop.name)
                    .font(.headline)
                
                // star
                HStack(spacing: 2) {
                    ForEach(0..<5) { index in
                        Image(systemName: index < shop.rating ? "star.fill" : "star")
                            .font(.subheadline)
                    }
                }
                .foregroundColor(Color("StarGold", bundle: nil) ?? .yellow)
                
                // icon
                HStack(spacing: 8) {
                    Image(systemName: "figure.roll")       // accessibility
                    Image(systemName: "wifi")              // Wi-Fi
                    Image(systemName: "house")             // toliet(using house for now)
                }
                .font(.subheadline)
                .foregroundStyle(.gray)
            }
            
            Spacer()
            
            // distance
            Text(String(format: "%.1fKM", shop.distance))
                .font(.subheadline.weight(.semibold))
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(UIColor.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

#Preview {
    RankingView()
}

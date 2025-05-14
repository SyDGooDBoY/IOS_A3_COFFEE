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
    let distance: Double
    let latitude: Double
    let longitude: Double
}

// main page
struct RankingView: View {
    @State private var currentLocation = ""
    @StateObject private var locationManager = LocationManager()

    // fake data for now
    private let shops: [CoffeeShop] = [
        .init(rank: 1, name: "Coffee shop1", rating: 4, distance: 0.5,
              latitude: -33.8830, longitude: 151.2000),
        .init(rank: 2, name: "Coffee shop2", rating: 5, distance: 0.8,
              latitude: -33.8815, longitude: 151.1990),
        .init(rank: 3, name: "Coffee shop3", rating: 4, distance: 1.2,
              latitude: -33.8800, longitude: 151.1980),
        .init(rank: 4, name: "Coffee shop4", rating: 3, distance: 1.5,
              latitude: -33.8820, longitude: 151.1970)
    ]
    
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
                
                // current location text field(need to change to auto locate)
                HStack {Image(systemName: "location.fill")
                        .foregroundColor(.gray)
                    Text(locationManager.locationString)
                                      .font(.subheadline)
                                      .lineLimit(1)
                                      .truncationMode(.tail)
                                  Spacer()
                              }
                              .padding(.vertical, 8)
                              .padding(.horizontal, 12)
                              .background(Color(UIColor.systemGray6))
                              .cornerRadius(6)
                              .overlay(
                                  RoundedRectangle(cornerRadius: 6)
                                      .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                              )
                              .padding(.horizontal)
                
                // ranking list
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

//
//  CalenderPopUpView.swift
//  Coffee！
//
//  Created by Xinyi Hu on 14/5/2025.
//
import SwiftUI

struct CalenderPopUpView: View {
    let day: Int
    let month: Int
    
    @ObservedObject var viewModel: CalendarViewModel
    @EnvironmentObject private var postStore: PostStore
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        let postsForDay = viewModel.postsForDay(day, in: postStore.posts)
        
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                
                ScrollView {
                    HStack {
                        Text("\(day)")
                            .font(.title2 .bold())
                            .foregroundColor(.brown)
                        
                        Text("\(viewModel.months[month - 1])")
                            .font(.title2 .bold())
                            .foregroundColor(.brown)
                        
                        Text("2025")
                            .font(.title2 .bold())
                            .foregroundColor(.brown)
                    }
                    .padding(.top, 40)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if postsForDay.isEmpty {
                        Text("Caffeine Free Day!")
                            .font(.title .bold())
                            .foregroundColor(Color("Font"))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 40)
                    } else {
                        VStack(spacing: 30) {
                            ForEach(postsForDay) { post in
                                VStack(alignment: .leading, spacing: 10) {
                                    ///Location
                                    HStack {
                                        Text("@")
                                            .font(.title3 .bold())
                                            .foregroundColor(Color("Font"))
                                        Text(post.cafeName)
                                            .font(.title3 .bold())
                                            .foregroundColor(Color("Font"))
                                    }
                                    
                                    ///Image and Tag
                                    HStack() {
                                        Image(post.photoFilename)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 260)
                                            .cornerRadius(6)
                                        
                                        Spacer()
                                            .frame(width: 20)
                                        
                                        VStack(alignment: .leading) {
                                            ///Coffee Type
                                            Text(post.coffeeType)
                                                .font(.callout .bold())
                                                .foregroundColor(Color("Font"))
                                                .padding(6)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .fill(Color("Blue").opacity(0.3))
                                                )
                                            
                                            Spacer()
                                                .frame(height: 20)
                                            
                                            ///Rating
                                            Text("⭐️ \(post.cafeRating)")
                                                .font(.callout .bold())
                                                .foregroundColor(Color("Font"))
                                                .padding(6)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .fill(Color("Orange").opacity(0.3))
                                                )
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(.top, 20)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    ///Sample Post for Preview
    let vm = CalendarViewModel()
    
    let sampleDay = 14
    let sampleDate = vm.date(for: sampleDay)

    let store = PostStore()
    let firstSample = CoffeePost(
        date: sampleDate,
        coffeeType: "Latte",
        cafeName: "Example Cafe",
        photoFilename: "latte1",
        cafeRating: 3
    )
    let secondSample = CoffeePost(
        date: sampleDate,
        coffeeType: "Espresso",
        cafeName: "Another Cafe",
        photoFilename: "espresso2",
        cafeRating: 5
    )
    store.addPost(firstSample)
    store.addPost(secondSample)
    
    return CalenderPopUpView(
        day: sampleDay,
        month: vm.currentMonth + 1,
        viewModel: vm
    )
    .environmentObject(store)
}

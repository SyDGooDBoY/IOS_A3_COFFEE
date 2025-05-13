//
//  NewPost.swift
//  Coffee！
//
//  Created by Mati on 5/11/25.
//


import SwiftUI
import PhotosUI

struct NewPostView: View {
    @Binding var selection: Tab
    @EnvironmentObject var postStore: PostStore

    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    @State private var selectedImageName: String = ""

    @State private var location: String = ""
    @State private var postDate: Date = Date()
    @State private var caption: String = ""
    @State private var selectedCoffee: String = "Flat white"
    @State private var rating: Int = 3

    let recentImageNames = [
        "espresso1", "espresso2",
        "flatwhite1", "flatwhite2",
        "latte1", "latte2",
        "coldbrew1", "coldbrew2"
    ]

    let coffeeTypes = ["Flat white", "Espresso", "Latte", "Cold brew"]

    var allFieldsFilled: Bool {
        selectedImage != nil && !location.isEmpty && !caption.isEmpty
    }

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Button("Cancel") {
                        selection = .stats
                    }
                    Spacer()
                    Button("Share") {
                        let newPost = CoffeePost(
                            date: postDate,
                            coffeeType: selectedCoffee,
                            cafeName: location,
                            photoFilename: selectedImageName,
                            cafeRating: rating
                        )
                        postStore.addPost(newPost)
                        clearForm()
                        selection = .allPosts
                    }
                    .disabled(!allFieldsFilled)
                }
                .padding(.horizontal)
                .padding(.top, 10)

                // ScrollView form
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {

                        // Image Picker
                        PhotosPicker(selection: $selectedItem, matching: .images) {
                            if let image = selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 220)
                                    .cornerRadius(10)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical)
                            } else {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 200)
                                    .cornerRadius(10)
                                    .overlay(Text("Tap to select image"))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical)
                            }
                        }

                        // Location
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                            TextField("Location", text: $location)
                        }
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)

                        // Date
                        HStack {
                            Image(systemName: "calendar")
                            DatePicker("Date", selection: $postDate, displayedComponents: .date)
                        }
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)

                        // Caption
                        TextField("Caption", text: $caption)
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(8)

                        // Coffee Type + Rating
                        HStack(spacing: 16) {
                            Picker("Coffee Type", selection: $selectedCoffee) {
                                ForEach(coffeeTypes, id: \.self) { type in
                                    Text(type)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())

                            Spacer()

                            HStack(spacing: 4) {
                                ForEach(1...5, id: \.self) { star in
                                    Image(systemName: star <= rating ? "star.fill" : "star")
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                        .foregroundColor(.orange)
                                        .onTapGesture {
                                            rating = star
                                        }
                                }
                            }
                        }
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)

                        // Recent Photos
                        Text("Most recent photos")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(recentImageNames, id: \.self) { name in
                                    Image(name)
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .cornerRadius(8)
                                        .onTapGesture {
                                            selectedImage = UIImage(named: name)
                                            selectedImageName = name
                                        }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 120)
                }
            }

            // Tab bar
            VStack {
                Spacer()
                CustomTabBar(selection: $selection)
            }
        }
        .ignoresSafeArea(.keyboard)
        .onChange(of: selectedItem) {
            guard let selectedItem else { return }
            Task {
                if let data = try? await selectedItem.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                    selectedImageName = "customImage"
                }
            }
        }
    }

    private func clearForm() {
        selectedImage = nil
        selectedImageName = ""
        location = ""
        caption = ""
        postDate = Date()
        selectedCoffee = "Flat white"
        rating = 3
    }
}

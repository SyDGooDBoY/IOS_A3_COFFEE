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
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    @State private var location: String = ""
    @State private var caption: String = ""
    @State private var selectedCoffee: String = "Flat white"
    
    let recentImageNames = ["espresso1", "espresso2", "flatwhite1", "flatwhite2", "latte1", "latte2", "coldbrew1", "coldbrew2"]

    let coffeeTypes = ["Flat white", "Espresso", "Latte", "Cold brew"]

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Logo
                    Image("coffeeBondLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .padding(.leading)

                    // Image picker
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(8)
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 200)
                                .overlay(Text("Tap to select image"))
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

                    // Caption
                    TextField("Caption", text: $caption)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)

                    // Coffee type dropdown
                    Picker("Coffee Type", selection: $selectedCoffee) {
                        ForEach(coffeeTypes, id: \.self) { type in
                            Text(type)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)

                    // Recent photos
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
                                    }
                            }
                        }
                    }

                    Spacer().frame(height: 60) // padding for nav bar
                }
                .padding()
            }
            
            // Tab bar
            VStack {
                Spacer()
                CustomTabBar(selection: $selection)
            }
        }
        .ignoresSafeArea(.keyboard)
        .onChange(of: selectedItem) { oldValue, newValue in
            Task {
                if let data = try? await newValue?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                }
            }
        }
    }
}


struct StatefulPreviewWrapper<T: Hashable, Content: View>: View {
    @State private var value: T
    var content: (Binding<T>) -> Content

    init(_ initialValue: T, content: @escaping (Binding<T>) -> Content) {
        self._value = State(initialValue: initialValue)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}


#Preview {
    StatefulPreviewWrapper(Tab.add) { selection in
        NewPostView(selection: selection)
    }
}

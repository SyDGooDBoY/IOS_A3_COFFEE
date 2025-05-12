//
//  CoffeePostModel.swift
//  Coffee！
//
//  Created by Xinyi Hu on 12/5/2025.
//

import Foundation

struct CoffeePost: Identifiable, Codable {
    let id: UUID
    let date: Date
    let coffeeType: String
    let cafeName: String
    let photoFilename: String
    let cafeRating: Int

    init(
        id: UUID = UUID(),
        date: Date = Date(),
        coffeeType: String,
        cafeName: String,
        photoFilename: String,
        cafeRating: Int
    ) {
        self.id = id
        self.date = date
        self.coffeeType = coffeeType
        self.cafeName = cafeName
        self.photoFilename = photoFilename
        self.cafeRating = cafeRating
    }
}

//HOW TO USE:
// MARK: – Example JSON Encoding/Decoding

//let post = CoffeePost(
//    coffeeType: "Cold Brew",
//    cafeName: "Bean There Café",
//    photoFilename: "coldbrew_2025-05-12.jpg",
//    cafeRating: 5
//)
//

//// Encode to JSON Data
//do {
//    let data = try JSONEncoder().encode(post)
//    // e.g. save to UserDefaults:
//    UserDefaults.standard.set(data, forKey: "lastCoffeePost")
//} catch {
//    print("Encoding failed:", error)
//}
//

//// Decode from JSON Data
//if let saved = UserDefaults.standard.data(forKey: "lastCoffeePost") {
//    do {
//        let decoded = try JSONDecoder().decode(CoffeePost.self, from: saved)
//        print("Decoded CoffeePost:", decoded)
//    } catch {
//        print("Decoding failed:", error)
//    }
//}

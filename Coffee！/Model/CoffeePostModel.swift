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

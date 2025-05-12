//
//  UserModel.swift
//  Coffee！
//
//  Created by Xinyi Hu on 12/5/2025.
//

import Foundation

///Represents an app user and their preferences
struct User: Identifiable, Codable {
    let id: UUID                 // Unique user ID
    var username: String         // Login/display name
    var favoriteCoffeeType: String?  // Optional favorite type
    var favoriteCafe: String?        // Optional favorite café
}


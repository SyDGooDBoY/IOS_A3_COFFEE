//
//  LoginDatabase.swift
//  Coffee！
//
//  Created by AJ on 14/5/2025.
//

// LoginDatabase.swift

import Foundation

struct LoginUser: Codable {
    var password: String
    var firstName: String
    var lastName: String
    var dateOfBirth: String
    var age: String
}

class LoginDatabase: ObservableObject {
    @Published var users: [String: LoginUser] = [:] {
        didSet { saveUsers() }
    }
    
    @Published var currentUserEmail: String? = nil

    private let userDefaultsKey = "SavedUsers"

    init() {
        loadUsers()
    }

    func saveUsers() {
        if let encoded = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }

    func loadUsers() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode([String: LoginUser].self, from: data) {
            users = decoded
        } else {
            users = [
//                "test@example.com": LoginUser(password: "password123", firstName: "Test", lastName: "User"),
                "coffee@bond.com": LoginUser(password: "espresso", firstName: "Coffee", lastName: "Bond", dateOfBirth: "", age: "23")
            ]
        }
    }
}

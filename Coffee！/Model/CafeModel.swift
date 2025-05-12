//
//  CafeModel.swift
//  Coffee！
//
//  Created by Xinyi Hu on 12/5/2025.
//
import Foundation

///Aggregated café statistics for ranking view
struct CafeSummary: Identifiable, Codable {

    var id: String { cafeName }
    let cafeName: String         // Name of the café
    let averageRating: Double    // Average rating across all posts
    let postCount: Int           // Number of posts for this café
}



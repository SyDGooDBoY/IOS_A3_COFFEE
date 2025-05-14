//
//  DayItemModel.swift
//  Coffee！
//
//  Created by Xinyi Hu on 12/5/2025.
//

import Foundation

//struct DayItem: Identifiable {
//    let id: Int          // Day number (1...31)
//    let date: Date       // Full Date for that day
//    var post: CoffeePost?  // Optional CoffeePost for this date
//}

struct DaySelection: Identifiable {
    let id = UUID()
    let day: Int
}

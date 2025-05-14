//
//  CalendarViewModel.swift
//  Coffee！
//
//  Created by Xinyi Hu on 11/5/2025.
//

// CalendarViewModel.swift
import SwiftUI

class CalendarViewModel: ObservableObject {
    @Published var currentMonth: Int = Calendar.current.component(.month, from: Date()) - 1
    
    private let calendar = Calendar.current
    private let year = Calendar.current.component(.year, from: Date())
    
    ///["JAN", "FEB", ...]
    var months: [String] {
        calendar.shortMonthSymbols.map { $0.uppercased() }
    }
    
    ///First Day
    private var firstOfMonth: Date {
        calendar.date(from: DateComponents(year: year, month: currentMonth + 1, day: 1))!
    }
    
    ///Total Day
    var daysCount: Int {
        calendar.range(of: .day, in: .month, for: firstOfMonth)!.count
    }
    
    ///Date Match Day
    private var weekdayOfFirst: Int {
        calendar.component(.weekday, from: firstOfMonth)
    }
    
    ///Off-set of Calender
    private var blankCount: Int {
        (weekdayOfFirst - calendar.firstWeekday + 7) % 7
    }
    
    ///Make the Calender Array
    var daysArray: [Int] {
        Array(repeating: 0, count: blankCount) + Array(1...daysCount)
    }
    
    ///Provide Days
    var weekdaySymbols: [String] {
        calendar.veryShortWeekdaySymbols
    }
    
    ///Return Date, Month, Year
//    func date(for day: Int) -> Date {
//        let comps = DateComponents(year: year, month: currentMonth + 1, day: day)
//        return calendar.date(from: comps)!
//    }
    func date(for day: Int) -> Date {
        let comps = DateComponents(
            year: Calendar.current.component(.year, from: Date()),
            month: currentMonth + 1,
            day: day
        )
        return calendar.date(from: comps)!
    }
    
    ///Check is this date is today
    func isToday(day: Int) -> Bool {
        calendar.isDate(date(for: day), inSameDayAs: Date())
    }

    ///Check is this day has post
    func hasPost(on posts: [CoffeePost], day: Int) -> Bool {
        let d = date(for: day)
        return posts.contains { calendar.isDate($0.date, inSameDayAs: d) }
    }
    
    ///Display the posts in selected day
    func postsForDay(_ day: Int, in posts: [CoffeePost]) -> [CoffeePost] {
        let target = date(for: day)
        return posts.filter { calendar.isDate($0.date, inSameDayAs: target) }
    }
}

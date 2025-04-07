//
//  Date+Extension.swift
//  MyHabits
//
//  Created by Razumov Pavel on 07.04.2025.
//

import Foundation

extension Date {
    static func makeDate(from text: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: text)
    }
}

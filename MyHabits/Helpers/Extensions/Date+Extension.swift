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
    
    static func makeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: date)
    }
    
    static func getTimeComponents(from date: Date) -> (hour: String, minute: String, meridiem: String)? {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        let formattedString = formatter.string(from: date)
        let components = formattedString.components(separatedBy: CharacterSet(charactersIn: ": "))

        guard components.count == 3 else { return nil }

        let hour = components[0]
        let minute = components[1]
        let meridiem = components[2]

        return (hour, minute, meridiem)
    }
}

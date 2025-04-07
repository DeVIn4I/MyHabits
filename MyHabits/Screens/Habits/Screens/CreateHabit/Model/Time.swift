//
//  Time.swift
//  MyHabits
//
//  Created by Razumov Pavel on 07.04.2025.
//

import UIKit

struct Time {
    let hours: [String] = Array(1...12).map { String($0) }
    let minutes = Array(0...59).map { String(format: "%02d", $0) }
    let meridiems = ["AM", "PM"]
}

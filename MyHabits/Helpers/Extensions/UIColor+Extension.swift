//
//  UIColor+Extension.swift
//  MyHabits
//
//  Created by Razumov Pavel on 07.04.2025.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        UIColor.init(
            red: CGFloat(Int.random(in: 0...255)) / 255.0,
            green: CGFloat(Int.random(in: 0...255)) / 255.0,
            blue: CGFloat(Int.random(in: 0...255)) / 255.0,
            alpha: 1.0
        )
    }
}

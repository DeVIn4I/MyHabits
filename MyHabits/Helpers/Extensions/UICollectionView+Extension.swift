//
//  UICollectionView+Extension.swift
//  MyHabits
//
//  Created by Razumov Pavel on 09.04.2025.
//

import UIKit

protocol Identifier {
    static var identifier: String { get }
}

extension UICollectionViewCell: Identifier {
    static var identifier: String {
        String(describing: self)
    }
}

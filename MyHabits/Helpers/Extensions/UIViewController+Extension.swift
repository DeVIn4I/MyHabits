//
//  UIViewController+Extension.swift
//  MyHabits
//
//  Created by Razumov Pavel on 07.04.2025.
//

import UIKit

extension UIViewController {
    func setupNavigationBar(isLargeTitle: Bool = false) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .mhSystemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = isLargeTitle
        
        navigationItem.rightBarButtonItem?.tintColor = .habitsPurple
        navigationItem.leftBarButtonItem?.tintColor = .habitsPurple
    }
}

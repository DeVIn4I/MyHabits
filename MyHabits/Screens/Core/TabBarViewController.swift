//
//  TabBarViewController.swift
//  MyHabits
//
//  Created by Razumov Pavel on 07.04.2025.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    private let store = HabitsStore.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        setupTabBar()
    }
    
    private func setupControllers() {
        let habitsVC = HabitsViewController(store: store)
        habitsVC.tabBarItem = UITabBarItem(
            title: Constants.Text.TabBarTitle.habits,
            image: UIImage(named: Constants.Image.TabBar.habits),
            selectedImage: nil
        )

        let infoVC = InfoViewController()
        infoVC.tabBarItem = UITabBarItem(
            title: Constants.Text.TabBarTitle.info,
            image: UIImage(systemName: Constants.Image.TabBar.info),
            selectedImage: nil
        )
        
        viewControllers = [habitsVC, infoVC].map { UINavigationController(rootViewController: $0) }
    }

    private func setupTabBar() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .mhSystemBackground
        
        tabBar.tintColor = .habitsPurple
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
    }
}

//
//  TabBarViewController.swift
//  MyHabits
//
//  Created by Razumov Pavel on 07.04.2025.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupControllers()
    }
    
    private func setupControllers() {
        let habitsVC = HabitsViewController()
        habitsVC.tabBarItem = UITabBarItem(
            title: "Привычки",
            image: UIImage(named: "habits_tab_icon"),
            selectedImage: nil
        )
        
        let infoVC = InfoViewController()
        infoVC.tabBarItem = UITabBarItem(
            title: "Информация",
            image: UIImage(systemName: "info.circle.fill"),
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

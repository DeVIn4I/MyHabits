//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Razumov Pavel on 07.04.2025.
//

import UIKit

final class HabitsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupNavigationBar(isLargeTitle: true)
        title = "Сегодня"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addHabit)
        )
        navigationItem.rightBarButtonItem?.tintColor = .habitsPurple
    }
    
    @objc private func addHabit() {
        let createHabitVC = CreateHabitViewController()
        createHabitVC.navigationItem.hidesBackButton = true
        navigationController?.pushViewController(createHabitVC, animated: true)
    }
}

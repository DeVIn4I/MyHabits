//
//  CreateHabitViewController.swift
//  MyHabits
//
//  Created by Razumov Pavel on 07.04.2025.
//

import UIKit

final class CreateHabitViewController: UIViewController {
    
    private let createHabitView = CreateHabitView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Отменить",
            style: .plain,
            target: self,
            action: #selector(cancel)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Сохранить",
            style: .plain,
            target: self,
            action: #selector(save)
        )
        title = "Создать"
        navigationItem.largeTitleDisplayMode = .never        
        navigationItem.rightBarButtonItem?.isEnabled = false
        createHabitView.onFormChanged = { [weak self] isValid in
            self?.navigationItem.rightBarButtonItem?.isEnabled = isValid
        }
        
        view.addSubview(createHabitView)
        createHabitView.presentViewController = self
        createHabitView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createHabitView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            createHabitView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createHabitView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    @objc private func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func save() {
        createHabitView.saveHabit()
        navigationController?.popViewController(animated: true)
    }
}

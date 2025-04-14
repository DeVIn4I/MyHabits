//
//  CreateHabitViewController.swift
//  MyHabits
//
//  Created by Razumov Pavel on 07.04.2025.
//

import UIKit

enum Mode {
    case create
    case edit(Habit)
}

final class CreateOrEditHabitViewController: UIViewController {
    
    //MARK: - Private Properties
    private let createOrEditHabitView = CreateOrEditHabitView()
    private let mode: Mode
    private let store: HabitsStore
    private var habit: Habit?
    
    private lazy var deleteHabitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(deleteHabitButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    //MARK: - Initialization
    init(mode: Mode, store: HabitsStore) {
        self.mode = mode
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        if case .edit(let habit) = mode {
            navigationItem.title = Constants.Text.CreateOrEditHabit.editTitle
            createOrEditHabitView.edit(habit)
            deleteHabitButton.isHidden = false
            self.habit = habit
        } else {
            navigationItem.title = Constants.Text.CreateOrEditHabit.createTitle
            deleteHabitButton.isHidden = true
        }
        
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: Constants.Text.CreateOrEditHabit.leftBarButton,
            style: .plain,
            target: self,
            action: #selector(cancel)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: Constants.Text.CreateOrEditHabit.rightBarButton,
            style: .plain,
            target: self,
            action: #selector(save)
        )
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem?.isEnabled = false
        createOrEditHabitView.onFormChanged = { [weak self] isValid in
            self?.navigationItem.rightBarButtonItem?.isEnabled = isValid
        }
        
        view.addSubview(deleteHabitButton)
        view.addSubview(createOrEditHabitView)
        createOrEditHabitView.presentViewController = self
        createOrEditHabitView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            createOrEditHabitView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            createOrEditHabitView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createOrEditHabitView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            deleteHabitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            deleteHabitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            deleteHabitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            deleteHabitButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    //MARK: - Objc Methods
    @objc private func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func save() {
        createOrEditHabitView.save()
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func deleteHabitButtonTapped() {
        if let deleteHabit = habit {
            let alertModel = AlertModel(title: "Удалить привычку", message: "Вы хотите удалить привычку\n\"\(deleteHabit.name)\"")
            let alert = UIAlertController(title: alertModel.title, message: alertModel.message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            let deleteAction = UIAlertAction(title: "Удалить", style: .destructive, handler: { [weak self] _ in
                self?.store.habits.removeAll(where: { $0 == deleteHabit })
                self?.navigationController?.popToRootViewController(animated: true)
            })
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            present(alert, animated: true)
        }
    }
}

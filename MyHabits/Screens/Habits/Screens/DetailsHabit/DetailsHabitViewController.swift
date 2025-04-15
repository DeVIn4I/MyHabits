//
//  DetailsHabitViewController.swift
//  MyHabits
//
//  Created by Razumov Pavel on 09.04.2025.
//

import UIKit

final class DetailsHabitViewController: UIViewController {
    
    //MARK: - Private Storage Properties
    private let habit: Habit
    private let store: HabitsStore
    private let habitIndex: Int?
    
    //MARK: - Private Computed Properties
    private lazy var dateListTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Initialization
    init(habit: Habit, store: HabitsStore) {
        self.habit = habit
        self.store = store
        self.habitIndex = store.habits.firstIndex(of: habit)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let index = habitIndex {
            let updateHabit = store.habits[index]
            title = updateHabit.name
            dateListTableView.reloadData()
        }
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        view.addSubview(dateListTableView)
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: Constants.Text.DetailsHabit.rightBarButton,
            style: .plain,
            target: self,
            action: #selector(edtiHabit)
        )
        title = habit.name
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dateListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dateListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            dateListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            dateListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    //MARK: - Objc Methods
    @objc private func edtiHabit() {
        let createHabitVC = CreateOrEditHabitViewController(mode: .edit(habit), store: store)
        createHabitVC.navigationItem.hidesBackButton = true
        navigationController?.pushViewController(createHabitVC, animated: true)
    }
}

//MARK: - DetailsHabitViewController: UITableViewDataSource
extension DetailsHabitViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        store.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let date = store.dates.reversed()[indexPath.row]
        let index = store.dates.firstIndex {
            Calendar.current.isDate($0, equalTo: date, toGranularity: .day)
        }
        let formattedDate = store.trackDateString(forIndex: index ?? 0) ?? ""
        let isTracked = store.habit(habit, isTrackedIn: date)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var configure = cell.defaultContentConfiguration()
        configure.text = formattedDate
        cell.contentConfiguration = configure
        
        if isTracked {
            let icon = UIImageView(image: UIImage(systemName: "checkmark"))
            icon.tintColor = .habitsPurple
            cell.accessoryView = icon
        } else {
            cell.accessoryView = nil
        }
        return cell
    }
}

//MARK: - DetailsHabitViewController: UITableViewDelegate
extension DetailsHabitViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        Constants.Text.DetailsHabit.titleForHeader
    }
}

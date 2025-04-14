//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Razumov Pavel on 07.04.2025.
//

import UIKit

final class HabitsViewController: UIViewController {
    
    //MARK: - Private properties
    private let store: HabitsStore
    
    private lazy var habitsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            ProgressCollectionViewCell.self,
            forCellWithReuseIdentifier: ProgressCollectionViewCell.identifier
        )
        collectionView.register(
            HabitCollectionViewCell.self,
            forCellWithReuseIdentifier: HabitCollectionViewCell.identifier
        )
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isHidden = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var emptyHabitsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = Constants.Text.Habits.emptyHabitsList
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Initialization
    init(store: HabitsStore) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .habitsLightGray
        setupNavigationBar(isLargeTitle: true)
        navigationItem.title = Constants.Text.Habits.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addHabit)
        )
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let isHaveHabits = store.habits.count > 0
        habitsCollectionView.isHidden = !isHaveHabits
        emptyHabitsLabel.isHidden = isHaveHabits
        habitsCollectionView.reloadData()
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        view.addSubview(habitsCollectionView)
        view.addSubview(emptyHabitsLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            habitsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22),
            habitsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            habitsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            habitsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -22),
            
            emptyHabitsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyHabitsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    //MARK: - Objc Methods
    @objc private func addHabit() {
        let createHabitVC = CreateOrEditHabitViewController(mode: .create)
        createHabitVC.navigationItem.hidesBackButton = true
        navigationController?.pushViewController(createHabitVC, animated: true)
    }
}

//MARK: - HabitsViewController: UICollectionViewDataSource
extension HabitsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == 0 ? 1 : store.habits.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProgressCollectionViewCell.identifier,
                for: indexPath
            ) as? ProgressCollectionViewCell else {
                return UICollectionViewCell()
            }
            let progress = HabitsStore.shared.todayProgress
            cell.configure(with: progress)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HabitCollectionViewCell.identifier,
                for: indexPath
            ) as? HabitCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let habit = store.habits[indexPath.item]
            cell.configure(with: habit)
            cell.onTrackHabit = { [weak self] in
                if !habit.isAlreadyTakenToday {
                    self?.store.track(habit)
                    self?.habitsCollectionView.reloadData()
                }
            }
            return cell
        }
    }
}

//MARK: - HabitsViewController: UICollectionViewDelegateFlowLayout
extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.frame.width
        if indexPath.section == 0 {
            return CGSize(width: width, height: width * 0.17)
        } else {
            return CGSize(width: width, height: width * 0.37)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 18, right: 0)
        } else {
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 { return }
        
        let habit = store.habits[indexPath.item]
        let detailsVC = DetailsHabitViewController(habit: habit, store: store)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

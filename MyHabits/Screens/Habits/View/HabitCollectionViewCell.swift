//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Razumov Pavel on 07.04.2025.
//

import UIKit

final class HabitCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Private computed properties
    private lazy var habitNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.numberOfLines = 2
        label.textColor = .systemBlue
        label.text = "Habit Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var habitDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray2
        label.text = "Каждый день в 7:30"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var habitCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray
        label.text = "Счётчик: 0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var habitDescriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [habitNameLabel, habitDateLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [habitDescriptionStackView, habitCountLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var trackHabitButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(trackHabitButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var untrackHabitView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemYellow.cgColor
        view.clipsToBounds = true
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var trackHabitView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        view.isUserInteractionEnabled = false
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var checkmarkImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "habit_checkmark"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Public Properties
    var onTrackHabit: (() -> Void)?
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override Methods
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        layoutIfNeeded()
        untrackHabitView.layer.cornerRadius = untrackHabitView.frame.width / 2
        trackHabitView.layer.cornerRadius = trackHabitView.frame.width / 2
    }
    
    //MARK: - Public Methods
    func configure(with habit: Habit) {
        habitNameLabel.text = habit.name
        habitNameLabel.textColor = habit.color
        habitDateLabel.text = habit.dateString
        untrackHabitView.layer.borderColor = habit.color.cgColor
        trackHabitView.backgroundColor = habit.color
        habitCountLabel.text = "Счётчик: \(habit.trackDates.count)"
        
        untrackHabitView.alpha = habit.isAlreadyTakenToday ? 0 : 1
        trackHabitView.alpha = habit.isAlreadyTakenToday ? 1 : 0
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        [labelsStackView, trackHabitButton].forEach { contentView.addSubview($0) }
        [untrackHabitView, trackHabitView].forEach { trackHabitButton.addSubview($0) }
        trackHabitView.addSubview(checkmarkImageView)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            labelsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            labelsStackView.trailingAnchor.constraint(equalTo: trackHabitButton.leadingAnchor, constant: -26),
            labelsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            trackHabitButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.16),
            trackHabitButton.heightAnchor.constraint(equalTo: trackHabitButton.widthAnchor),
            trackHabitButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            trackHabitButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            untrackHabitView.centerXAnchor.constraint(equalTo: trackHabitButton.centerXAnchor),
            untrackHabitView.centerYAnchor.constraint(equalTo: trackHabitButton.centerYAnchor),
            untrackHabitView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1),
            untrackHabitView.heightAnchor.constraint(equalTo: untrackHabitView.widthAnchor),
            
            trackHabitView.centerXAnchor.constraint(equalTo: trackHabitButton.centerXAnchor),
            trackHabitView.centerYAnchor.constraint(equalTo: trackHabitButton.centerYAnchor),
            trackHabitView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1),
            trackHabitView.heightAnchor.constraint(equalTo: untrackHabitView.widthAnchor),
            
            checkmarkImageView.centerXAnchor.constraint(equalTo: trackHabitView.centerXAnchor),
            checkmarkImageView.centerYAnchor.constraint(equalTo: trackHabitView.centerYAnchor),
        ])
    }
    
    //MARK: - Objc Methods
    
    @objc private func trackHabitButtonTapped() {
        onTrackHabit?()
    }
}

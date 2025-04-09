//
//  CreateHabitView.swift
//  MyHabits
//
//  Created by Razumov Pavel on 07.04.2025.
//

import UIKit

final class CreateHabitView: UIView {
    // MARK: - Private Stored Properties
    private let time = Time()
    private var habitName: String?
    private var habitTime: Date?
    private var habitColor: UIColor? = .random()
    
    // MARK: - Private Computed Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textAlignment = .center
        label.text = "НАЗВАНИЕ"
        return label
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.textColor = .habitsBlue
        textField.font = .systemFont(ofSize: 17, weight: .semibold)
        let placeholderText = "Бегать по утрам, спать 8 часов и т.п."
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17, weight: .regular),
            .foregroundColor: UIColor.systemGray
        ]
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: placeholderAttributes
        )
        textField.addTarget(self, action: #selector(titleTextFieldEditing), for: .editingChanged)
        textField.delegate = self
        return textField
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, titleTextField])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textAlignment = .center
        label.text = "ЦВЕТ"
        return label
    }()
    
    private lazy var colorView: UIView = {
        let view = UIView()
        view.backgroundColor = habitColor
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapColorView))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var colorStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [colorLabel, colorView])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textAlignment = .center
        label.text = "ВРЕМЯ"
        return label
    }()
    
    private lazy var choiseTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    
    private lazy var timeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [timeLabel, choiseTimeLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    // MARK: - Public Properties
    weak var presentViewController: UIViewController?
    var onFormChanged: ((Bool) -> Void)?
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        updateChoiseLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func saveHabit() {
        guard
            let name = habitName,
            let date = habitTime,
            let color = habitColor
        else { return }
        let habit = Habit(name: name, date: date, color: color)
        HabitsStore.shared.habits.append(habit)
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        [
            titleStackView, colorStackView,
            timeStackView, pickerView
        ].forEach { addSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: topAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            colorView.heightAnchor.constraint(equalToConstant: 30),
            colorView.widthAnchor.constraint(equalToConstant: 30),
            
            colorStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 18),
            colorStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            timeStackView.topAnchor.constraint(equalTo: colorStackView.bottomAnchor, constant: 18),
            timeStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            timeStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            pickerView.topAnchor.constraint(equalTo: timeStackView.bottomAnchor, constant: 18),
            pickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func updateChoiseLabel() {
        let baseText = "Каждый день в "
        let timeText = choiseTimeLabel.text ?? "..."
        let attributedText = NSMutableAttributedString(
            string: baseText,
            attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .regular)]
        )
        
        attributedText.append(
            NSAttributedString(
                string: timeText,
                attributes: [
                    .font: UIFont.systemFont(ofSize: 17, weight: .regular),
                    .foregroundColor: UIColor.habitsPurple
                ]
            )
        )
        choiseTimeLabel.attributedText = attributedText
    }
    
    private func openColorPicker() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.selectedColor = colorView.backgroundColor ?? .random()
        colorPicker.delegate = self
        presentViewController?.present(colorPicker, animated: true)
    }
    
    private func validForm() {
        let isValid = !(habitName?.isEmpty ?? true) &&
            habitTime != nil &&
            habitColor != nil
        onFormChanged?(isValid)
    }
    
    //MARK: - Objc Methods
    @objc private func titleTextFieldEditing(sender: UITextField) {
        habitName = sender.text ?? ""
        validForm()
    }
    
    @objc private func didTapColorView() {
        openColorPicker()
    }
}

//MARK: - CreateHabitView: UIColorPickerViewControllerDelegate
extension CreateHabitView: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        colorView.backgroundColor = color
        habitColor = color
        validForm()
    }
}

//MARK: - CreateHabitView: UIPickerViewDelegate
extension CreateHabitView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: return time.hours[row]
        case 1: return time.minutes[row]
        case 2: return time.meridiems[row]
        default: return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedHour = time.hours[pickerView.selectedRow(inComponent: 0)]
        let selectedMinute = time.minutes[pickerView.selectedRow(inComponent: 1)]
        let selectedMeridiem = time.meridiems[pickerView.selectedRow(inComponent: 2)]
        let timeString = "\(selectedHour):\(selectedMinute) \(selectedMeridiem)"
        choiseTimeLabel.text = timeString
        updateChoiseLabel()
        habitTime = Date.makeDate(from: timeString)
        validForm()
    }
}

//MARK: - CreateHabitView: UIPickerViewDataSource
extension CreateHabitView: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return time.hours.count
        case 1: return time.minutes.count
        case 2: return time.meridiems.count
        default: return 0
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
}

//MARK: - CreateHabitView: UITextFieldDelegate
extension CreateHabitView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

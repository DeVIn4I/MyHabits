//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Razumov Pavel on 07.04.2025.
//

import UIKit

final class InfoViewController: UIViewController {
    
    private lazy var infoTextView: UITextView = {
        let attributedText = NSMutableAttributedString(
            string: Constants.Text.Info.infoTextHeader,
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold)]
        )
        attributedText.append(
            NSAttributedString(
                string: Constants.Text.Info.infoText,
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)]
            )
        )
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.attributedText = attributedText
        textView.isEditable = false
        return textView
    }()

    override func viewDidLoad() {
        setupNavigationBar()
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = Constants.Text.Info.title
        
        view.addSubview(infoTextView)
        NSLayoutConstraint.activate([
            infoTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22),
            infoTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 16),
            infoTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            infoTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

//
//  PasswordRequirementItem.swift
//  viewCodeLogin
//
//  Created by Adriel de Souza on 02/05/25.
//

import UIKit

class PasswordRequirementItem: UIView {
    private var _hasAchieved = false

    var hasAchieved: Bool {
        get {
            _hasAchieved
        }
        set {
            handleAchievement(newValue)
            _hasAchieved = newValue
        }
    }

    var achievementText: String? {
        didSet {
            label.text = achievementText
        }
    }

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Password requirement"
        label.font = Fonts.footnote
        label.textColor = .Label.primary
        return label
    }()

    private lazy var imageView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "xmark"))
        view.translatesAutoresizingMaskIntoConstraints = false

        view.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 15),
            view.heightAnchor.constraint(equalToConstant: 15)
        ])

        return view
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [imageView, label])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 8
        return view
    }()

    // MARK: Overrides default UIStackView inits
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        handleAchievement(false)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        handleAchievement(false)
    }

    init(_ title: String){
        super.init(frame: .zero)
        label.text = title
        handleAchievement(false)
        setup()
    }
}

extension PasswordRequirementItem {
    private func handleAchievement(_ hasAchieved: Bool){
        if hasAchieved {
            imageView.image = UIImage(systemName: "checkmark")
            imageView.tintColor = .Colors.success
            label.isEnabled = true
        } else {
            imageView.image = UIImage(systemName: "xmark")
            imageView.tintColor = .Colors.error
            label.isEnabled = false
        }
    }
}

extension PasswordRequirementItem: ViewCodeProtocol {
    func addSubViews() {
        addSubview(stackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

//
//  TaskCategorySelector.swift
//  TaskMate
//
//  Created by Adriel de Souza on 06/05/25.
//

import UIKit

class TaskCategorySelector: UIView {
    // MARK: Subviews

    private lazy var label: UILabel = {
        var label = UILabel()
        label.text = "Category"
        label.font = UIFont(name: "SFPro-Regular", size: 17)
        return label
    }()

    private lazy var button: UIButton = {
        var button = UIButton()

        var configuration = UIButton.Configuration.plain()
        configuration.title = "Select"
        configuration.indicator = .popup
        button.configuration = configuration

        button.menu = UIMenu(options: [.singleSelection], children: categorySelections)
        button.showsMenuAsPrimaryAction = true

        button.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

        return button
    }()

    private lazy var icon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "list.bullet"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit

        let imageSize: Double = 20
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: imageSize),
            imageView.heightAnchor.constraint(equalToConstant: imageSize)
        ])

        return imageView
    }()

    private lazy var iconContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 7
        container.backgroundColor = .Colors.accent
        container.clipsToBounds = true

        container.addSubview(icon)
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalToConstant: 30),
            container.heightAnchor.constraint(equalToConstant: 30),

            icon.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])

        return container
    }()

    private lazy var stack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [iconContainer, label, button])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.spacing = 12
        return stack
    }()

    // MARK: Properties
    private var categorySelections: [UIAction] {
        TaskCategory.allCases.sorted { $0.rawValue < $1.rawValue }
            .map { category in
                UIAction(
                    title: category.rawValue,
                    image: UIImage(systemName: category.imageName)
                )
                { [weak self] _ in
                        self?.selectedCategory = category
                }
            }
    }

    var selectedCategory: TaskCategory? {
        didSet {
            button.setTitle(
                selectedCategory?.rawValue ?? "Select",
                for: .normal
            )
        }
    }

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TaskCategorySelector: ViewCodeProtocol {
    func setup() {
        self.backgroundColor = UIColor.Background.tertiary
        self.layer.cornerRadius = 8

        addSubViews()
        setupConstraints()
    }

    func addSubViews() {
        addSubview(stack)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.heightAnchor.constraint(equalToConstant: 46),

            iconContainer.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 16)
        ])
    }
}

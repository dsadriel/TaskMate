//
//  EmptyStateView.swift
//  TaskMate
//
//  Created by Adriel de Souza on 06/05/25.
//

import UIKit

class EmptyStateView: UIView {
    var delegate: AddEditTaskDelegate?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No tasks yet!"
        label.textAlignment = .center
        label.font = UIFont(name: "SFPro-Semibold", size: 17)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add a new task and it will show up here."
        label.textAlignment = .center
        label.font = UIFont(name: "SFPro-Regular", size: 17)
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "task.empty"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 92),
            imageView.heightAnchor.constraint(equalToConstant: 72)
        ])
        return imageView
    }()

    lazy var button: UIButton = {
        let btn = createRoundedButton(
            labelText: "Add New Task",
            backgroundColor: .Colors.accent,
            textColor: .white,
            labelFont: Fonts.bodySemibold
        )

        btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return btn
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, descriptionLabel, button])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()


    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    var buttonAction: () -> Void = {}

    @objc func buttonTapped() {
        buttonAction()
    }
}

extension EmptyStateView: ViewCodeProtocol {
    func addSubViews() {
        addSubview(stackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            button.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 32),

            button.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
    }
}

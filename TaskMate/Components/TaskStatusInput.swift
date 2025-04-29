//
//  TaskStatusInput.swift
//  TaskMate
//
//  Created by Adriel de Souza on 09/05/25.
//

import UIKit

class TaskStatusInput: UIView {
    // MARK: - Attributes
    var isCompleted = false {
        didSet {
            updateButtonAppearance()
        }
    }

    // MARK: - Overrides default UIStackView inits
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    // MARK: - UI Elements
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        
        if let imageView = button.imageView {
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        button.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Status"
        label.font = Fonts.body
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [button, label])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()
    
    
    // MARK: - Function
    @objc private func handleButtonTap() {
        isCompleted.toggle()
        updateButtonAppearance()
    }
    
    func updateButtonAppearance() {
        let imageName = isCompleted ? "checkmark.circle.fill" : "circle"
        let imageTintColor: UIColor = isCompleted ? .Colors.accent : .tertiaryLabel
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.tintColor = imageTintColor
    }
}

extension TaskStatusInput: ViewCodeProtocol {
    func setup(){
        self.backgroundColor = UIColor.Background.tertiary
        self.layer.cornerRadius = 8
        updateButtonAppearance()
        addSubViews()
        setupConstraints()
    }
    
    func addSubViews() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

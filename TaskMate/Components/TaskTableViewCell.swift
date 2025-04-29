//
//  TaskTableViewCell.swift
//  TaskMate
//
//  Created by Adriel de Souza on 08/05/25.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    static var reuseIdentifier = "TaskTableViewCell"
    var isCompleted = false {
        didSet {
            let imageName = isCompleted ? "checkmark.circle.fill" : "circle"
            let imageTintColor: UIColor = isCompleted ? .Colors.accent : .tertiaryLabel
            button.setImage(UIImage(systemName: imageName), for: .normal)
            button.tintColor = imageTintColor
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        label.text = "Task"
        label.font = Fonts.body
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [button, label])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 13
        return stackView
    }()
    
    // MARK: - Functions
    
    var buttonAction: () -> Void = {}
    
    @objc private func handleButtonTap() {
        buttonAction()
    }
    
    func config(with task: TaskItem, buttonAction: @escaping () -> Void) {
        label.text = task.name
        isCompleted = task.isCompleted
        self.buttonAction = buttonAction
    }
}

extension TaskTableViewCell: ViewCodeProtocol {
    func setup() {
        addSubViews()
        setupConstraints()
    }
    func addSubViews() {
        contentView.addSubview(stackView)
    }

    func setupConstraints() {
        stackView.addSafeMargin(contentView)
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 44),
            
            button.heightAnchor.constraint(equalToConstant: 24),
            button.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        if let imageView = button.imageView {
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalToConstant: 24),
                imageView.widthAnchor.constraint(equalToConstant: 24)
            ])
        }
    }
}

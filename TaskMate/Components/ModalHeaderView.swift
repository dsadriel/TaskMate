//
//  ModalHeaderView.swift
//  TaskMate
//
//  Created by Adriel de Souza on 08/05/25.
//

import UIKit

class ModalHeaderView: UIView {
    // MARK: Overrides default UIStackView inits
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    // MARK: - Configuration
    var headerText: String? {
        get {
             title.text
        }
        set {
            title.text = newValue
        }
    }

    var leftButtonAction: () -> Void = {}
    @objc func leftButtonTapped() {leftButtonAction()}
    
    var isLeftButtonEnabled = true {
        didSet {
            leftButton.isEnabled = isLeftButtonEnabled
        }
    }
    
    var leftButtonText: String? {
        didSet {
            leftButton.setTitle(leftButtonText, for: .normal)
            leftButton.isHidden = leftButtonText == nil
        }
    }
    
    var rightButtonAction: () -> Void = {}
    @objc func rightButtonTapped() {rightButtonAction()}
    
    var isRightButtonEnabled = true {
        didSet {
            rightButton.isEnabled = isRightButtonEnabled
        }
    }
    
    var rightButtonText: String? {
        didSet {
            rightButton.setTitle(rightButtonText, for: .normal)
            rightButton.isHidden = rightButtonText == nil
        }
    }

    // MARK: - UI Elements
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Header title"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)

        return label
    }()

    private lazy var leftButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.isHidden = true
        btn.setTitleColor(.Colors.accent, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)

        btn.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)

        return btn
    }()
    
    private lazy var rightButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.isHidden = true
        btn.setTitleColor(.Colors.accent, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)

        btn.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)

        return btn
    }()


    private lazy var actionStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [leftButton, title, rightButton])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.alignment = .center
        view.spacing = 8

        return view
    }()
}

extension ModalHeaderView: ViewCodeProtocol {
    func setup(){
        addSubViews()
        setupConstraints()
    }
    func addSubViews() {
        addSubview(actionStack)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            actionStack.topAnchor.constraint(equalTo: topAnchor),
            actionStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            actionStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            actionStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

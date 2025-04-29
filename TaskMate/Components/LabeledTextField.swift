//
//  TextInput.swift
//  viewCodeLogin
//
//  Created by Adriel de Souza on 29/04/25.
//

import UIKit

class LabeledTextField: UIView {
    // MARK: Public attributes

    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }

    var labelText: String? {
        get { label.text }
        set { label.text = newValue }
    }

    var placeholder: String? {
        get { textField.placeholder }
        set { textField.placeholder = newValue }
    }

    var textContentType: UITextContentType? {
        get { textField.textContentType }
        set { textField.textContentType = newValue }
    }

    var keyboardType: UIKeyboardType {
        get { textField.keyboardType }
        set { textField.keyboardType = newValue }
    }

    var isSecureTextEntry: Bool {
        get { textField.isSecureTextEntry }
        set { textField.isSecureTextEntry = newValue }
    }

    var textFieldDelegate: UITextFieldDelegate? {
        didSet {
            textField.delegate = textFieldDelegate
        }
    }

    var borderStyle: UITextField.BorderStyle {
        get { textField.borderStyle }
        set { textField.borderStyle = newValue }
    }

    var cornerRadius: Double {
        get { textField.layer.cornerRadius }
        set { textField.layer.cornerRadius = newValue }
    }

    var isEnabled: Bool {
        get { textField.isEnabled }
        set { textField.isEnabled = newValue }
    }


    // MARK: Component parts

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label text"
        label.font = Fonts.calloutSemibold
        label.textColor = .Label.primary
        return label
    }()

    private lazy var textField: InsetedTextField = {
        let field = InsetedTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()


    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label, textField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    // MARK: Overrides default UIStackView inits

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
}

extension LabeledTextField: ViewCodeProtocol {
    func addSubViews() {
        addSubview(stackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

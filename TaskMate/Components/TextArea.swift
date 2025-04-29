//
//  TextArea.swift
//  TaskMate
//
//  Created by Adriel de Souza on 07/05/25.
//

import UIKit

class TextArea: UIView {
    // MARK: - Public attributes
    var font: UIFont? {
        get {
            textView.font
        }
        set {
            textView.font = newValue
        }
    }

    var text: String? {
        get {
            textView.text
        }
        set {
            textView.text = newValue
        }
    }

    var placeholder: String? {
        get {
            placeholderLabel.text
        }
        set {
            placeholderLabel.text = newValue
        }
    }
    
    var placeholderIsHidden = false {
        didSet {
            placeholderLabel.isHidden = placeholderIsHidden
        }
    }

    private lazy var textView: UITextView = {
        let input = UITextView()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.backgroundColor = UIColor.Background.tertiary

        input.borderStyle = .none
        input.layer.cornerRadius = 8
        input.font = Fonts.body

        input.heightAnchor.constraint(equalToConstant: 121).isActive = true

        input.delegate = self

        return input
    }()

    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "Placeholder"
        label.font = Fonts.body
        label.textColor = .placeholderText
        return label
    }()

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(){
        addSubViews()
        setupConstraints()

        self.font = Fonts.body
        self.layer.cornerRadius = 8
        self.backgroundColor = .tertiarySystemBackground
    }
}


extension TextArea: ViewCodeProtocol {
    func addSubViews() {
        self.addSubview(textView)
        self.addSubview(placeholderLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            textView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}


extension TextArea: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}

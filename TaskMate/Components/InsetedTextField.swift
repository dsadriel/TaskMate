//
//  InsetedTextField.swift
//  TaskMate
//
//  Created by Adriel de Souza on 06/05/25.
//

import UIKit

class InsetedTextField: UITextField {
    var insetX: Double = 16
    var insetY: Double = 12

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    init(x: Double, y: Double) {
        super.init(frame: .zero)
        setup()
        insetX = x
        insetY = y
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: insetX, dy: insetY)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        textRect(forBounds: bounds)
    }
}


extension InsetedTextField: ViewCodeProtocol {
    func setup() {
        self.placeholder = "Placeholder"
        self.font = Fonts.callout
        self.backgroundColor = .Background.tertiary
        self.borderStyle = .roundedRect
    }
    func addSubViews() {
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(lessThanOrEqualToConstant: 46)
        ])
    }
}

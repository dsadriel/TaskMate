//
//  RoundedButton.swift
//  viewCodeLogin
//
//  Created by Adriel de Souza on 29/04/25.
//

import UIKit

func createRoundedButton(labelText: String, backgroundColor: UIColor, textColor: UIColor, labelFont: UIFont?, buttonHeight: Double = 50, textAlignment: NSTextAlignment = .center) -> UIButton {
    var config = UIButton.Configuration.filled()
    config.baseBackgroundColor = backgroundColor

    let attributes: [NSAttributedString.Key: Any] = [
        .font: labelFont ?? .systemFont(ofSize: 17),
        .foregroundColor: textColor
    ]

    config.attributedTitle = AttributedString(labelText, attributes: AttributeContainer(attributes))


    let button = UIButton(configuration: config)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.layer.cornerRadius = 12
    button.layer.masksToBounds = true


    NSLayoutConstraint.activate([
        button.heightAnchor.constraint(equalToConstant: buttonHeight)
    ])

    return button
}

//
//  ApplyGradient.swift
//  viewCodeLogin
//
//  Created by Adriel de Souza on 30/04/25.
//

import UIKit


// MARK: applyGradient
extension UIView {
    func applyGradient(colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map(\.cgColor)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

// MARK: addSafeMargin
extension UIView {
    func addSafeMargin(_ view: UIView, const: Double = 16) {
        NSLayoutConstraint.activate([
                                        leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: const),
                                        trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -const)
        ])
    }
}

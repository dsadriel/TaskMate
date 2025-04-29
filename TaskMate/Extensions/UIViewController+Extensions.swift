//
//  showAlert.swift
//  viewCodeLogin
//
//  Created by Adriel de Souza on 30/04/25.
//

import UIKit


// MARK: showAlert
extension UIViewController {
    func showAlert(title: String, message: String, buttonTitle: String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: buttonTitle, style: .default))

        self.present(alert, animated: true)
    }

    func setupAutoDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

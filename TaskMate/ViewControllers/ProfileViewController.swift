//
//  ProfileViewController.swift
//  viewCodeLogin
//
//  Created by Adriel de Souza on 05/05/25.
//

import UIKit

class ProfileViewController: UIViewController {
    private lazy var nameInput: LabeledTextField = {
        let input = LabeledTextField()
        input.labelText = "Full Name"
        input.isEnabled = false
        return input
    }()

    private lazy var emailInput: LabeledTextField = {
        let input = LabeledTextField()
        input.labelText = "Email"
        input.isEnabled = false
        return input
    }()

    private lazy var dateOfBirthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Date of Birth"
        label.font = Fonts.calloutSemibold
        label.textColor = .Label.primary
        return label
    }()

    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.isEnabled = false

        return datePicker
    }()

    private lazy var dateOfBirthStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            dateOfBirthLabel, datePicker
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()

    private lazy var accountDataStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameInput, dateOfBirthStack, emailInput
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()


    private lazy var logoutButton: UIButton = {
        let button = createRoundedButton(labelText: "Logout", backgroundColor: .Background.tertiary, textColor: .Colors.accent, labelFont: Fonts.body)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        return button
    }()

    private lazy var deleteAccountButton: UIButton = {
        let button = createRoundedButton(labelText: "Delete Account", backgroundColor: .Background.tertiary, textColor: .Colors.error, labelFont: Fonts.bodySemibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteAccountAction), for: .touchUpInside)
        return button
    }()

    private lazy var accountActionsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [logoutButton, deleteAccountButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16

        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let user = Persistance.getApplicaitonData().loggedInAccount else {
            fatalError("User not logged in")
        }

        datePicker.date = user.birthDate
        nameInput.text = user.fullName
        emailInput.text = user.email

        navigationItem.title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true

        setup()
    }

    @objc func logoutAction() {
        Persistance.logout()
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(to: UINavigationController(rootViewController: LoginViewController()))
    }

    @objc func deleteAccountAction() {
        guard let account = Persistance.getApplicaitonData().loggedInAccount else {
            fatalError( "User not logged in")
        }

        Persistance.logout()
        Persistance.deleteAccount(email: account.email)

        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(to: UINavigationController(rootViewController: LoginViewController()))

        showAlert(title: "Account deletion successfull", message: "Your account has been deleted.")
    }
}


extension ProfileViewController: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(accountDataStack)
        view.addSubview(accountActionsStack)
    }

    func setupConstraints() {
        accountDataStack.addSafeMargin(view)
        accountActionsStack.addSafeMargin(view)

        NSLayoutConstraint.activate([
            accountDataStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            accountActionsStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
        ])
    }
}

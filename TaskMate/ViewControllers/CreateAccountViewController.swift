//
//  CreateAccountViewController.swift
//  viewCodeLogin
//
//  Created by Adriel de Souza on 29/04/25.
//

import UIKit

class CreateAccountViewController: UIViewController {
    private lazy var createAccountTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create Account"
        label.font = Fonts.title1
        label.textAlignment = .center
        return label
    }()

    private lazy var nameInput: LabeledTextField = {
        let input = LabeledTextField()
        input.labelText = "Full Name"
        input.placeholder = "Your name here"
        input.textContentType = .emailAddress
        return input
    }()

    private lazy var emailInput: LabeledTextField = {
        let input = LabeledTextField()
        input.labelText = "Email"
        input.placeholder = "abc@abc.com"
        input.textContentType = .emailAddress
        input.keyboardType = .emailAddress
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

    private lazy var passwordInput: LabeledTextField = {
        let input = LabeledTextField()
        input.labelText = "Password"
        input.placeholder = "Must be 8 characters"
        input.textContentType = .password
        input.isSecureTextEntry = true
        input.textFieldDelegate = self
        return input
    }()

    private lazy var termsSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = false

        return toggle
    }()

    private lazy var termsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "I accept the term and privacy policy"
        label.font = Fonts.calloutSemibold
        label.textColor = .Label.primary
        return label
    }()

    private lazy var termsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [termsSwitch, termsLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 16
        return stack
    }()


    private lazy var createAccountButton: UIButton = {
        createRoundedButton(
            labelText: "Create Account",
            backgroundColor: .Colors.accent,
            textColor: .white,
            labelFont: Fonts.bodySemibold
        )
    }()

    // MARK: Password Validation

    private lazy var hasAtLeast8CharactersRequiremntItem: PasswordRequirementItem = { PasswordRequirementItem("At least 8 characters") }()
    private lazy var hasAtLeast1NumberRequiremntItem: PasswordRequirementItem = { PasswordRequirementItem("At least 1 number") }()
    private lazy var hasAtLeast1UpperCaseRequiremntItem: PasswordRequirementItem = { PasswordRequirementItem("At least 1 uppercase letter") }()
    private lazy var hasAtLeast1SpecialRequiremntItem: PasswordRequirementItem = { PasswordRequirementItem("At least 1 special character") }()

    private lazy var requirementsItemsStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            hasAtLeast8CharactersRequiremntItem,
            hasAtLeast1NumberRequiremntItem,
            hasAtLeast1UpperCaseRequiremntItem,
            hasAtLeast1SpecialRequiremntItem
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private lazy var createAccountFormStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameInput, dateOfBirthStack, emailInput, passwordInput, requirementsItemsStack, termsStack
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupAutoDismissKeyboard()

        setup()

        view.backgroundColor = .Background.secondary

        createAccountButton.addTarget(
            self,
            action: #selector(createAccountButtonAction),
            for: .touchUpInside
        )
    }
}


// MARK: ViewCodeProtocol
extension CreateAccountViewController: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(createAccountTitleLabel)
        view.addSubview(createAccountFormStack)
        view.addSubview(createAccountButton)
    }

    func setupConstraints() {
        createAccountTitleLabel.addSafeMargin(view)
        createAccountFormStack.addSafeMargin(view)
        createAccountButton.addSafeMargin(view)

        NSLayoutConstraint.activate([
            createAccountTitleLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 20
            ),
            createAccountFormStack.topAnchor.constraint(
                equalTo: createAccountTitleLabel.bottomAnchor,
                constant: 32
            ),
            createAccountButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -40
            ),

            requirementsItemsStack.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 8),

            hasAtLeast8CharactersRequiremntItem.leadingAnchor.constraint(equalTo: requirementsItemsStack.leadingAnchor, constant: 16),
            hasAtLeast1NumberRequiremntItem.leadingAnchor.constraint(equalTo: requirementsItemsStack.leadingAnchor, constant: 16),
            hasAtLeast1UpperCaseRequiremntItem.leadingAnchor.constraint(equalTo: requirementsItemsStack.leadingAnchor, constant: 16),
            hasAtLeast1SpecialRequiremntItem.leadingAnchor.constraint(equalTo: requirementsItemsStack.leadingAnchor, constant: 16)
        ])
    }
}

// MARK: createAccountButtonAction
extension CreateAccountViewController {
    func clearFormFields() {
        nameInput.text = ""
        emailInput.text = ""
        passwordInput.text = ""
        termsSwitch.isOn = false
        datePicker.date = Date()
    }

    @objc func createAccountButtonAction(_ sender: UIButton!) {
        let fullName = nameInput.text ?? ""
        let email = emailInput.text ?? ""
        let password = passwordInput.text ?? ""
        let termsAcception = termsSwitch.isOn
        let birthDate = datePicker.date

        guard !fullName.isEmpty, !email.isEmpty, !password.isEmpty else {
            showAlert(title: "Incomplete Form", message: "Please fill in all required fields.")
            return
        }

        guard termsAcception else {
            showAlert(title: "Terms Not Accepted", message: "You must accept the terms and conditions to continue.")
            return
        }

        guard hasAtLeast8CharactersRequiremntItem.hasAchieved,
              hasAtLeast1NumberRequiremntItem.hasAchieved,
              hasAtLeast1UpperCaseRequiremntItem.hasAchieved,
              hasAtLeast1SpecialRequiremntItem.hasAchieved else {
            showAlert(title: "Weak Password", message: "Your password must meet all the required criteria.")
            return
        }

        let account = Account(
            fullName: fullName,
            email: email.lowercased(),
            password: password,
            birthDate: birthDate,
            tasks: []
        )

        let appData = Persistance.getApplicaitonData()

        if appData.registeredAccounts.contains(where: { $0.email == email }) {
            showAlert(title: "Email Already Registered", message: "An account with this email already exists.")
            return
        }

        Persistance.registerAccount(account)
        clearFormFields()
        
        navigationController?.popViewController(animated: true)
        
        showAlert(title: "Success", message: "Your account has been created successfully!")
    }
}


// MARK: UITextFieldDelegate
extension CreateAccountViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let currentText = textField.text as? NSString else {
            return true
        }

        let newString = currentText.replacingCharacters(in: range, with: string)


        hasAtLeast8CharactersRequiremntItem.hasAchieved = newString.count >= 8
        hasAtLeast1NumberRequiremntItem.hasAchieved = newString.contains(where: \.isNumber)
        hasAtLeast1UpperCaseRequiremntItem.hasAchieved = newString.contains(where: \.isUppercase)
        hasAtLeast1SpecialRequiremntItem.hasAchieved = newString.contains(where: \.isSpecialCharacter)

        return true
    }
}

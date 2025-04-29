//
//  ViewController.swift
//  viewCodeLogin
//
//  Created by Adriel de Souza on 29/04/25.
//

import UIKit

class LoginViewController: UIViewController {
    private let gradientOverlayInPts: Double = 40

    // MARK: Header

    private lazy var welcomeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome!"
        label.font = Fonts.largeTitle
        label.textAlignment = .center
        return label
    }()

    private lazy var welcomeImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "apple.intelligence"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 48),
            imageView.widthAnchor.constraint(equalToConstant: 48)
        ])

        return imageView
    }()

    private lazy var welcomeGradientView: UIView = {
        let gradientView = UIView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        return gradientView
    }()

    private lazy var loginRoundedView: UIView = {
        let borderView = UIView()
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.backgroundColor = .Background.secondary
        borderView.layer.cornerRadius = 24
        borderView.layer.masksToBounds = true

        NSLayoutConstraint.activate([
            borderView.heightAnchor.constraint(equalToConstant: 182)
        ])

        return borderView
    }()


    // MARK: Labels

    private lazy var loginTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login"
        label.font = Fonts.title1
        label.textAlignment = .center
        return label
    }()

    private lazy var loginErrorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "The email and password you entered did not match our record. Please try again."
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.font = Fonts.footnote
        label.textColor = .Colors.error
        label.textAlignment = .center

        label.isHidden = true
        return label
    }()

    // MARK: Inputs

    private lazy var emailInput: LabeledTextField = {
        let input = LabeledTextField()
        input.labelText = "Email"
        input.placeholder = "abc@abc.com"
        input.textContentType = .emailAddress
        input.keyboardType = .emailAddress
        return input
    }()

    private lazy var passwordInput: LabeledTextField = {
        let input = LabeledTextField()
        input.labelText = "Password"
        input.placeholder = "*****"
        input.textContentType = .password
        input.isSecureTextEntry = true
        return input
    }()

    // MARK: Buttons

    private lazy var loginButton: UIButton = {
        createRoundedButton(labelText: "Login", backgroundColor: .Colors.accent, textColor: .white, labelFont: Fonts.bodySemibold)
    }()

    private lazy var createAccountButton: UIButton = {
        createRoundedButton(labelText: "Create Account", backgroundColor: .Background.tertiary, textColor: .Colors.accent, labelFont: Fonts.bodySemibold)
    }()

    private lazy var forgotPasswordButton: UIButton = {
        let passwordBtn = UIButton(type: .system)
        passwordBtn.translatesAutoresizingMaskIntoConstraints = false

        passwordBtn.setTitle("Forgot password?", for: .normal)
        passwordBtn.setContentCompressionResistancePriority(.required, for: .horizontal)

        return passwordBtn
    }()

    // MARK: Stacks

    private lazy var welcomeStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [welcomeImage, welcomeTitleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 24
        return stackView
    }()

    private lazy var loginFormEntriesStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailInput, passwordInput])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()

    private lazy var forgotPasswordStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [UIView(frame: .zero), forgotPasswordButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        return stackView
    }()

    private lazy var loginStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginTitleLabel, loginFormEntriesStack, forgotPasswordStack])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 32

        NSLayoutConstraint.activate([
            loginTitleLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
            loginTitleLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            forgotPasswordButton.topAnchor.constraint(equalTo: loginFormEntriesStack.bottomAnchor, constant: 16)
        ])

        return stackView
    }()

    private lazy var buttonStacks: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginButton, createAccountButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()


    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAutoDismissKeyboard()
        setup()

        view.backgroundColor = .Background.secondary

        emailInput.textFieldDelegate = self
        passwordInput.textFieldDelegate = self

        createAccountButton.addTarget(self, action: #selector(createAccountButtonAction), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonAction), for: .touchUpInside)
    }


    private var hasAppliedGradient = false
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if !hasAppliedGradient {
            welcomeGradientView.applyGradient(colors: [.Colors.gradientStart, .Colors.gradientEnd])
            welcomeImage.applyGradientMask(colors: [.Colors.imageGradientStart, .Colors.imageGradientEnd])
            hasAppliedGradient = true
        }
    }
}


// MARK: ViewCodeProtocol
extension LoginViewController: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(welcomeGradientView)
        view.addSubview(welcomeStack)
        view.addSubview(loginRoundedView)
        view.addSubview(loginErrorLabel)
        view.addSubview(loginStack)
        view.addSubview(buttonStacks)
    }

    func setupConstraints() {
        loginStack.addSafeMargin(view)
        buttonStacks.addSafeMargin(view)
        welcomeStack.addSafeMargin(view)
        loginErrorLabel.addSafeMargin(view)

        NSLayoutConstraint.activate([
            welcomeGradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomeGradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            welcomeGradientView.topAnchor.constraint(equalTo: view.topAnchor),
            welcomeGradientView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 193 + gradientOverlayInPts),

            welcomeStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),


            loginRoundedView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -1),
            loginRoundedView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 1),
            loginRoundedView.topAnchor.constraint(equalTo: welcomeGradientView.bottomAnchor, constant: -gradientOverlayInPts),

            loginStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 213),

            buttonStacks.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),

            loginErrorLabel.topAnchor.constraint(equalTo: loginStack.bottomAnchor, constant: 8),
            loginErrorLabel.bottomAnchor.constraint(equalTo: buttonStacks.topAnchor, constant: -8)
        ])
    }
}


// MARK: Button Actions
extension LoginViewController {
    @objc func createAccountButtonAction(_ sender: UIButton!) {
        navigationController?.pushViewController(CreateAccountViewController(), animated: true)
    }

    @objc func forgotPasswordButtonAction(_ sender: UIButton!) {
        print(Persistance.getApplicaitonData().registeredAccounts)
    }

    @objc func loginButtonAction(_ sender: UIButton!) {
        guard let emailProvided = emailInput.text, !emailProvided.isEmpty else {
            return
        }


        guard let passwordProvided = passwordInput.text, !passwordProvided.isEmpty else {
            return
        }

        guard Persistance.login(email: emailProvided, password: passwordProvided) else {
            loginErrorLabel.isHidden = false
            return
        }

        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(to: MainTabBarController())
    }
}


// MARK: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        loginErrorLabel.isHidden = true
        return true
    }
}

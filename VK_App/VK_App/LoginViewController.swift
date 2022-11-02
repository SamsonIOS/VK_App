// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран регистрации
final class LoginViewController: UIViewController {
    // MARK: Constants

    private enum Constants {
        static let segueId = "loginSegue"
        static let okText = "OK"
        static let errorText = "Ошибка"
        static let errorMessageText = "Введите корректные данные"
        static let login = "samson"
    }

    // MARK: IBOutlet

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var signInWithAppleButton: UIButton!
    @IBOutlet private var loginTextField: UITextField!

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addObserverForNotification()
        setBorderButton()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserverNotification()
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == Constants.segueId,
              let loginTextFieldText = loginTextField.text
        else { return false }
        if loginTextFieldText == Constants.login {
            return true
        } else {
            showAlert(title: Constants.errorText, message: Constants.errorMessageText) {
                self.dismiss(animated: true)
            }
            return false
        }
    }

    // MARK: Private Methods

    @IBAction private func signInButtonAction(_ sender: UIButton) {}

    @objc private func keyboardWillShown(notification: Notification) {
        guard let info = notification.userInfo as? NSDictionary else { return }
        guard let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue.size
        else { return }

        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hediKeyboard))
        scrollView.addGestureRecognizer(tapGesture)
    }

    @objc private func hediKeyboard() {
        scrollView.endEditing(true)
    }

    @objc private func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    private func setBorderButton() {
        signInWithAppleButton.layer.borderColor = UIColor.lightGray.cgColor
    }

    private func addObserverForNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShown(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func removeObserverNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
}

// MARK: Extensin + LoginViewController
extension LoginViewController {
    typealias Closure = (() -> ())?
    func showAlert(title: String?, message: String, handler: Closure) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertControllerAction = UIAlertAction(title: Constants.okText, style: .default) { _ in
            handler?()
        }
        alertController.addAction(alertControllerAction)
        present(alertController, animated: true)
    }
}

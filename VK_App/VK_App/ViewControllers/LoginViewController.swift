// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

import WebKit

/// Экран регистрации
final class LoginViewController: UIViewController {
    // MARK: Constants

    private enum Constants {
        static let ampersand = "&"
        static let equall = "="
        static let accesTokenText = "access_token"
        static let vkSegue = "vkSegue"
        static let blankHtmlText = "/blank.html"
    }

    // MARK: IBOutlet

    @IBOutlet private var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var signInWithAppleButton: UIButton!
    @IBOutlet private var loginTextField: UITextField!

    // MARK: Private Vusial Components

    private var firstDoteView = UIView()
    private var secondDoteView = UIView()
    private var thirdDoteView = UIView()

    private let networkApiService = NetworkAPIService()

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addObserverForNotification()
        setBorderButton()
        showAuthorizationWebView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserverNotification()
    }

    // MARK: Private IBAction

    @IBAction private func signInButtonAction(_ sender: UIButton) {
        let loginTextFieldText = loginTextField.text
        if loginTextFieldText == ConstantsSting.login {
            startAnimationView()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.firstDoteView.layer.removeAllAnimations()
                self.secondDoteView.layer.removeAllAnimations()
                self.thirdDoteView.layer.removeAllAnimations()

                guard let vc = UIStoryboard(name: ConstantsSting.mainText, bundle: nil)
                    .instantiateViewController(withIdentifier: ConstantsSting.tabBarID) as? UITabBarController
                else { return }
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        } else {
            showAlert(title: ConstantsSting.errorText, message: ConstantsSting.errorMessageText) {
                self.dismiss(animated: true)
            }
        }
    }

    // MARK: Private Methods

    @objc private func keyboardWillShownAction(notification: Notification) {
        guard let info = notification.userInfo as? NSDictionary else { return }
        guard let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue.size
        else { return }

        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction))
        scrollView.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboardAction() {
        scrollView.endEditing(true)
    }

    @objc private func keyboardWillHideAction(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }

    private func showAuthorizationWebView() {
        guard let request = networkApiService.urlComponents() else { return }
        webView.load(request)
    }

    private func setupSubView(newView: UIView, xPosition: Int, yPosition: Int) -> UIView {
        newView.backgroundColor = .white
        newView.alpha = 0
        newView.frame = CGRect(
            x: view.center.x + CGFloat(xPosition),
            y: view.center.y + CGFloat(yPosition),
            width: 10,
            height: 10
        )
        view.addSubview(newView)
        newView.layer.cornerRadius = 5
        return newView
    }

    private func startAnimationView() {
        firstDoteView = setupSubView(newView: firstDoteView, xPosition: -20, yPosition: -115)
        secondDoteView = setupSubView(newView: secondDoteView, xPosition: 0, yPosition: -115)
        thirdDoteView = setupSubView(newView: thirdDoteView, xPosition: 20, yPosition: -115)

        UIView.animate(
            withDuration: 0.7,
            delay: 0,
            options: [.repeat, .autoreverse]
        ) {
            self.firstDoteView.alpha = 1
        }

        UIView.animate(
            withDuration: 0.7,
            delay: 0.3,
            options: [.repeat, .autoreverse]
        ) {
            self.secondDoteView.alpha = 1
        }

        UIView.animate(
            withDuration: 0.7,
            delay: 0.6,
            options: [.repeat, .autoreverse]
        ) {
            self.thirdDoteView.alpha = 1
        }
    }

    private func setBorderButton() {
        signInWithAppleButton.layer.borderColor = UIColor.lightGray.cgColor
    }

    private func addObserverForNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShownAction(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHideAction(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func removeObserverNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
}

// MARK: вызов алерта из любого UIViewController

extension UIViewController {
    typealias Closure = (() -> ())?
    func showAlert(title: String?, message: String?, handler: Closure) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertControllerAction = UIAlertAction(title: ConstantsSting.okText, style: .default) { _ in
            handler?()
        }
        alertController.addAction(alertControllerAction)
        present(alertController, animated: true)
    }
}

// MARK: WKNavigationDelegate

extension LoginViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse:
        WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) ->
            Void
    ) {
        guard let url = navigationResponse.response.url, url.path ==
            Constants.blankHtmlText, let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: Constants.ampersand)
            .map { $0.components(separatedBy: Constants.equall) }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        if let token = params[Constants.accesTokenText] {
            Session.shared.token = token
        }
        decisionHandler(.cancel)
        performSegue(withIdentifier: Constants.vkSegue, sender: self)
    }
}

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

    // MARK: Private IBOutlet

    @IBOutlet private var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }

    // MARK: Private properties

    private let networkService = NetworkService()
    private lazy var contentView = LoginView()

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        contentView.removeObserverNotification()
    }

    // MARK: Private IBAction

    @IBAction private func signInButtonAction(_ sender: UIButton) {
        guard let contentView = view as? LoginView else { return }
        let loginTextFieldText = contentView.loginTextField.text
        if loginTextFieldText == ConstantsSting.login {
            contentView.startAnimationView()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.contentView.firstDoteView.layer.removeAllAnimations()
                self.contentView.secondDoteView.layer.removeAllAnimations()
                self.contentView.thirdDoteView.layer.removeAllAnimations()

                guard let tabBarController = UIStoryboard(name: ConstantsSting.mainText, bundle: nil)
                    .instantiateViewController(withIdentifier: ConstantsSting.tabBarID) as? UITabBarController
                else { return }
                tabBarController.modalPresentationStyle = .fullScreen
                self.present(tabBarController, animated: true)
            }
        } else {
            showAlert(title: ConstantsSting.errorText, message: ConstantsSting.errorMessageText) {
                self.dismiss(animated: true)
            }
        }
    }

    // MARK: Private Methods

    private func configure() {
        guard let contentView = view as? LoginView else { return }
        self.contentView = contentView
        self.contentView.addObserverForNotification()
        self.contentView.setBorderButton()
        showAuthorizationWebView()
    }

    private func showAuthorizationWebView() {
        guard let request = networkService.urlComponents() else { return }
        webView.load(request)
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

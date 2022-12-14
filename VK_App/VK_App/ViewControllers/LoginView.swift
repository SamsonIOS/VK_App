// LoginView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

/// Вью входа в приложение
final class LoginView: UIView {
    // MARK: IBOutlet

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var signInWithAppleButton: UIButton!
    @IBOutlet var loginTextField: UITextField!

    // MARK: Public Visual Components

    var firstDoteView = UIView()
    var secondDoteView = UIView()
    var thirdDoteView = UIView()

    // MARK: Public Methods

    @objc func keyboardWillShownAction(notification: Notification) {
        guard let info = notification.userInfo as? NSDictionary else { return }
        guard let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue.size
        else { return }

        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction))
        scrollView.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboardAction() {
        scrollView.endEditing(true)
    }

    @objc func keyboardWillHideAction(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }

    func startAnimationView() {
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

    func setBorderButton() {
        signInWithAppleButton.layer.borderColor = UIColor.lightGray.cgColor
    }

    func addObserverForNotification() {
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

    func removeObserverNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    // MARK: Private Methods

    private func setupSubView(newView: UIView, xPosition: Int, yPosition: Int) -> UIView {
        newView.backgroundColor = .white
        newView.alpha = 0
        newView.frame = CGRect(
            x: center.x + CGFloat(xPosition),
            y: center.y + CGFloat(yPosition),
            width: 10,
            height: 10
        )
        addSubview(newView)
        newView.layer.cornerRadius = 5
        return newView
    }
}

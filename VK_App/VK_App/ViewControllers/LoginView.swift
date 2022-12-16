// LoginView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

/// Вью входа в приложение
final class LoginView: UIView {
    // MARK: Constants

    private enum Constants {
        static let forTopAndLeftEdgeInsets = 0.0
        static let forRightEdgeInsets: CGFloat = 0
        static let firstDoteViewX = -20
        static let thirdDoteViewX = 20
        static let DoveViewY = -115
        static let DoteViewXzero = 0
        static let alphaForAnimation: CGFloat = 1
        static let durationForAnimation = 0.7
        static let firstDoteAnimateDelay: TimeInterval = 0
        static let secondDoteAnimateDelay = 0.3
        static let thirdDoteAnimateDelay = 0.6
        static let forViewAplha: CGFloat = 0
        static let viewWidth = 10
        static let viewHeigth = 10
        static let viewCornerRadius: CGFloat = 5
    }

    // MARK: Private IBOutlet

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var signInWithAppleButton: UIButton!

    // MARK: Public IBOutlet

    @IBOutlet var loginTextField: UITextField!

    // MARK: Public Visual Components

    var firstDoteView = UIView()
    var secondDoteView = UIView()
    var thirdDoteView = UIView()

    // MARK: Public Methods

    @objc func keyboardWillShownAction(notification: Notification) {
        guard let info = notification.userInfo as? NSDictionary,
              let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue.size
        else { return }

        let contentInsets = UIEdgeInsets(
            top: Constants.forTopAndLeftEdgeInsets,
            left: Constants.forTopAndLeftEdgeInsets,
            bottom: kbSize.height,
            right: Constants.forRightEdgeInsets
        )
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
        firstDoteView = setupSubView(
            newView: firstDoteView,
            xPosition: Constants.firstDoteViewX,
            yPosition: Constants.DoveViewY
        )
        secondDoteView = setupSubView(
            newView: secondDoteView,
            xPosition: Constants.DoteViewXzero,
            yPosition: Constants.DoveViewY
        )
        thirdDoteView = setupSubView(
            newView: thirdDoteView,
            xPosition: Constants.thirdDoteViewX,
            yPosition: Constants.DoveViewY
        )

        UIView.animate(
            withDuration: Constants.durationForAnimation,
            delay: Constants.firstDoteAnimateDelay,
            options: [.repeat, .autoreverse]
        ) {
            self.firstDoteView.alpha = Constants.alphaForAnimation
        }

        UIView.animate(
            withDuration: Constants.durationForAnimation,
            delay: Constants.secondDoteAnimateDelay,
            options: [.repeat, .autoreverse]
        ) {
            self.secondDoteView.alpha = Constants.alphaForAnimation
        }

        UIView.animate(
            withDuration: Constants.durationForAnimation,
            delay: Constants.thirdDoteAnimateDelay,
            options: [.repeat, .autoreverse]
        ) {
            self.thirdDoteView.alpha = Constants.alphaForAnimation
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
        newView.alpha = Constants.forViewAplha
        newView.frame = CGRect(
            x: Int(center.x + CGFloat(xPosition)),
            y: Int(center.y + CGFloat(yPosition)),
            width: Constants.viewWidth,
            height: Constants.viewHeigth
        )
        addSubview(newView)
        newView.layer.cornerRadius = Constants.viewCornerRadius
        return newView
    }
}

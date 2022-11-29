// CustomSegueTransition.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кастомный сигвей
final class CustomSegueTransition: UIStoryboardSegue {
    // MARK: Constants

    private enum ConstantsSegueValue {
        static let twoValue = 2
        static let zeroValue = 0
        static let oneValue = 1
    }

    // MARK: Public Methods

    override func perform() {
        guard let containerView = source.view.superview else { return }

        containerView.addSubview(destination.view)
        destination.view.frame = CGRect(
            x: Int(source.view.frame.width) / ConstantsSegueValue.twoValue,
            y: Int(source.view.frame.height) / ConstantsSegueValue.twoValue,
            width: ConstantsSegueValue.zeroValue,
            height: ConstantsSegueValue.zeroValue
        )
        destination.modalPresentationStyle = .overFullScreen

        UIView.animate(withDuration: TimeInterval(ConstantsSegueValue.oneValue)) {
            self.source.navigationController?.navigationBar.alpha = CGFloat(ConstantsSegueValue.zeroValue)
            self.source.tabBarController?.tabBar.alpha = CGFloat(ConstantsSegueValue.zeroValue)

            self.destination.view.frame = CGRect(
                x: CGFloat(ConstantsSegueValue.zeroValue),
                y: CGFloat(ConstantsSegueValue.zeroValue),
                width: self.source.view.frame.width,
                height: self.source.view.frame.height
            )
        } completion: { _ in
            self.source.present(self.destination, animated: false)
            self.source.navigationController?.navigationBar.alpha = CGFloat(ConstantsSegueValue.oneValue)
            self.source.tabBarController?.tabBar.alpha = CGFloat(ConstantsSegueValue.oneValue)
        }
    }
}

// CustomSegueTransition.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кастомный сигвей
final class CustomSegueTransition: UIStoryboardSegue {
    // MARK: Public methods

    override func perform() {
        guard let containerView = source.view.superview else { return }

        containerView.addSubview(destination.view)
        destination.view.frame = CGRect(
            x: source.view.frame.width / 2,
            y: source.view.frame.height / 2,
            width: 0,
            height: 0
        )
        destination.modalPresentationStyle = .overFullScreen

        UIView.animate(withDuration: 1) {
            self.source.navigationController?.navigationBar.alpha = 0
            self.source.tabBarController?.tabBar.alpha = 0

            self.destination.view.frame = CGRect(
                x: 0,
                y: 0,
                width: self.source.view.frame.width,
                height: self.source.view.frame.height
            )
        } completion: { _ in
            self.source.present(self.destination, animated: false)
            self.source.navigationController?.navigationBar.alpha = 1
            self.source.tabBarController?.tabBar.alpha = 1
        }
    }
}

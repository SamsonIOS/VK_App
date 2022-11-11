// CustomNavigationController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кастомный UINavigationViewController который позволяет делать переходы на следующий и предыдущий экран с анимацией
final class CustomNavigationController: UINavigationController {
    // MARK: Private properties

    private let interactive = CustomInteractiveTransition()

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }

    // MARK: Private methods

    private func setDelegate() {
        delegate = self
    }
}

// MARK: UINavigationControllerDelegate

extension CustomNavigationController: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
            interactive.viewController = toVC
            return CustomPopAnimator()
        case .push:
            if navigationController.viewControllers.first != toVC {
                interactive.viewController = toVC
            }
            return CustomPushAnimator()
        default:
            return nil
        }
    }

    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        interactive.isStarted ? interactive : nil
    }
}

// CustomPushAnimator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Анимация для перехода на следующий экран
final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: Public methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.7
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to) else { return }

        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame

        let translation = CGAffineTransform(
            translationX: source.view.frame.width / 2 + source.view.frame.height / 2,
            y: -source.view.frame.width / 2
        )

        let rotation = CGAffineTransform(rotationAngle: .pi / -2)

        destination.view.transform = rotation.concatenating(translation)
        destination.view.center = CGPoint(
            x: source.view.bounds.width + source.view.bounds.height / 2,
            y: source.view.bounds.width / 2
        )

        UIView.animateKeyframes(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: .calculationModePaced
        ) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                let translation = CGAffineTransform(translationX: -200, y: 0)
                let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                source.view.transform = translation.concatenating(scale)
            }

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                destination.view.transform = .identity
                destination.view.center = source.view.center
            }
        } completion: { finish in
            if finish, !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finish && !transitionContext.transitionWasCancelled)
        }
    }
}

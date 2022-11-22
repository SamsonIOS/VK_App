// CustomPopAnimator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Анимация для возврата на предыдущий экран
final class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: Constants

    private enum Constants {
        static let nullSevenValue = 0.7
        static let twoValue = 2
        static let nullValue = 0
        static let nullFourValue = 0.4
        static let abowTwoValue = -2
    }

    // MARK: Public methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        Constants.nullSevenValue
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to) else { return }

        transitionContext.containerView.addSubview(destination.view)

        destination.view.frame = source.view.frame
        destination.view.transform = CGAffineTransform(
            translationX: -source.view.bounds.width, y: CGFloat(Constants.nullValue)
        ).concatenating(CGAffineTransform(
            scaleX: Constants.nullSevenValue, y: Constants.nullSevenValue
        ))
        destination.view.center = CGPoint(
            x: source.view.bounds.width / CGFloat(Constants.twoValue),
            y: source.view.center.y
        )

        UIView.animateKeyframes(
            withDuration: transitionDuration(using: transitionContext),
            delay: TimeInterval(Constants.nullValue),
            options: .calculationModePaced
        ) {
            UIView.addKeyframe(
                withRelativeStartTime: Double(Constants.nullValue),
                relativeDuration: Constants.nullFourValue
            ) {
                let translation = CGAffineTransform(
                    translationX: source.view.frame.width,
                    y: CGFloat(Constants.nullValue)
                )
                let scale = CGAffineTransform(rotationAngle: .pi / CGFloat(Constants.abowTwoValue))
                source.view.transform = translation.concatenating(scale)
                source.view.center = CGPoint(
                    x: source.view.bounds.width + source.view.bounds.height / CGFloat(Constants.twoValue),
                    y: source.view.bounds.width / CGFloat(Constants.twoValue)
                )
            }
            UIView.addKeyframe(
                withRelativeStartTime: Double(Constants.nullValue),
                relativeDuration: Constants.nullFourValue
            ) {
                destination.view.transform = .identity
            }
        } completion: { finish in
            if finish, !transitionContext.transitionWasCancelled {
                destination.view.transform = .identity
                transitionContext.completeTransition(true)
            } else {
                transitionContext.completeTransition(false)
            }
        }
    }
}

// CustomPushAnimator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Анимация для перехода на следующий экран
final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: Constants

    private enum ConstantsValue {
        static let nullSevenValue = 0.7
        static let twoValue = 2
        static let nullValue = 0
        static let nullFiveValue = 0.5
        static let abowTwentyValue = -200
        static let abowTwoValue = -2
        static let zeroPointEight = 0.8
    }

    // MARK: Public methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        ConstantsValue.nullSevenValue
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to) else { return }

        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame

        let translation = CGAffineTransform(
            translationX: source.view.frame.width / CGFloat(ConstantsValue.twoValue) + source.view.frame
                .height / CGFloat(ConstantsValue.twoValue),
            y: -source.view.frame.width / CGFloat(ConstantsValue.twoValue)
        )

        let rotation = CGAffineTransform(rotationAngle: .pi / CGFloat(ConstantsValue.abowTwoValue))

        destination.view.transform = rotation.concatenating(translation)
        destination.view.center = CGPoint(
            x: source.view.bounds.width + source.view.bounds.height / CGFloat(ConstantsValue.twoValue),
            y: source.view.bounds.width / CGFloat(ConstantsValue.twoValue)
        )

        UIView.animateKeyframes(
            withDuration: transitionDuration(using: transitionContext),
            delay: TimeInterval(ConstantsValue.nullValue),
            options: .calculationModePaced
        ) {
            UIView.addKeyframe(
                withRelativeStartTime: Double(ConstantsValue.nullValue),
                relativeDuration: ConstantsValue.nullFiveValue
            ) {
                let translation = CGAffineTransform(
                    translationX: CGFloat(ConstantsValue.abowTwentyValue),
                    y: CGFloat(ConstantsValue.nullValue)
                )
                let scale = CGAffineTransform(scaleX: ConstantsValue.zeroPointEight, y: ConstantsValue.zeroPointEight)
                source.view.transform = translation.concatenating(scale)
            }

            UIView.addKeyframe(
                withRelativeStartTime: Double(ConstantsValue.nullValue),
                relativeDuration: ConstantsValue.nullFiveValue
            ) {
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

// Extension + UIView .swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширения Чтобы можно было сделать анимацию для всего, кто наследуется от UIView и там где там нужна анимация
extension UIView {
    func setupTapGestureRecognizer() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(animationDidTapAction))
        addGestureRecognizer(gesture)
        isUserInteractionEnabled = true
    }

    @objc func animationDidTapAction() {
        transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 0.3,
            initialSpringVelocity: 0.5,
            options: .curveEaseOut
        ) {
            self.transform = .identity
        }
    }
}

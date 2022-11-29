// FriendsView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью с изображением для отображения тени на ней
@IBDesignable final class FriendsView: UIView {
    // MARK: Constants

    private enum Constants {
        static let pencilImageName = "pencil.fill"
    }

    // MARK: - Private Visual components

    let friendImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()

    // MARK: - Private Property

    @IBInspectable private var shadowRadius: CGFloat = 7 {
        didSet {
            updateShadowRadius()
        }
    }

    @IBInspectable var image: UIImage? = UIImage(named: Constants.pencilImageName) {
        didSet {
            setImage(image: image)
        }
    }

    @IBInspectable private var shadowOpacity: Float = 0.7 {
        didSet {
            updateShadowOpacity()
        }
    }

    @IBInspectable private var shadowColor: UIColor = .black {
        didSet {
            updateShadowColor()
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Private Methods

    private func setImage(image: UIImage?) {
        friendImageView.image = image
    }

    private func setupView() {
        addSubview(friendImageView)
        friendImageView.frame = bounds
        friendImageView.layer.cornerRadius = bounds.width / 2
        setupShadows()
    }

    private func setupShadows() {
        layer.cornerRadius = bounds.width / 2
        updateShadowColor()
        updateShadowOpacity()
        updateShadowRadius()
    }

    private func updateShadowRadius() {
        layer.shadowRadius = shadowRadius
    }

    private func updateShadowColor() {
        layer.shadowColor = shadowColor.cgColor
    }

    private func updateShadowOpacity() {
        layer.shadowOpacity = shadowOpacity
    }
}

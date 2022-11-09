// LikesControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Отображение и коллличествоо лайков, создаем UIControl
@IBDesignable class LikeControl: UIControl {
    // MARK: - Private constants

    private enum Constants {
        static let heartButtonImageName = "heart"
        static let heartFillButtonImageName = "heart.fill"
        static let nullText = "0"
    }

    // MARK: - Private Visual components

    private let likesLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "DarkGrayColor")
        label.text = Constants.nullText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let likeButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(named: "DarkGrayColor")
        button.setImage(UIImage(systemName: Constants.heartButtonImageName), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Private Property

    @IBInspectable private var isLiked: Bool = false {
        didSet {
            changeLikes()
        }
    }

    @IBInspectable private var likesCount: Float = 0.0 {
        didSet {
            changeLikeCount()
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

    // MARK: - Private methods

    private func setupView() {
        addSubview(likeButton)
        addSubview(likesLabel)
        createGestureRecognizer()
        setUpButtonConstraint()
        setUpLabelConstraint()
    }

    private func createGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(likeButtonAction(sender:))
        )
        likeButton.addGestureRecognizer(tapGestureRecognizer)
    }

    private func setUpButtonConstraint() {
        NSLayoutConstraint.activate([
            likeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
            likeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            likeButton.widthAnchor.constraint(equalToConstant: 20),
            likeButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func setUpLabelConstraint() {
        NSLayoutConstraint.activate([
            likesLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 2),
            likesLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            likesLabel.widthAnchor.constraint(equalTo: likeButton.widthAnchor),
            likesLabel.heightAnchor.constraint(equalTo: likeButton.widthAnchor)
        ])
    }

    private func changeLikes() {
        if isLiked {
            addLike()
            likesCount += 1
        } else {
            removeLike()
            likesCount -= 1
        }
    }

    private func addLike() {
        likeButton.tintColor = .magenta
        likeButton.setImage(UIImage(systemName: Constants.heartFillButtonImageName), for: .normal)
        likesLabel.textColor = .magenta
    }

    private func removeLike() {
        likeButton.tintColor = UIColor(named: "DarkGrayColor")
        likeButton.setImage(UIImage(systemName: Constants.heartButtonImageName), for: .normal)
        likesLabel.textColor = UIColor(named: "DarkGrayColor")
    }

    private func changeLikeCount() {
        likesLabel.text = String(Int(likesCount))
    }

    private func imageTabAction() {
        likeButton.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 0.3,
            initialSpringVelocity: 0.5,
            options: .curveEaseInOut,
            animations: {
                self.likeButton.transform = .identity
            },
            completion: nil
        )
    }

    @objc private func likeButtonAction(sender: UIButton) {
        isLiked.toggle()
        imageTabAction()
    }
}

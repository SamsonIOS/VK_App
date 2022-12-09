// FriendsPhotosViewController.swift
// Copyright © RoadMap. All rights reserved.

import PromiseKit
import RealmSwift
import UIKit

/// Экран с коллекцией фотографией друга
final class FriendsPhotosViewController: UIViewController {
    // MARK: Private IBOutlet

    @IBOutlet private var friendImageView: UIImageView!

    // MARK: - Private properties

    private let networkService = NetworkService()
    private let realmService = RealmService()
    private let imageLoader = LoadingImage.shared
    private var userIdentifier = 0
    private var rowIndex = 0
    private var selectedIndex = 0
    private var photoNames: [String] = [] {
        didSet {
            DispatchQueue.global(qos: .userInteractive).async {
                self.loadImage()
            }
        }
    }

    private var userImages: [UIImage] = [] {
        didSet {
            DispatchQueue.main.async {
                self.setupUserPhotos()
            }
        }
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setMethods()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        selectedIndex = 0
    }

    // MARK: - Public methods

    func configure(user: User, userID: Int) {
        userIdentifier = user.id
        title = "\(user.firstName) \(user.lastName)"
        loadPhotoToRealm(userID: userID)
    }

    // MARK: - Private methods

    private func setMethods() {
        setupSwipeGesture()
        setImage()
    }

    private func loadPhotoToRealm(userID: Int) {
        do {
            guard let userPhotoResults = RealmService.get(UserPhotoResults.self) else { return }
            let userIdentificator = userPhotoResults.map(\.ownerID)
            if userIdentificator.contains(where: { tempID in userID == tempID }) {
                let userPhoto = userPhotoResults.filter { $0.ownerID == userID }
                let photoAll = userPhoto.map(\.photos.last)
                photoNames = photoAll.map { $0?.url ?? "NO URL" }
            } else {
                fetchUserPhotos(userID: userID)
            }
        } catch {
            print(error)
        }
    }

    private func loadImage() {
        photoNames.forEach {
            self.imageLoader.getImage(imagePosterPath: $0) { [weak self] data in
                if let image = UIImage(data: data) {
                    self?.userImages.append(image)
                }
            }
        }
    }

    private func fetchUserPhotos(userID: Int) {
        firstly {
            networkService.fetchUserPhotos(for: userID)
        }.done { userPhotos in
            let photoOptional = userPhotos.response.photos.map(\.photos.last)
            self.photoNames = photoOptional.map { $0?.url ?? "NO" }
            RealmService.save(items: userPhotos.response.photos)
            self.setupUserPhotos()
        }.catch { error in
            print(error.localizedDescription)
        }
    }

    private func setupUserPhotos() {
        guard userImages.indices.contains(selectedIndex) else { return }
        friendImageView.image = userImages[selectedIndex]
    }

    private func setImage() {
        friendImageView.layer.borderWidth = 1
        friendImageView.layer.borderColor = UIColor.blue.cgColor
        friendImageView.layer.cornerRadius = 15
        friendImageView.clipsToBounds = true
        friendImageView.contentMode = .scaleToFill
    }

    private func setupSwipeGesture() {
        friendImageView.isUserInteractionEnabled = true
        let leftSwipeGestureRecognizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(swipeUserPhotoAction)
        )
        leftSwipeGestureRecognizer.direction = .left
        friendImageView.addGestureRecognizer(leftSwipeGestureRecognizer)

        let rightSwipeGestureRecognizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(swipeUserPhotoAction)
        )
        rightSwipeGestureRecognizer.direction = .right
        friendImageView.addGestureRecognizer(rightSwipeGestureRecognizer)

        let downSwipeGestureRecognizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(swipeUserPhotoAction)
        )
        downSwipeGestureRecognizer.direction = .down
        friendImageView.addGestureRecognizer(downSwipeGestureRecognizer)
    }

    private func animateFriendsPhoto(x xPosition: Int, indexOffset: Int) {
        rowIndex += indexOffset
        guard userImages.indices.contains(rowIndex) else {
            rowIndex -= indexOffset
            UIView.animate(
                withDuration: 1,
                delay: 0,
                usingSpringWithDamping: 0.3,
                initialSpringVelocity: 0.3,
                animations: ({
                    self.friendImageView.transform = CGAffineTransform(translationX: CGFloat(xPosition / 5), y: 0)
                        .concatenating(CGAffineTransform(scaleX: 0.8, y: 0.8))
                }),
                completion: ({ _ in
                    self.friendImageView.transform = .identity
                })
            )
            return
        }
        UIView.animate(withDuration: 1, delay: 0, animations: ({
            self.friendImageView.transform = CGAffineTransform(translationX: CGFloat(xPosition), y: 0)
                .concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
            self.friendImageView.layer.opacity = 0.2
        }), completion: ({ [weak self] _ in
            guard let self = self else { return }
            self.setFriendImageView()
        }))
    }

    private func setFriendImageView() {
        friendImageView.layer.opacity = 1
        friendImageView.image = userImages[rowIndex]
        friendImageView.transform = .identity
    }

    private func animatePop() {
        UIView.animate(withDuration: 1, animations: ({
            self.friendImageView.transform = CGAffineTransform(translationX: 0, y: 1500)
                .concatenating(CGAffineTransform(scaleX: 0.3, y: 0.3))
        }), completion: ({ _ in
            self.navigationController?.popViewController(animated: true)
        }))
    }

    @objc private func swipeUserPhotoAction(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .left:
            animateFriendsPhoto(x: -500, indexOffset: 1)
        case .right:
            animateFriendsPhoto(x: 500, indexOffset: -1)
        case .down:
            animatePop()
        default: break
        }
    }
}

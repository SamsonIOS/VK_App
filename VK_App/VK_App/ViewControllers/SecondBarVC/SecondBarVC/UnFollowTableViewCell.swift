// UnFollowTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с группами, на которые пользователь еще не подписан
final class UnFollowTableViewCell: UITableViewCell {
    // MARK: IBOutlet

    @IBOutlet private var unFollowImageView: UIImageView!
    @IBOutlet private var unFollowGroupLabel: UILabel!

    // MARK: Private properties

    private var currentPath = ""

    // MARK: Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        unFollowImageView.setupTapGestureRecognizer()
        unFollowImageView.animationDidTapAction()
    }

    // MARK: Public Methods

    func configure(group: Group) {
        unFollowImageView.image = nil
        currentPath = group.photo50Path
        unFollowGroupLabel.text = group.name
        getImage(imagePath: group.photo50Path)
    }

    // MARK: Private Methods

    private func getImage(imagePath: String) {
        LoadingImage.shared.getImage(imagePosterPath: imagePath) { [weak self] data in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if imagePath == self.currentPath {
                    self.unFollowImageView.image = UIImage(data: data)
                }
            }
        }
    }
}

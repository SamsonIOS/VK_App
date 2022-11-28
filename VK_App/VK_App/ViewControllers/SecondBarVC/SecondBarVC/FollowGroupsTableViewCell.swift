// FollowGroupsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с группой на которую пользователь уже подписан
final class FollowGroupsTableViewCell: UITableViewCell {
    // MARK: IBOutlet

    @IBOutlet private var nameGroupLabel: UILabel!
    @IBOutlet private var groupImageView: UIImageView!

    // MARK: Private properties

    private var currentPath = ""

    // MARK: Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        groupImageView.setupTapGestureRecognizer()
        groupImageView.animationDidTapAction()
    }

    // MARK: Public Methods

    func configure(_ group: Group) {
        nameGroupLabel.text = group.name
        currentPath = group.photoPath
        groupImageView.image = nil
        getImage(imagePath: group.photoPath)
    }

    // MARK: Private Methods

    private func getImage(imagePath: String) {
        LoadingImage.shared.getImage(imagePosterPath: imagePath) { [weak self] data in
            guard let self = self,
                  imagePath == self.currentPath
            else { return }
            self.groupImageView.image = UIImage(data: data)
        }
    }
}

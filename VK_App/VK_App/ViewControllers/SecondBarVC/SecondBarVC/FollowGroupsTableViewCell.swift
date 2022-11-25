// FollowGroupsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с группой на которую пользователь уже подписан
final class FollowGroupsTableViewCell: UITableViewCell {
    // MARK: IBOutlet

    @IBOutlet private var nameGroupLabel: UILabel!
    @IBOutlet private var groupImageView: UIImageView!

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
        currentPath = group.photo50Path
        groupImageView.image = nil
        getImage(imagePath: group.photo50Path)
    }

    private func getImage(imagePath: String) {
        ImageLoader.shared.getImage(imagePosterPath: imagePath) { [weak self] data in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if imagePath == self.currentPath {
                    self.groupImageView.image = UIImage(data: data)
                }
            }
        }
    }
}

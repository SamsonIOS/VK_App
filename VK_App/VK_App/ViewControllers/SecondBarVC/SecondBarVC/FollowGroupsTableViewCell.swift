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

    func configure(_ group: Group, photoService: PhotoService, indexPath: Int) {
        nameGroupLabel.text = group.name
        let atIndexPath = IndexPath(index: indexPath)
        groupImageView.image = photoService.photo(atIndexpath: atIndexPath, byUrl: group.photoPath)
    }
}

// FollowGroupsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с группой на которую пользователь уже подписан
final class FollowGroupsTableViewCell: UITableViewCell {
    // MARK: IBOutlet

    @IBOutlet private var nameGroupLabel: UILabel!
    @IBOutlet private var groupImageView: UIImageView!

    // MARK: Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        groupImageView.setImageView()
        groupImageView.imageDidTapAction()
    }

    // MARK: Public Methods

    func groupsInfo(_ model: Group) {
        nameGroupLabel.text = model.groupName
        groupImageView.image = UIImage(named: model.groupImage)
    }
}

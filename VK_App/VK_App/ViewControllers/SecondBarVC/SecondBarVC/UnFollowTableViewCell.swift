// UnFollowTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с группами, на которые пользователь еще не подписан
final class UnFollowTableViewCell: UITableViewCell {
    // MARK: IBOutlet

    @IBOutlet private var unFollowImageView: UIImageView!
    @IBOutlet private var unFollowGroupLabel: UILabel!

    // MARK: Public Methods

    func unFollowGroupInfo(_ model: Group) {
        unFollowGroupLabel.text = model.groupName
        unFollowImageView.image = UIImage(named: model.groupImage)
        unFollowImageView.setGroupImageView()
        unFollowImageView.photoDidTapAction()
    }
}

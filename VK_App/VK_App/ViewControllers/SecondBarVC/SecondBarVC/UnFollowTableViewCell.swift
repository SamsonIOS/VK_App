// UnFollowTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с группами, на которые пользователь еще не подписан
final class UnFollowTableViewCell: UITableViewCell {
    // MARK: IBOutlet

    @IBOutlet private var unFollowImageView: UIImageView!
    @IBOutlet private var unFollowGroupLabel: UILabel!

    // MARK: Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        unFollowImageView.setupTapGestureRecognizer()
        unFollowImageView.animationDidTapAction()
    }

    // MARK: Public Methods

    func unFollowGroupInfo(_ group: Group) {
        unFollowGroupLabel.text = group.groupName
        unFollowImageView.image = UIImage(named: group.groupImage)
    }
}

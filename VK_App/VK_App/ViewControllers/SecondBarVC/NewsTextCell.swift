// NewsTextCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка текста поста
final class NewsTextCell: UITableViewCell, NewsConfigurable {
    // MARK: Private IBOutlets

    @IBOutlet private var overviewPostLabel: UILabel!
    @IBOutlet private var overviewButton: UIButton!

    // MARK: Public properties

    weak var delegate: NewsPostCellDelegate?
    var isExpanded = false {
        didSet {
            updatePostLabel()
            updateShowMoreOverview()
        }
    }

    // MARK: Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        updatePostLabel()
        updateShowMoreOverview()
    }

    // MARK: Public Methods

    func configure(news: NewsFeed) {
        overviewPostLabel.text = news.text
    }

    // MARK: Private Methods

    @IBAction private func buttonOverviewTapAction(_ sender: UIButton) {
        delegate?.didTappedShowMore(self)
    }

    private func updatePostLabel() {
        overviewPostLabel.numberOfLines = isExpanded ? 0 : 5
    }

    private func updateShowMoreOverview() {
        let title = isExpanded ? "Скрыть" : "Показать все"
        overviewButton.setTitle(title, for: .normal)
    }
}

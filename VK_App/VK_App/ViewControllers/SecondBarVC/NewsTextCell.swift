// NewsTextCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка текста поста
final class NewsTextCell: UITableViewCell, NewsConfigurable {
    // MARK: Constants

    private enum Constants {
        static let showLess = "Скрыть"
        static let showMore = "Показать"
        static let zeroLines = 0
        static let fiveLines = 5
    }

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

    func configure(news: NewsFeed, photoService: PhotoService?, indexPath: Int?) {
        overviewPostLabel.text = news.text
    }

    // MARK: Private Methods

    @IBAction private func buttonOverviewTapAction(_ sender: UIButton) {
        delegate?.didTappedShowMore(self)
    }

    private func updatePostLabel() {
        overviewPostLabel.numberOfLines = isExpanded ? Constants.zeroLines : Constants.fiveLines
    }

    private func updateShowMoreOverview() {
        let title = isExpanded ? Constants.showLess : Constants.showMore
        overviewButton.setTitle(title, for: .normal)
    }
}

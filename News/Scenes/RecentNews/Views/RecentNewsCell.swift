//
//  RecentNewsCell.swift
//  News
//
//  Created by Yavuz on 18.06.2021.
//

import UIKit
import Kingfisher

class RecentNewsCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var isAddedLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var isAddedLabelTapAction: ((UITableViewCell) -> Void)?
    var isAdded: Bool = false {
        didSet {
            isAddedLabel.text = isAdded ? "Listemden çıkar" : "Listeme ekle"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        isAddedLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedIsAddedLabel))
        isAddedLabel.addGestureRecognizer(tap)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
        isAddedLabel.text = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
    }
    
    func set(with news: RecentNews.Fetch.ViewModel.News) {
        titleLabel.text = news.title
        descriptionLabel.text = news.description
        newsImageView.kf.indicatorType = .activity
        isAdded = news.isAdded
    }

    func setIsAddedTapAction(with function: @escaping ((UITableViewCell) -> Void)) {
        isAddedLabelTapAction = function
    }
    
    @objc
    func tappedIsAddedLabel() {
        if let action = isAddedLabelTapAction {
            action(self)
        }
    }
}

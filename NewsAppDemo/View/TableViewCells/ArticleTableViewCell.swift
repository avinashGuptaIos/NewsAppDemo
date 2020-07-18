//
//  ArticleTableViewCell.swift
//  NewsAppDemo
//
//  Created by hasher on 13/07/20.
//  Copyright © 2020 Avinash. All rights reserved.
//

import UIKit
import SDWebImage
import Localize_Swift

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet var headingLabels: [UILabel]!
    @IBOutlet var descriptionLabels: [UILabel]!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func reuseIdentifier() -> String
    {
        return String(describing: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
        for headingLabel in headingLabels {
            headingLabel.text = nil
        }
        
        for descriptionLabel in descriptionLabels {
            descriptionLabel.text = nil
        }
    }
    
    func setUpCell(article: Article)
    {
        for (n, (headingLabel,descriptionLabel)) in zip(headingLabels, descriptionLabels).enumerated() {
            switch (n+1) {
            case 1:
                headingLabel.text = "Title".localized()
                descriptionLabel.text = article.title
                case 2:
                headingLabel.text = "Author".localized()
                descriptionLabel.text = article.author
                case 3:
                headingLabel.text = "Description".localized()
                descriptionLabel.text = article.description
            default:
                headingLabel.text = nil
                descriptionLabel.text = nil
            }
        }
        
        
        if let imageUrl = article.urlToImage {
            newsImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "news"))
        }
    }
}


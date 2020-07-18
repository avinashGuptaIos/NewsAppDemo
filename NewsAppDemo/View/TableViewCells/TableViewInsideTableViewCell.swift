//
//  TableViewInsideTableViewCell.swift
//  NewsAppDemo
//
//  Created by hasher on 13/07/20.
//  Copyright © 2020 Avinash. All rights reserved.
//

import UIKit
import SDWebImage

class TableViewInsideTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var tableViewx: UITableView!
    private var tableData = [NameValueObject]()
    
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
    
    func setUpCell(article: Article)
    {
        tableViewx.register(UINib(nibName: LogsTableViewCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: LogsTableViewCell.reuseIdentifier())
        tableViewx.isScrollEnabled = true
        tableViewx.dataSource = self
        tableViewx.delegate = self
//        tableViewx.contentOffset = CGPoint(x: 0, y: 40)

        tableData = [NameValueObject("Title", article.title),
                     NameValueObject("Author", article.author),
                     NameValueObject("Description", article.description)]
        if let imageUrl = article.urlToImage {
            newsImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "news"))
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
        tableViewx.dataSource = nil
        tableViewx.delegate = nil
        tableData = [NameValueObject]()
    }
}


extension TableViewInsideTableViewCell: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LogsTableViewCell.reuseIdentifier(), for: indexPath) as! LogsTableViewCell
        cell.setUpCell(heading: tableData[indexPath.row].name, value: tableData[indexPath.row].value)
        return cell 
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    //MARK: Important Method for giving the proper height in cell for tableview
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        
        tableViewx.reloadData()
        
        // if the table view is the last UI element, you might need to adjust the height
        let size = CGSize(width: targetSize.width,
                          height: tableViewx.frame.origin.y + tableViewx.contentSize.height)
        return size
        
    }

}

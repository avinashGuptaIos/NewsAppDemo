//
//  TableViewInsideTableViewCell.swift
//  NewsAppDemo
//
//  Created by hasher on 13/07/20.
//  Copyright © 2020 Avinash. All rights reserved.
//

import UIKit

class TableViewInsideTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var tableViewx: UITableView!
    var tableData = [NameValueObject]()
    
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
    
    func setUpCell(userEvent: Article)
    {
//        DateFormatterHelper.dateFormat = CoreModuleStringConstants.dateFormatter.registrationDateFormat
//        let updatedDate = DateFormatterHelper.date(from: userEvent.generatedAt ?? DateFormatterHelper.string(from: Date()))
//        timeLabel.text = CoreModule.Helpers.genericTimeFormate(updatedDate!, messageDetailScreen: false)
//
//        tableData = [NameValueObject("Status", userEvent.status?.capitalized),
//                     NameValueObject("Device", userEvent.deviceId),
//                     NameValueObject("IP Address", userEvent.ipAddress),
//                     NameValueObject("Location", "\(userEvent.city ?? ""), \(userEvent.country ?? "")")]
//
//        tableViewx.register(cellType: LogsTableViewCell.self, bundle: Bundle(identifier: CoreModuleStringConstants.BundleIds.EventsModuleIdentifier))
//        tableViewx.isScrollEnabled = false
//        tableViewx.dataSource = self
//        tableViewx.delegate = self
//        tableViewx.contentOffset = CGPoint(x: 0, y: 40)
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
        let cell = tableView.dequeueReusableCell(with: LogsTableViewCell.self, for: indexPath) 
        cell.setUpCell(heading: tableData[indexPath.row].name, value:  tableData[indexPath.row].value)
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

//
//  LogsTableViewCell.swift
//  NewsAppDemo
//
//  Created by hasher on 13/07/20.
//  Copyright © 2020 Avinash. All rights reserved.
//

import UIKit

class LogsTableViewCell: UITableViewCell {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
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
        label1.text = nil
        label2.text = nil
        label3.text = nil
    }
    
    func setUpCell(heading: String?, value: String?)
    {
        label1.text = heading
        label2.text = ":"
        label3.text = value
        
        if value == "Success" || value == "Fail"
        {
//            label3.textColor = value == "FAIL" ? .red : FSRGBA(106, 216, 167, 1.0)
        }else
        {
            label3.textColor = .lightGray
        }
    }
//    func messageDetailFileInfo(fileObj:detailObj){
//
//        label1.text = "    " + fileObj.name.capitalizingFirstLetter()
//        label1.textColor = ColorConstants.generalBlackColor
//        label2.text = ":"
//        label3.text = fileObj.value
//        label3.textColor = ColorConstants.generalBlackColor
//        label3.font = RobotoFont.medium(with: 14)
//        label1.font = RobotoFont.regular(with: 14)
//        self.fs_cornerRadius = 10.0
//    }
}

//
//  MBMotionContentTableViewCell.swift
//  MBMotion
//
//  Created by Perry on 15/12/9.
//  Copyright © 2015年 MmoaaY. All rights reserved.
//

import UIKit

class MBMotionContentTableViewCell: UITableViewCell {
    
    @IBOutlet var icon:UIImageView!
    @IBOutlet var title:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContent(content:(imageName:String, title:String)) {
        self.title.text = content.title
        self.icon.image = UIImage(named: content.imageName)
    }
    
}

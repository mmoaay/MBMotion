//
//  MBMotionTableViewCellContentView.swift
//  MBMotion
//
//  Created by ZhengYidong on 13/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

class MBMotionTableViewCellContentView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet var icon:UIImageView!
    @IBOutlet var title:UILabel!

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    init() {
        super.init(frame: CGRect.zero)
        Bundle(for: self.classForCoder).loadNibNamed("MBMotionTableViewCellContentView", owner: self, options: nil)
        
        self.addSubview(contentView)
        contentView.snp.makeConstraints { (make: ConstraintMaker) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(_ content:(imageName:String, title:String)) {
        self.title.text = content.title
        self.icon.image = UIImage(named: content.imageName)
    }
}

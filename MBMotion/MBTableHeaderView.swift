//
//  MBTableHeaderView.swift
//  MBPageControllerFromMomo
//
//  Created by Perry on 15/7/3.
//  Copyright © 2015年 MmoaaY. All rights reserved.
//

import UIKit

protocol MBTableHeaderViewDelegate {
    func swiftGGPressed()
}

class MBTableHeaderView: UIView {
    @IBOutlet var contentView: UIView!
    
    var delegate:MBTableHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NSBundle.mainBundle().loadNibNamed("MBTableHeaderView", owner: self, options: nil)
        
        self.addSubview(self.contentView)
        
        self.contentView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func swiftGGPressed(sender: AnyObject) {
        self.delegate?.swiftGGPressed()
    }
}

//
//  MBNavigationItem.swift
//  MBMotion
//
//  Created by Perry on 15/12/9.
//  Copyright © 2015年 MmoaaY. All rights reserved.
//

import UIKit

class MBNavigationItem: UINavigationItem {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
    }

}

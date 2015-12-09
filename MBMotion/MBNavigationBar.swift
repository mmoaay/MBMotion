//
//  MBNavigationBar.swift
//  MBMotion
//
//  Created by Perry on 15/12/9.
//  Copyright © 2015年 MmoaaY. All rights reserved.
//

import UIKit

enum MBNavigationBarStyle: Int {
    case Default
    case Futura
}

class MBNavigationBar: UINavigationBar {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backIndicatorImage = UIImage(named: "back_icon")
        self.backIndicatorTransitionMaskImage = UIImage(named: "back_icon")
        
        self.tintColor = UIColor(red: 42/255, green: 55/255, blue: 67/255, alpha: 1)
        
        let font = UIFont(name: "Futura", size: 18)
        if let _ = font {
            self.titleTextAttributes = [NSFontAttributeName:font!, NSForegroundColorAttributeName:UIColor(red: 42/255, green: 55/255, blue: 67/255, alpha: 1)]
        }
    }
    
    func setStyle(style:MBNavigationBarStyle) {
        switch style {
        case .Futura:
            break;
        default:
            break;
        }
    }

}

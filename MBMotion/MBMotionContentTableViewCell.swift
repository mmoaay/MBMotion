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
    
    func animatedWithContent (status:MBMotionHamburgButtonStatus, index:Int, count:Int) {
        if status == MBMotionHamburgButtonStatus.Open {
            
            var transform = CATransform3DIdentity
            transform = CATransform3DMakeTranslation(100, 0, 0)
            self.layer.transform = transform
            UIView.animateWithDuration(0.2, delay: Double(index)*0.05, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                
                transform = CATransform3DIdentity
                transform = CATransform3DMakeTranslation(-6, 0, 0)
                self.layer.transform = transform
                
                }, completion: { (Bool) -> Void in
                    
                    UIView.animateWithDuration(0.15, animations: { () -> Void in
                        self.layer.transform = CATransform3DIdentity
                    })
            })
            
            self.layer.opacity = 0.0
            UIView.animateWithDuration(0.35, delay: Double(index)*0.05, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.layer.opacity = 1.0
                }, completion: nil)
        }else {
            var transform = CATransform3DIdentity
            transform = CATransform3DMakeTranslation(-6, 0, 0)
            
            UIView.animateWithDuration(0.05, delay: Double(count-1-index)*0.02, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                
                self.layer.transform = transform
                
                }, completion: { (Bool) -> Void in
                    
                    UIView.animateWithDuration(0.05, animations: { () -> Void in
                        transform = CATransform3DIdentity
                        transform = CATransform3DMakeTranslation(100, 0, 0)
                        self.layer.transform = transform
                    })
            })
            
            self.layer.opacity = 1.0
            UIView.animateWithDuration(0.15, delay: Double(count-1-index)*0.02, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.layer.opacity = 0.0
                }, completion: nil)
        }
    }
}

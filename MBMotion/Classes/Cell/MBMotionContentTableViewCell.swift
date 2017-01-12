//
//  MBMotionContentTableViewCell.swift
//  MBMotion
//
//  Created by Perry on 15/12/9.
//  Copyright © 2015年 MmoaaY. All rights reserved.
//

import UIKit

public class MBMotionContentTableViewCell: UITableViewCell {
    
    @IBOutlet var icon:UIImageView!
    @IBOutlet var title:UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public func setContent(_ content:(imageName:String, title:String)) {
        self.title.text = content.title
        self.icon.image = UIImage(named: content.imageName)
    }
    
    public func animatedWithContent (_ status:MBMotionHamburgButtonStatus, index:Int, count:Int) {
        if status == MBMotionHamburgButtonStatus.open {
            
            var transform = CATransform3DIdentity
            transform = CATransform3DMakeTranslation(100, 0, 0)
            self.layer.transform = transform
            UIView.animate(withDuration: 0.3, delay: Double(index)*0.05, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
                
                transform = CATransform3DIdentity
                transform = CATransform3DMakeTranslation(-6, 0, 0)
                self.layer.transform = transform
                
                }, completion: { (Bool) -> Void in
                    
                    UIView.animate(withDuration: 0.2, animations: { () -> Void in
                        self.layer.transform = CATransform3DIdentity
                    })
            })
            
            self.layer.opacity = 0.0
            UIView.animate(withDuration: 0.5, delay: Double(index)*0.05, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
                self.layer.opacity = 1.0
                }, completion: nil)
        }else {
            var transform = CATransform3DIdentity
            transform = CATransform3DMakeTranslation(-6, 0, 0)
            
            UIView.animate(withDuration: 0.05, delay: Double(count-1-index)*0.02, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
                
                self.layer.transform = transform
                
                }, completion: { (Bool) -> Void in
                    
                    UIView.animate(withDuration: 0.05, animations: { () -> Void in
                        transform = CATransform3DIdentity
                        transform = CATransform3DMakeTranslation(100, 0, 0)
                        self.layer.transform = transform
                    })
            })
            
            self.layer.opacity = 1.0
            UIView.animate(withDuration: 0.15, delay: Double(count-1-index)*0.02, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
                self.layer.opacity = 0.0
                }, completion: nil)
        }
    }
}

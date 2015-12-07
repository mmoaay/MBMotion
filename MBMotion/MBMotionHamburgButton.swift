//
//  MBMotionHamburgButton.swift
//  MBMotion
//
//  Created by Perry on 15/12/3.
//  Copyright © 2015年 MmoaaY. All rights reserved.
//

import UIKit

protocol MBMotionHamburgButtonDelegate {
    func buttonPressed(status:ButtonStatus)
}

enum ButtonStatus:Int{
    case Open
    case Close
}

class MBMotionHamburgButton: UIView {

    @IBOutlet var view: UIView!
    var delegate: MBMotionHamburgButtonDelegate?
    
    private var status = ButtonStatus.Open
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
   
    @IBOutlet var lineView: UIView!
    @IBOutlet private var topLine: UIView!
    @IBOutlet private var bottomLine: UIView!

    @IBAction func buttonPressed(sender: AnyObject) {
        self.delegate?.buttonPressed(self.status)
        
        self.animationForButton()
        
        if self.status == ButtonStatus.Open {
            self.status = ButtonStatus.Close
        } else {
            self.status = ButtonStatus.Open
        }
    }
    
    private func animationForButton() {
        if self.status == ButtonStatus.Open {
            self.animationOpen()
        } else {
            self.animationClose()
        }
    }
    
    private func animtedWithLine(line:UIView!, angle:CGFloat, tx:CGFloat,ty:CGFloat, duration:NSTimeInterval) {
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, tx, ty, 0)
        transform = CATransform3DRotate(transform, angle, 0, 0, 1)
        
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = NSValue(CATransform3D: line.layer.transform)
        animation.toValue = NSValue(CATransform3D: transform)
        animation.duration = duration
        
        line.layer.addAnimation(animation, forKey: "transform")
        line.layer.transform = transform
        
//        UIView.animateWithDuration(duration) { () -> Void in
//            var transform = CGAffineTransformIdentity
//            transform = CGAffineTransformTranslate(transform, tx, ty)
//            transform = CGAffineTransformRotate(transform, angle)
//            
//            line.transform = transform
//        }
    }
    
    private func animationOpen() {
        self.animtedWithLine(self.topLine, angle: 0.0, tx: 0, ty: 3, duration: 0.2)
        self.animtedWithLine(self.bottomLine, angle: 0.0, tx: 0, ty: -3, duration: 0.2)
        
        MBTimeUtil.executeAfterDelay(0.2) { () -> Void in
            self.animtedWithLine(self.topLine, angle: 0.0, tx: 0, ty: 4.5, duration: 0.2)
            self.animtedWithLine(self.bottomLine, angle: 0.0, tx: 0, ty: -4.5, duration: 0.2)
        }
        
        MBTimeUtil.executeAfterDelay(0.4) { () -> Void in
            self.animtedWithLine(self.topLine, angle: CGFloat(M_PI_4+M_PI_4/5), tx: 0, ty: 4.5, duration: 0.3)
            self.animtedWithLine(self.bottomLine, angle: CGFloat(M_PI_4*3+M_PI_4/5), tx: 0, ty: -4.5, duration: 0.3)
        }
        
        MBTimeUtil.executeAfterDelay(0.7) { () -> Void in
            self.animtedWithLine(self.topLine, angle: CGFloat(M_PI_4), tx: 0, ty: 4.5, duration: 0.1)
            self.animtedWithLine(self.bottomLine, angle: CGFloat(M_PI_4*3), tx: 0, ty: -4.5, duration: 0.1)
        }
    }
    
    private func animationClose() {
        self.animtedWithLine(self.topLine, angle: CGFloat(M_PI_4+M_PI_4/5), tx: 0, ty: 4.5, duration: 0.1)
        self.animtedWithLine(self.bottomLine, angle: CGFloat(M_PI_4*3+M_PI_4/5), tx: 0, ty: -4.5, duration: 0.1)
        
        MBTimeUtil.executeAfterDelay(0.1) { () -> Void in
            self.animtedWithLine(self.topLine, angle: 0.0, tx: 0, ty: 4.5, duration: 0.3)
            self.animtedWithLine(self.bottomLine, angle: 0.0, tx: 0, ty: -4.5, duration: 0.3)
        }
        
        MBTimeUtil.executeAfterDelay(0.4) { () -> Void in
            self.animtedWithLine(self.topLine, angle: 0.0, tx: 0, ty: 3, duration: 0.2)
            self.animtedWithLine(self.bottomLine, angle: 0.0, tx: 0, ty: -3, duration: 0.2)
        }

        MBTimeUtil.executeAfterDelay(0.6) { () -> Void in
            self.animtedWithLine(self.topLine, angle: 0.0, tx: 0, ty: 0, duration: 0.2)
            self.animtedWithLine(self.bottomLine, angle: 0.0, tx: 0, ty: 0, duration: 0.2)
        }
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NSBundle.mainBundle().loadNibNamed("MBMotionHamburgButton", owner: self, options: nil)
        
        self.addSubview(self.view)
        self.view.snp_makeConstraints { (make) -> Void in
            make.leading.top.bottom.trailing.equalTo(self)
        }
    }
}

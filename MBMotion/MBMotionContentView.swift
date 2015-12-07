//
//  MBMotionContentView.swift
//  MBMotion
//
//  Created by Perry on 15/12/3.
//  Copyright © 2015年 MmoaaY. All rights reserved.
//

import UIKit

protocol MBMotionContentViewDelegate {
    func switchButtonPressed(status:ButtonStatus)
}

class MBMotionContentView: UIView, MBMotionHamburgButtonDelegate{

    @IBOutlet private var view: UIView!
    @IBOutlet private var button: MBMotionHamburgButton!
    @IBOutlet private var indicatorView: UIView!
    
    var delegate:MBMotionContentViewDelegate?
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    init() {
        super.init(frame: CGRectZero)
        NSBundle.mainBundle().loadNibNamed("MBMotionContentView", owner: self, options: nil)
        
        self.button.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func getContentView() -> UIView! {
        return self.view
    }

    func buttonPressed(status:ButtonStatus) {
        self.animationForIndicator(status)
        self.animationForSwitchButton(status)
        
        self.delegate?.switchButtonPressed(status)
    }
    
    private func animationForSwitchButton (status:ButtonStatus) {
        
        var transform = CATransform3DIdentity
        if status == ButtonStatus.Open {
            transform = CATransform3DMakeTranslation(0, 20.0, 0)
        }else {
            transform = CATransform3DMakeTranslation(0, 0, 0)
        }
        
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = NSValue(CATransform3D: self.button.layer.transform)
        animation.toValue = NSValue(CATransform3D: transform)
        animation.duration = 0.8
        
        button.layer.addAnimation(animation, forKey: "transform")
        button.layer.transform = transform
    }
    
    private func animationForIndicator (status:ButtonStatus) {
        if status == ButtonStatus.Open {
            MBTimeUtil.executeAfterDelay(0.6, clurse: { () -> Void in
                UIView.animateWithDuration(0.2) { () -> Void in
                    self.indicatorView.layer.opacity = 1.0 }
            })
        }else {
            UIView.animateWithDuration(0.2) { () -> Void in
                self.indicatorView.layer.opacity = 0.0
            }
        }
    }
}

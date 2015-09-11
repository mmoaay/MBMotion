//
//  MBMotionActionSheet.swift
//  MBMotion
//
//  Created by Perry on 15/9/7.
//  Copyright (c) 2015年 MmoaaY. All rights reserved.
//

import UIKit

class MBMotionActionSheet: NSObject {
    
    private var backgroundLayer = CAShapeLayer()
    
    @IBOutlet var bkgroundView: UIView!
    @IBOutlet var motionView: UIView!
    
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    private weak var containerView: UIView?
    
    var isExpanded:Bool
    var isShown:Bool
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
    init(containerView: UIView!, contentView: UIView!) {
        
        self.isShown = false
        self.isExpanded = false
        
        super.init()
        
        self.containerView = containerView
        
        NSBundle.mainBundle().loadNibNamed("MBMotionActionSheet", owner: self, options: nil)
        
        self.contentView.addSubview(contentView)
        contentView.snp_makeConstraints { (make) -> Void in
            make.leading.bottom.trailing.equalTo(self.contentView)
            make.top.equalTo(self.contentView.snp_top).offset(44.0)
        }
        
        self.initSwitchButtonStyle()
    }
    
    private func initSwitchButtonStyle() {
        self.containerView?.layoutIfNeeded()
        
        let topViewMaskPath = UIBezierPath(roundedRect: self.switchButton.bounds, byRoundingCorners: (UIRectCorner.TopLeft|UIRectCorner.TopRight), cornerRadii: CGSizeMake(5.0, 5.0))
        var topViewMaskLayer = CAShapeLayer()
        topViewMaskLayer.frame = self.switchButton.bounds;
        topViewMaskLayer.path = topViewMaskPath.CGPath;
        self.switchButton.layer.mask = topViewMaskLayer;
    }
    
    @IBAction func switchPressed(sender: AnyObject) {
        if true == isExpanded {
            self.collapseActionSheet()
        } else {
            self.expandActionSheet()
        }
    }
    
    func showActionSheet() {
        if (true == isShown) {
            self.hideActionSheet()
            
        } else {
            self.addActionSheet()
            self.expandActionSheet()
        }
    }
    
    
    private func animatedWithMotionView(height:Float, duration:NSTimeInterval) {
        self.motionView.snp_updateConstraints { (make) -> Void in
            make.height.equalTo(height)
        }
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.containerView?.layoutIfNeeded()
            }) { (Bool) -> Void in
        }
    }
    
    private func animatedWithSwitchButton(opacity:Float, duration:NSTimeInterval) {
        self.switchButton.snp_updateConstraints { (make) -> Void in
            if 0.0 == opacity {
                make.bottom.equalTo(self.contentView.snp_top).offset(84.0)
            } else {
                make.bottom.equalTo(self.contentView.snp_top).offset(44.0)
            }
        }
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.containerView?.layoutIfNeeded()
            self.switchButton.layer.opacity = opacity
            }) { (Bool) -> Void in
                
        }
    }
    
    private func animtedWithRipples(fromValue:Float, toValue:Float, duration:NSTimeInterval, keyPath:String, key:String){
        let inAnimation = CAKeyframeAnimation(keyPath: keyPath)
        
        inAnimation.duration = duration
        inAnimation.fillMode = kCAFillModeForwards
        inAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        var pathValues = Array<CGPathRef>()
        for(var i = 0; i <= Int(duration * 60); i++){
            pathValues.append(pathForRipples(Float(Float(i) / (Float(duration) * 60)), fromValue:fromValue, toValue:toValue))
        }
        
        inAnimation.values = pathValues
        inAnimation.autoreverses = false
        inAnimation.removedOnCompletion = false
        inAnimation.delegate = self
        backgroundLayer.path = pathForRipples(1, fromValue:fromValue, toValue:toValue)
        
        backgroundLayer.addAnimation(inAnimation, forKey: key)
    }
    
    private func pathForRipples(progress:Float, fromValue:Float, toValue:Float) -> CGPathRef{
        var valuePorgress = CGFloat((toValue-fromValue) * progress)
        var path = UIBezierPath()
        
        
        var controlPointTop = CGPointMake(self.contentView.width * 0.5, (CGFloat(fromValue)+valuePorgress))
        path.moveToPoint(CGPointMake(0, 44))
        path.addQuadCurveToPoint(CGPointMake(self.contentView.width, 44), controlPoint: controlPointTop)
        path.addLineToPoint(CGPointMake(self.contentView.width, self.contentView.height))
        path.addLineToPoint(CGPointMake(0, self.contentView.height))
        path.addLineToPoint(CGPointMake(0, 44))
        
        return path.CGPath
    }
    
    private func animtedWithBkGround(opacity:Float, duration:NSTimeInterval) {
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.bkgroundView.layer.opacity = opacity
            }) { (Bool) -> Void in
                if 0.0 == opacity {
                    self.bkgroundView.userInteractionEnabled = false
                } else {
                    self.bkgroundView.userInteractionEnabled = true
                }
        }
    }
    
    private func collapseActionSheet() {
        self.animatedWithSwitchButton(0.0, duration: 0.2)
        
        self.executeAfterDelay(0.2, clurse: { () -> Void in
            self.animtedWithBkGround(0.0, duration: 0.8)
            self.animtedWithRipples(44.0, toValue: 34.0, duration: 0.1, keyPath: "path", key: "stepfour")
        })
        
        self.executeAfterDelay(0.3, clurse: { () -> Void in
            self.animtedWithRipples(34.0, toValue: 54.0, duration: 0.1, keyPath: "path", key: "stepthree")
        })
        
        self.executeAfterDelay(0.4, clurse: {
            self.animtedWithRipples(54.0, toValue: 0.0, duration: 0.4, keyPath: "path", key: "steptwo")
            self.animatedWithMotionView(Float(UIScreen.mainScreen().bounds.size.height)/2.0, duration: 0.4)
        })
        
        self.executeAfterDelay(0.8, clurse: {
            self.animtedWithRipples(0.0, toValue: 44.0, duration: 0.2, keyPath: "path", key: "stepone")
        })
        
        self.executeAfterDelay(1.0, clurse: { () -> Void in
            self.isExpanded = false
            self.setSwitchButtonTitle()
            
            self.animatedWithSwitchButton(1.0, duration: 0.2)
        })
    }
    
    private func expandActionSheet() {
        self.animatedWithSwitchButton(0.0, duration: 0.2)
        
        self.executeAfterDelay(0.2, clurse: {
            self.animtedWithBkGround(0.1, duration: 0.8)
            self.animtedWithRipples(44.0, toValue: 0.0, duration: 0.2, keyPath: "path", key: "stepone")
        })
        
        self.executeAfterDelay(0.4, clurse: {
            self.animatedWithMotionView(Float(UIScreen.mainScreen().bounds.size.height)-100.0, duration: 0.4)
            self.animtedWithRipples(0.0, toValue: 54.0, duration: 0.4, keyPath: "path", key: "steptwo")
        })
        
        self.executeAfterDelay(0.8, clurse: { () -> Void in
            self.animtedWithRipples(54.0, toValue: 34.0, duration: 0.1, keyPath: "path", key: "stepthree")
        })
        
        self.executeAfterDelay(0.9, clurse: { () -> Void in
            self.animtedWithRipples(34.0, toValue: 44.0, duration: 0.1, keyPath: "path", key: "stepfour")
        })
        
        self.executeAfterDelay(1.0, clurse: { () -> Void in
            self.isExpanded = true
            self.setSwitchButtonTitle()
            self.isShown = true
            
            self.animatedWithSwitchButton(1.0, duration: 0.2)
        })
    }
    
    private func setSwitchButtonTitle() {
        self.switchButton.setTitle(true == self.isExpanded ? "Collapse" : "Expand", forState: UIControlState.Normal)
    }
    
    private func addActionSheet() {
        if let containerView = self.containerView {
            self.containerView?.addSubview(self.bkgroundView)
            self.bkgroundView.snp_remakeConstraints { (make) -> Void in
                make.edges.equalTo(self.containerView!)
            }
            
            self.containerView?.addSubview(self.motionView)
            self.motionView.snp_remakeConstraints { (make) -> Void in
                make.height.equalTo(44.0)
                make.leading.trailing.equalTo(self.containerView!)
                make.bottom.equalTo(self.containerView!)
            }
            self.containerView?.layoutIfNeeded()
            
            backgroundLayer.fillColor = self.contentView.backgroundColor?.CGColor
            let path = UIBezierPath()
            path.moveToPoint(CGPointMake(0, 44.0))
            path.addLineToPoint(CGPointMake(self.contentView.width, 44.0))
            path.addLineToPoint(CGPointMake(self.contentView.width, self.contentView.height))
            path.addLineToPoint(CGPointMake(0, self.contentView.height))
            path.addLineToPoint(CGPointMake(0, 44.0))
            backgroundLayer.strokeColor = UIColor.clearColor().CGColor
            backgroundLayer.path = path.CGPath
            backgroundLayer.frame = self.contentView.layer.bounds
            
            self.contentView.layer.mask = backgroundLayer
            self.contentView.layer.masksToBounds = true
        }
    }
    
    private func hideActionSheet() {
        self.animatedWithSwitchButton(0.0, duration: 0.2)
        
        self.executeAfterDelay(0.2, clurse: { () -> Void in
            self.animtedWithBkGround(0.0, duration: 0.8)
            self.animtedWithRipples(44.0, toValue: 34.0, duration: 0.1, keyPath: "path", key: "stepfour")
        })
        
        self.executeAfterDelay(0.3, clurse: { () -> Void in
            self.animtedWithRipples(34.0, toValue: 54.0, duration: 0.1, keyPath: "path", key: "stepthree")
        })
        
        self.executeAfterDelay(0.4, clurse: {
            self.animtedWithRipples(54.0, toValue: 0.0, duration: 0.4, keyPath: "path", key: "steptwo")
            self.animatedWithMotionView(44.0, duration: 0.4)
        })
        
        self.executeAfterDelay(0.8, clurse: {
            self.animtedWithRipples(0.0, toValue: 44.0, duration: 0.2, keyPath: "path", key: "stepone")
        })
        
        self.executeAfterDelay(1.0, clurse: { () -> Void in
            self.isExpanded = false
            self.setSwitchButtonTitle()
            
            self.motionView.removeFromSuperview()
            self.bkgroundView.removeFromSuperview()
            self.isShown = false
        })
    }
    
    private func executeAfterDelay(delayTime:NSTimeInterval,clurse:() -> Void
        ){
            let delay = dispatch_time(DISPATCH_TIME_NOW,
                Int64(delayTime * Double(NSEC_PER_SEC)))
            dispatch_after(delay, dispatch_get_main_queue()) {
                clurse()
            }
    }
    
}


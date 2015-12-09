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
    
    @IBOutlet weak var contentView: UIView!
    
    private weak var containerView: UIView?
    
    var isExpanded:Bool = false
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
    init(containerView: UIView!, contentView: UIView!) {        
        super.init()
        
        self.containerView = containerView
        
        NSBundle.mainBundle().loadNibNamed("MBMotionActionSheet", owner: self, options: nil)
        
        self.contentView.addSubview(contentView)
        contentView.snp_makeConstraints { (make) -> Void in
            make.leading.bottom.trailing.equalTo(self.contentView)
            make.top.equalTo(self.contentView.snp_top).offset(44.0)
        }
        
        self.addActionSheet()
    }
    
    private func animatedWithMotionView(height:Float, duration:NSTimeInterval ,options:UIViewAnimationOptions) {
        self.motionView.snp_updateConstraints { (make) -> Void in
            make.height.equalTo(height)
        }
        UIView.animateWithDuration(duration, delay: 0.0, options: options, animations: { () -> Void in
            UIApplication.sharedApplication().keyWindow?.layoutIfNeeded()
            }, completion: nil)
    }
    
    private func animtedWithRipples(fromValue:Float, toValue:Float, duration:NSTimeInterval){
        let animation = CAKeyframeAnimation(keyPath: "path")
        
        animation.duration = duration
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        var pathValues = Array<CGPathRef>()
        for(var i = 0; i <= Int(duration * 60); i++){
            pathValues.append(getRipplesPath(Float(Float(i) / (Float(duration) * 60)), fromValue:fromValue, toValue:toValue))
        }
        
        animation.values = pathValues
        animation.autoreverses = false
        animation.removedOnCompletion = false
        animation.delegate = self
        backgroundLayer.path = getRipplesPath(1, fromValue:fromValue, toValue:toValue)
        
        backgroundLayer.addAnimation(animation, forKey: "ripples")
    }
    
    private func getRipplesPath(progress:Float, fromValue:Float, toValue:Float) -> CGPathRef{
        let valuePorgress = CGFloat((toValue-fromValue) * progress)
        let path = UIBezierPath()
        
        
        let controlPointTop = CGPointMake(self.contentView.width * 0.5, (CGFloat(fromValue)+valuePorgress))
        path.moveToPoint(CGPointMake(0, 44))
        path.addQuadCurveToPoint(CGPointMake(self.contentView.width, 44), controlPoint: controlPointTop)
        path.addLineToPoint(CGPointMake(self.contentView.width, self.contentView.height))
        path.addLineToPoint(CGPointMake(0, self.contentView.height))
        path.addLineToPoint(CGPointMake(0, 44))
        
        return path.CGPath
    }
    
    private func animtedWithContainerView(sx:CGFloat,sy:CGFloat,sz:CGFloat, duration:NSTimeInterval) {
        UIView.animateWithDuration(duration) { () -> Void in
            self.containerView?.layer.transform = CATransform3DMakeScale(sx, sy, sz)
        }
    }
    
    private func animatedWithStatusBar (style:UIStatusBarStyle, duration:NSTimeInterval) {
        if let _ = self.containerView {
            UIApplication.sharedApplication().setStatusBarStyle(style, animated: true)
        }
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
    
    private func addActionSheet() {
        UIApplication.sharedApplication().keyWindow?.addSubview(self.bkgroundView)
        self.bkgroundView.snp_remakeConstraints { (make) -> Void in
            make.edges.equalTo(UIApplication.sharedApplication().keyWindow!)
        }
        
        UIApplication.sharedApplication().keyWindow?.addSubview(self.motionView)
        self.motionView.snp_remakeConstraints { (make) -> Void in
            make.height.equalTo(44.0+49.0)
            make.leading.trailing.equalTo(UIApplication.sharedApplication().keyWindow!)
            make.bottom.equalTo(UIApplication.sharedApplication().keyWindow!)
        }
        
        UIApplication.sharedApplication().keyWindow?.layoutIfNeeded()
        
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
    
    func removeActionSheet() {
        self.motionView.removeFromSuperview()
        self.bkgroundView.removeFromSuperview()
    }
    
    func expandActionSheet() {
        if !self.isExpanded {
            self.animtedWithBkGround(0.4, duration: 0.8)
            self.animatedWithStatusBar(UIStatusBarStyle.LightContent,duration: 0.8)
            
            self.animtedWithRipples(44.0, toValue: 0.0, duration: 0.3)
            self.animtedWithContainerView(1.02, sy: 1.02, sz: 1.02, duration: 0.3)
            
            
            MBTimeUtil.executeAfterDelay(0.3, clurse: {
                self.animatedWithMotionView(Float(UIScreen.mainScreen().bounds.size.height)-25.0, duration: 0.3, options: UIViewAnimationOptions.CurveEaseIn)
                self.animtedWithRipples(0.0, toValue: 54.0, duration: 0.3)
                
                self.animtedWithContainerView(0.89, sy: 0.89, sz: 0.89, duration: 0.4)
            })
            
            MBTimeUtil.executeAfterDelay(0.6, clurse: { () -> Void in
                self.animtedWithRipples(54.0, toValue: 34.0, duration: 0.1)
            })
            
            MBTimeUtil.executeAfterDelay(0.7, clurse: { () -> Void in
                self.animtedWithRipples(34.0, toValue: 44.0, duration: 0.1)
                self.animtedWithContainerView(0.9, sy: 0.9, sz: 0.9, duration: 0.1)
            })
            
            MBTimeUtil.executeAfterDelay(0.8, clurse: { () -> Void in
                self.isExpanded = true
            })
        }
    }
    
    func collapseActionSheet() {
        if self.isExpanded {
            self.animtedWithBkGround(0.0, duration: 0.8)
            self.animatedWithStatusBar(UIStatusBarStyle.Default,duration: 0.8)
            self.animtedWithRipples(44.0, toValue: 34.0, duration: 0.1)
            self.animtedWithContainerView(0.89, sy: 0.89, sz: 0.89, duration: 0.1)
            
            MBTimeUtil.executeAfterDelay(0.1, clurse: { () -> Void in
                self.animtedWithRipples(34.0, toValue: 54.0, duration: 0.1)
                self.animtedWithContainerView(1.02, sy: 1.02, sz: 1.02, duration: 0.4)
            })
            
            MBTimeUtil.executeAfterDelay(0.2, clurse: {
                self.animtedWithRipples(54.0, toValue: 0.0, duration: 0.3)
                self.animatedWithMotionView(44.0+49.0, duration: 0.3, options: UIViewAnimationOptions.CurveEaseOut)
            })
            
            MBTimeUtil.executeAfterDelay(0.5, clurse: {
                self.animtedWithRipples(0.0, toValue: 44.0, duration: 0.3)
                self.animtedWithContainerView(1, sy: 1, sz: 1, duration: 0.3)
            })
            
            MBTimeUtil.executeAfterDelay(0.8, clurse: { () -> Void in
                self.isExpanded = false
            })
        }
    }
}


//
//  MBMotionActionSheet.swift
//  MBMotion
//
//  Created by Perry on 15/9/7.
//  Copyright (c) 2015年 MmoaaY. All rights reserved.
//

import UIKit
import SnapKit

public class MBMotionActionSheet: NSObject, CAAnimationDelegate {
    
    fileprivate var backgroundLayer = CAShapeLayer()
    
    @IBOutlet var bkgroundView: UIView!
    @IBOutlet var motionView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    fileprivate weak var containerView: UIView?
    
    var isExpanded:Bool = false
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
    public init(containerView: UIView!, contentView: UIView!) {
        super.init()
        
        self.containerView = containerView
        
        Bundle(for: self.classForCoder).loadNibNamed("MBMotionActionSheet", owner: self, options: nil)
        
        self.contentView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) -> Void in
            make.leading.bottom.trailing.equalTo(self.contentView)
            make.top.equalTo(self.contentView.snp_top).offset(44.0)
        }
        
        self.addActionSheet()
    }
    
    fileprivate func animatedWithMotionView(_ height:Float, duration:TimeInterval ,options:UIViewAnimationOptions) {
        self.motionView.snp_updateConstraints { (make) -> Void in
            make.height.equalTo(height)
        }
        UIView.animate(withDuration: duration, delay: 0.0, options: options, animations: { () -> Void in
            UIApplication.shared.keyWindow?.layoutIfNeeded()
            }, completion: nil)
    }
    
    fileprivate func animtedWithRipples(_ fromValue:Float, toValue:Float, duration:TimeInterval){
        let animation = CAKeyframeAnimation(keyPath: "path")
        
        animation.duration = duration
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        var pathValues = Array<CGPath>()
        
        for i in 0...Int(duration * 60) {
             pathValues.append(getRipplesPath(Float(Float(i) / (Float(duration) * 60)), fromValue:fromValue, toValue:toValue))
        }
        
        animation.values = pathValues
        animation.autoreverses = false
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        backgroundLayer.path = getRipplesPath(1, fromValue:fromValue, toValue:toValue)
        
        backgroundLayer.add(animation, forKey: "ripples")
    }
    
    fileprivate func getRipplesPath(_ progress:Float, fromValue:Float, toValue:Float) -> CGPath{
        let valuePorgress = CGFloat((toValue-fromValue) * progress)
        let path = UIBezierPath()
        
        
        let controlPointTop = CGPoint(x: self.contentView.width * 0.5, y: (CGFloat(fromValue)+valuePorgress))
        path.move(to: CGPoint(x: 0, y: 44))
        path.addQuadCurve(to: CGPoint(x: self.contentView.width, y: 44), controlPoint: controlPointTop)
        path.addLine(to: CGPoint(x: self.contentView.width, y: self.contentView.height))
        path.addLine(to: CGPoint(x: 0, y: self.contentView.height))
        path.addLine(to: CGPoint(x: 0, y: 44))
        
        return path.cgPath
    }
    
    fileprivate func animtedWithContainerView(_ sx:CGFloat,sy:CGFloat,sz:CGFloat, duration:TimeInterval) {
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.containerView?.layer.transform = CATransform3DMakeScale(sx, sy, sz)
        }) 
    }
    
    fileprivate func animatedWithStatusBar (_ style:UIStatusBarStyle, duration:TimeInterval) {
        if let _ = self.containerView {
            UIApplication.shared.setStatusBarStyle(style, animated: true)
        }
    }
    
    fileprivate func animtedWithBkGround(_ opacity:Float, duration:TimeInterval) {
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.bkgroundView.layer.opacity = opacity
            }, completion: { (Bool) -> Void in
                if 0.0 == opacity {
                    self.bkgroundView.isUserInteractionEnabled = false
                } else {
                    self.bkgroundView.isUserInteractionEnabled = true
                }
        }) 
    }
    
    fileprivate func addActionSheet() {
        UIApplication.shared.keyWindow?.addSubview(self.bkgroundView)
        self.bkgroundView.snp_remakeConstraints { (make) -> Void in
            make.edges.equalTo(UIApplication.shared.keyWindow!)
        }
        
        UIApplication.shared.keyWindow?.addSubview(self.motionView)
        self.motionView.snp_remakeConstraints { (make) -> Void in
            make.height.equalTo(44.0+49.0)
            make.leading.trailing.equalTo(UIApplication.shared.keyWindow!)
            make.bottom.equalTo(UIApplication.shared.keyWindow!)
        }
        
        UIApplication.shared.keyWindow?.layoutIfNeeded()
        
        backgroundLayer.fillColor = self.contentView.backgroundColor?.cgColor
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 44.0))
        path.addLine(to: CGPoint(x: self.contentView.width, y: 44.0))
        path.addLine(to: CGPoint(x: self.contentView.width, y: self.contentView.height))
        path.addLine(to: CGPoint(x: 0, y: self.contentView.height))
        path.addLine(to: CGPoint(x: 0, y: 44.0))
        backgroundLayer.strokeColor = UIColor.clear.cgColor
        backgroundLayer.path = path.cgPath
        backgroundLayer.frame = self.contentView.layer.bounds
        
        self.contentView.layer.mask = backgroundLayer
        self.contentView.layer.masksToBounds = true
    }
    
    public func removeActionSheet() {
        self.motionView.removeFromSuperview()
        self.bkgroundView.removeFromSuperview()
    }
    
    public func expandActionSheet() {
        if false == self.isExpanded {
            self.animtedWithBkGround(0.4, duration: 0.8)
            self.animatedWithStatusBar(UIStatusBarStyle.lightContent,duration: 0.8)
            
            self.animtedWithRipples(44.0, toValue: 0.0, duration: 0.3)
            self.animtedWithContainerView(1.02, sy: 1.02, sz: 1.02, duration: 0.3)
            
            
            MBTimeUtil.executeAfterDelay(0.3, clurse: {
                self.animatedWithMotionView(Float(UIScreen.main.bounds.size.height)-25.0, duration: 0.3, options: UIViewAnimationOptions.curveEaseIn)
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
    
    public func collapseActionSheet() {
        if true == self.isExpanded {
            self.animtedWithBkGround(0.0, duration: 0.8)
            self.animatedWithStatusBar(UIStatusBarStyle.default,duration: 0.8)
            self.animtedWithRipples(44.0, toValue: 34.0, duration: 0.1)
            self.animtedWithContainerView(0.89, sy: 0.89, sz: 0.89, duration: 0.1)
            
            MBTimeUtil.executeAfterDelay(0.1, clurse: { () -> Void in
                self.animtedWithRipples(34.0, toValue: 54.0, duration: 0.1)
                self.animtedWithContainerView(1.02, sy: 1.02, sz: 1.02, duration: 0.4)
            })
            
            MBTimeUtil.executeAfterDelay(0.2, clurse: {
                self.animtedWithRipples(54.0, toValue: 0.0, duration: 0.3)
                self.animatedWithMotionView(44.0+49.0, duration: 0.3, options: UIViewAnimationOptions.curveEaseOut)
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


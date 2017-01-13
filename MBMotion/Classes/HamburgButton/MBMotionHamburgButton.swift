//
//  MBMotionHamburgButton.swift
//  MBMotion
//
//  Created by Perry on 15/12/3.
//  Copyright © 2015年 MmoaaY. All rights reserved.
//

import UIKit

public protocol MBMotionHamburgButtonDelegate {
    func buttonPressed(_ status:MBMotionHamburgButtonStatus)
}

public enum MBMotionHamburgButtonStatus:Int{
    case open
    case close
}

public class MBMotionHamburgButton: UIView {

    @IBOutlet var button: UIButton!
    @IBOutlet var view: UIView!
    public var delegate: MBMotionHamburgButtonDelegate?
    
    fileprivate var status = MBMotionHamburgButtonStatus.open
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
   
    @IBOutlet var lineView: UIView!
    @IBOutlet fileprivate var topLine: UIView!
    @IBOutlet fileprivate var bottomLine: UIView!

    @IBAction func buttonPressed(_ sender: AnyObject) {
        self.delegate?.buttonPressed(self.status)
        
        self.animatedWithButton()
    }
    
    fileprivate func animatedWithButton() {
        if self.status == MBMotionHamburgButtonStatus.open {
            self.closeSwitchButton()
        } else {
            self.openSwithButton()
        }
    }
    
    fileprivate func animtedWithLineColor(_ line:UIView!, color:UIColor, duration:TimeInterval) {
        UIView.animate(withDuration: duration, animations: { () -> Void in
            line.layer.backgroundColor = color.cgColor
        }) 
    }
    
    fileprivate func animtedWithLineShape(_ line:UIView!, angle:CGFloat, tx:CGFloat,ty:CGFloat, duration:TimeInterval) {
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, tx, ty, 0)
        transform = CATransform3DRotate(transform, angle, 0, 0, 1)
        
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = NSValue(caTransform3D: line.layer.transform)
        animation.toValue = NSValue(caTransform3D: transform)
        animation.duration = duration
        
        line.layer.add(animation, forKey: "lineshape")
        line.layer.transform = transform
    }
    
    fileprivate func closeSwitchButton() {
        self.button.isEnabled = false
        self.animtedWithLineShape(self.topLine, angle: 0.0, tx: 0, ty: 3, duration: 0.2)
        self.animtedWithLineShape(self.bottomLine, angle: 0.0, tx: 0, ty: -3, duration: 0.2)
        
        self.animtedWithLineColor(self.topLine, color: UIColor(red: 173/255, green: 181/255, blue: 184/255, alpha: 1), duration: 0.8)
        self.animtedWithLineColor(self.bottomLine, color: UIColor(red: 173/255, green: 181/255, blue: 184/255, alpha: 1), duration: 0.8)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.2) {
            self.animtedWithLineShape(self.topLine, angle: 0.0, tx: 0, ty: 4.5, duration: 0.2)
            self.animtedWithLineShape(self.bottomLine, angle: 0.0, tx: 0, ty: -4.5, duration: 0.2)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.4) {
            self.animtedWithLineShape(self.topLine, angle: CGFloat(M_PI_4+M_PI_4/5), tx: 0, ty: 4.5, duration: 0.3)
            self.animtedWithLineShape(self.bottomLine, angle: CGFloat(M_PI_4*3+M_PI_4/5), tx: 0, ty: -4.5, duration: 0.3)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.7) {
            self.animtedWithLineShape(self.topLine, angle: CGFloat(M_PI_4), tx: 0, ty: 4.5, duration: 0.1)
            self.animtedWithLineShape(self.bottomLine, angle: CGFloat(M_PI_4*3), tx: 0, ty: -4.5, duration: 0.1)
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.8) {
            self.status = MBMotionHamburgButtonStatus.close
            self.button.isEnabled = true
        }
    }
    
    fileprivate func openSwithButton() {
        self.button.isEnabled = false
        self.animtedWithLineShape(self.topLine, angle: CGFloat(M_PI_4+M_PI_4/5), tx: 0, ty: 4.5, duration: 0.1)
        self.animtedWithLineShape(self.bottomLine, angle: CGFloat(M_PI_4*3+M_PI_4/5), tx: 0, ty: -4.5, duration: 0.1)
        
        self.animtedWithLineColor(self.topLine, color: UIColor.white, duration: 0.8)
        self.animtedWithLineColor(self.bottomLine, color: UIColor.white, duration: 0.8)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1) {
            self.animtedWithLineShape(self.topLine, angle: 0.0, tx: 0, ty: 4.5, duration: 0.3)
            self.animtedWithLineShape(self.bottomLine, angle: 0.0, tx: 0, ty: -4.5, duration: 0.3)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.4) {
            self.animtedWithLineShape(self.topLine, angle: 0.0, tx: 0, ty: 3, duration: 0.2)
            self.animtedWithLineShape(self.bottomLine, angle: 0.0, tx: 0, ty: -3, duration: 0.2)
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.6) {
            self.animtedWithLineShape(self.topLine, angle: 0.0, tx: 0, ty: 0, duration: 0.2)
            self.animtedWithLineShape(self.bottomLine, angle: 0.0, tx: 0, ty: 0, duration: 0.2)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.8) {
            self.status = MBMotionHamburgButtonStatus.open
            self.button.isEnabled = true
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        Bundle(for: self.classForCoder).loadNibNamed("MBMotionHamburgButton", owner: self, options: nil)
        
        self.addSubview(self.view)
        self.view.snp.makeConstraints { (make) -> Void in
            make.leading.top.bottom.trailing.equalTo(self)
        }
    }
}

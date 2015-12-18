//
//  MBMotionContentView.swift
//  MBMotion
//
//  Created by Perry on 15/12/3.
//  Copyright © 2015年 MmoaaY. All rights reserved.
//

import UIKit

protocol MBMotionContentViewDelegate {
    func switchButtonPressed(status:MBMotionHamburgButtonStatus)
}

class MBMotionContentView: UIView, MBMotionHamburgButtonDelegate{

    @IBOutlet private var view: UIView!
    @IBOutlet private var button: MBMotionHamburgButton!
    @IBOutlet private var indicatorView: UIView!
    
    @IBOutlet var titleView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var otherItemView: UIView!
    
    @IBOutlet var tableView: UITableView!
    
    var delegate:MBMotionContentViewDelegate?
    
    let tuples:[(imageName:String, title:String)] = [("book_icon","Book"),("box_icon","Box"),("camera_icon","Camera"),("conver_icon","Conversation"),("location_icon","Location"),("lvshop_icon","Louis Vuitton Shop"),("clock_icon","Clock"),("mail_icon","E-Mail"),("paint_icon","Paint")]
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
        
        self.initTableView()
    }
    
    private func initTableView() {
        let cellNib = UINib(nibName: "MBMotionContentTableViewCell", bundle: nil)
        self.tableView.registerNib(cellNib, forCellReuseIdentifier: "MBMotionContentTableViewCell")
        self.tableView.separatorColor = UIColor(red: 74/255, green: 82/255, blue: 90/255, alpha: 1)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func getContentView() -> UIView! {
        return self.view
    }

    func buttonPressed(status:MBMotionHamburgButtonStatus) {
        self.delegate?.switchButtonPressed(status)
        
        self.animatedWithIndicator(status)
        self.animatedWithTitleView(status)
        self.animatedWithOtherItem(status)
        self.animatedWithTableView(status)
        self.animatedWithTableViewCells(status)
    }
    
    private func animatedWithOtherItem (status:MBMotionHamburgButtonStatus) {
        if status == MBMotionHamburgButtonStatus.Open {
            UIView.animateWithDuration(0.3) { () -> Void in
                self.otherItemView.layer.opacity = 0.0
            }
        }else {
            MBTimeUtil.executeAfterDelay(0.5, clurse: { () -> Void in
                UIView.animateWithDuration(0.3) { () -> Void in
                    self.otherItemView.layer.opacity = 1.0 }
            })
        }
    }
    
    private func animatedWithTitleView (status:MBMotionHamburgButtonStatus) {
        
        var transform = CATransform3DIdentity
        if status == MBMotionHamburgButtonStatus.Open {
            transform = CATransform3DMakeTranslation(0, 20.0, 0)
        }else {
            transform = CATransform3DMakeTranslation(0, 0, 0)
        }
        
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = NSValue(CATransform3D: self.titleView.layer.transform)
        animation.toValue = NSValue(CATransform3D: transform)
        animation.duration = 0.8
        
        self.titleView.layer.addAnimation(animation, forKey: "titleview")
        self.titleView.layer.transform = transform
    }
    
    private func animatedWithIndicator (status:MBMotionHamburgButtonStatus) {
        if status == MBMotionHamburgButtonStatus.Open {
            MBTimeUtil.executeAfterDelay(0.6, clurse: { () -> Void in
                UIView.animateWithDuration(0.2) { () -> Void in
                    self.indicatorView.layer.opacity = 1.0
                    self.titleLabel.layer.opacity = 1.0
                }
            })
        }else {
            UIView.animateWithDuration(0.2) { () -> Void in
                self.indicatorView.layer.opacity = 0.0
                self.titleLabel.layer.opacity = 0.0
            }
        }
    }
    
    private func animatedWithTableView (status:MBMotionHamburgButtonStatus) {
        if status == MBMotionHamburgButtonStatus.Open {
            MBTimeUtil.executeAfterDelay(0.4, clurse: { () -> Void in
                UIView.animateWithDuration(0.05*Double(self.tableView.visibleCells.count)+0.5) { () -> Void in
                    self.tableView.layer.opacity = 1.0 }
            })
        }else {
            UIView.animateWithDuration(0.5) { () -> Void in
                self.tableView.layer.opacity = 0.0
            }
        }
    }
    
    private func animatedWithTableViewCells (status:MBMotionHamburgButtonStatus) {
        if status == MBMotionHamburgButtonStatus.Open {
            MBTimeUtil.executeAfterDelay(0.4, clurse: { () -> Void in
                for var i = 0; i < self.tableView.visibleCells.count; i++ {
                    let visibleCell:MBMotionContentTableViewCell = self.tableView.visibleCells[i] as! MBMotionContentTableViewCell
                    visibleCell.animatedWithContent(status, index: i, count: self.tableView.visibleCells.count)
                }
            })
        }else {
            for var i = self.tableView.visibleCells.count-1; i >= 0; i-- {
                let visibleCell:MBMotionContentTableViewCell = self.tableView.visibleCells[i] as! MBMotionContentTableViewCell
                visibleCell.animatedWithContent(status, index: i, count: self.tableView.visibleCells.count)
            }
        }
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.tuples.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 69
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:MBMotionContentTableViewCell? = tableView.dequeueReusableCellWithIdentifier("MBMotionContentTableViewCell") as? MBMotionContentTableViewCell
        if cell == nil {
            cell = MBMotionContentTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "ViewControllerTableViewCell")
        }
        cell?.setContent(self.tuples[indexPath.row])
        return cell!
    }
}

//
//  MBMotionContentView.swift
//  MBMotion
//
//  Created by Perry on 15/12/3.
//  Copyright © 2015年 MmoaaY. All rights reserved.
//

import UIKit
import MBMotion

protocol MBMotionContentViewDelegate {
    func switchButtonPressed(_ status:MBMotionHamburgButtonStatus)
}

class MBMotionContentView: UIView, MBMotionHamburgButtonDelegate{

    @IBOutlet fileprivate var view: UIView!
    @IBOutlet fileprivate var button: MBMotionHamburgButton!
    @IBOutlet fileprivate var indicatorView: UIView!
    
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
        super.init(frame: CGRect.zero)
        Bundle(for: self.classForCoder).loadNibNamed("MBMotionContentView", owner: self, options: nil)
        self.button.delegate = self
        
        self.initTableView()
    }
    
    fileprivate func initTableView() {
        let cellNib = UINib(nibName: "MBMotionTableViewCell", bundle: Bundle(for: MBMotionTableViewCell.classForCoder()))
        self.tableView.register(cellNib, forCellReuseIdentifier: "MBMotionTableViewCell")
        self.tableView.separatorColor = UIColor(red: 74/255, green: 82/255, blue: 90/255, alpha: 1)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func getContentView() -> UIView! {
        return self.view
    }

    func buttonPressed(_ status:MBMotionHamburgButtonStatus) {
        self.delegate?.switchButtonPressed(status)
        
        self.animatedWithIndicator(status)
        self.animatedWithTitleView(status)
        self.animatedWithOtherItem(status)
        self.animatedWithTableView(status)
        self.animatedWithTableViewCells(status)
    }
    
    fileprivate func animatedWithOtherItem (_ status:MBMotionHamburgButtonStatus) {
        if status == MBMotionHamburgButtonStatus.open {
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.otherItemView.layer.opacity = 0.0
            }) 
        }else {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.otherItemView.layer.opacity = 1.0 })
            }
        }
    }
    
    fileprivate func animatedWithTitleView (_ status:MBMotionHamburgButtonStatus) {
        
        var transform = CATransform3DIdentity
        if status == MBMotionHamburgButtonStatus.open {
            transform = CATransform3DMakeTranslation(0, 20.0, 0)
        }else {
            transform = CATransform3DMakeTranslation(0, 0, 0)
        }
        
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = NSValue(caTransform3D: self.titleView.layer.transform)
        animation.toValue = NSValue(caTransform3D: transform)
        animation.duration = 0.8
        
        self.titleView.layer.add(animation, forKey: "titleview")
        self.titleView.layer.transform = transform
    }
    
    fileprivate func animatedWithIndicator (_ status:MBMotionHamburgButtonStatus) {
        if status == MBMotionHamburgButtonStatus.open {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.6) {
                UIView.animate(withDuration: 0.2, animations: { () -> Void in
                    self.indicatorView.layer.opacity = 1.0
                    self.titleLabel.layer.opacity = 1.0
                })
            }
        }else {
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.indicatorView.layer.opacity = 0.0
                self.titleLabel.layer.opacity = 0.0
            }) 
        }
    }
    
    fileprivate func animatedWithTableView (_ status:MBMotionHamburgButtonStatus) {
        if status == MBMotionHamburgButtonStatus.open {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.4) {
                UIView.animate(withDuration: 0.05*Double(self.tableView.visibleCells.count)+0.5, animations: { () -> Void in
                    self.tableView.layer.opacity = 1.0 })
            }
        }else {
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.tableView.layer.opacity = 0.0
            }) 
        }
    }
    
    fileprivate func animatedWithTableViewCells (_ status:MBMotionHamburgButtonStatus) {
        if status == MBMotionHamburgButtonStatus.open {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.4) {
                for i in 0..<self.tableView.visibleCells.count {
                    let visibleCell:MBMotionTableViewCell = self.tableView.visibleCells[i] as! MBMotionTableViewCell
                    visibleCell.animatedWithContent(status, index: i, count: self.tableView.visibleCells.count)
                }
            }
        }else {
            for i in 0..<self.tableView.visibleCells.count {
                let visibleCell:MBMotionTableViewCell = self.tableView.visibleCells[self.tableView.visibleCells.count-1-i] as! MBMotionTableViewCell
                visibleCell.animatedWithContent(status, index: self.tableView.visibleCells.count-1-i, count: self.tableView.visibleCells.count)
            }
        }
    }

    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.tuples.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 69
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        var cell:MBMotionTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "MBMotionTableViewCell") as? MBMotionTableViewCell
        if cell == nil {
            cell = MBMotionTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "ViewControllerTableViewCell")
        }
        let content = MBMotionTableViewCellContentView()
        content.setContent(self.tuples[indexPath.row])
        cell?.setContent(content)
        return cell!
    }
}

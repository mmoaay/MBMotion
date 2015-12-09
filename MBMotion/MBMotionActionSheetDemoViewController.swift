//
//  MBMotionActionSheetDemoViewController.swift
//  MBMotion
//
//  Created by Perry on 15/12/7.
//  Copyright © 2015年 MmoaaY. All rights reserved.
//

import UIKit

class MBMotionActionSheetDemoViewController: UIViewController,MBMotionContentViewDelegate {
    
    var actionSheet:MBMotionActionSheet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let contentView = MBMotionContentView()
        self.actionSheet = MBMotionActionSheet(containerView: self.navigationController?.view, contentView: contentView.getContentView())
        contentView.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.actionSheet?.removeActionSheet()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func switchButtonPressed(status:MBMotionHamburgButtonStatus) {
        if MBMotionHamburgButtonStatus.Open == status {
            self.actionSheet?.expandActionSheet()
        } else {
            self.actionSheet?.collapseActionSheet()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

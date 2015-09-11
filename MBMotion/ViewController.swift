//
//  ViewController.swift
//  MBMotion
//
//  Created by Perry on 15/9/7.
//  Copyright (c) 2015年 MmoaaY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var actionSheet:MBMotionActionSheet?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var label:UILabel = UILabel()
        label.text = "Content"
        label.textColor = UIColor.whiteColor()
        label.textAlignment = NSTextAlignment.Center
        self.actionSheet = MBMotionActionSheet(containerView: self.view, contentView: label)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showPressed(sender: AnyObject) {
        self.actionSheet?.showActionSheet()
    }

}


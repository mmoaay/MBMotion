//
//  ViewController.swift
//  MBMotion
//
//  Created by Perry on 15/9/7.
//  Copyright (c) 2015年 MmoaaY. All rights reserved.
//

import UIKit

class ViewController: UIViewController,MBTableHeaderViewDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var headImageView: UIImageView!
    
    var items = ["MBMotionActionSheet"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func swiftGGPressed() {
        self.performSegueWithIdentifier("fromHomeToWeb", sender: nil)
    }
    
    func initTableView(){
        let tableHeaderView = MBTableHeaderView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.width))
        tableHeaderView.delegate = self
        self.tableView.tableHeaderView = tableHeaderView
        
        self.parallelHeaderView = headImageView
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.items.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("fromHomeTo"+self.items[indexPath.row], sender: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("ViewControllerTableViewCell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "ViewControllerTableViewCell")
        }
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        cell?.textLabel?.text = self.items[indexPath.row]
        cell?.textLabel?.font = UIFont(name: "Futura", size: 16)
        return cell!
    }

}


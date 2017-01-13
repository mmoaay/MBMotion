//
//  ViewController.swift
//  MBMotion
//
//  Created by Perry on 15/9/7.
//  Copyright (c) 2015年 MmoaaY. All rights reserved.
//

import UIKit
import MBMotion

class ViewController: UIViewController,MBTableHeaderViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    var items = ["MBMotionActionSheet", "MBEyeLoading"]
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
        self.performSegue(withIdentifier: "fromHomeToWeb", sender: nil)
    }
    
    func initTableView(){
        let tableHeaderView = MBTableHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
        tableHeaderView.delegate = self
        self.tableView.tableHeaderView = tableHeaderView
    }

    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        self.performSegue(withIdentifier: "fromHomeTo"+self.items[indexPath.row], sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "ViewControllerTableViewCell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "ViewControllerTableViewCell")
        }
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        cell?.textLabel?.text = self.items[indexPath.row]
        cell?.textLabel?.font = UIFont(name: "Futura", size: 16)
        return cell!
    }

}


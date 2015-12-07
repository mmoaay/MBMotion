//
//  MBMotionWebViewController.swift
//  MBMotion
//
//  Created by Perry on 15/12/7.
//  Copyright © 2015年 MmoaaY. All rights reserved.
//

import UIKit

class MBMotionWebViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://swift.gg/")!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

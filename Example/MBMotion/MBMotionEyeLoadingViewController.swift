//
//  MBMotionEyeLoadingViewController.swift
//  MBMotion
//
//  Created by ZhengYidong on 12/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import MBMotion
import SnapKit

class MBMotionEyeLoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let eye = MBEyeLoading()
        view.addSubview(eye)
        
        eye.snp.makeConstraints { (make:ConstraintMaker) in
            make.edges.equalTo(view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

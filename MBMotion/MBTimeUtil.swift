//
//  MBTimeUtil.swift
//  MBMotion
//
//  Created by Perry on 15/12/4.
//  Copyright © 2015年 MmoaaY. All rights reserved.
//

import UIKit

class MBTimeUtil: NSObject {
    
    static func executeAfterDelay(delayTime:NSTimeInterval,clurse:() -> Void
        ){
            let delay = dispatch_time(DISPATCH_TIME_NOW,
                Int64(delayTime * Double(NSEC_PER_SEC)))
            dispatch_after(delay, dispatch_get_main_queue()) {
                clurse()
            }
    }
}

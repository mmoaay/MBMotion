//
//  MBTimeUtil.swift
//  MBMotion
//
//  Created by Perry on 15/12/4.
//  Copyright © 2015年 MmoaaY. All rights reserved.
//

import UIKit

public class MBTimeUtil: NSObject {
    
    public static func executeAfterDelay(_ delayTime:TimeInterval,clurse:@escaping () -> Void
        ){
            let delay = DispatchTime.now() + Double(Int64(delayTime * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delay) {
                clurse()
            }
    }
}

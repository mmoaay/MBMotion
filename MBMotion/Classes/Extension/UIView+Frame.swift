//
//  UIViewFrameExtension.swift
//  MBMotion
//
//  Created by Perry on 15/9/11.
//  Copyright (c) 2015年 MmoaaY. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    var x:CGFloat {
        get{
            return frame.origin.x
        }
        set{
            var f = frame
            f.origin.x = newValue
            frame = f
        }
    }
    var y:CGFloat {
        get{
            return frame.origin.y
        }
        set{
            var f = frame
            f.origin.y = newValue
            frame = f
        }
    }
    var width:CGFloat {
        get{
            return frame.size.width
        }
        set{
            var f = frame
            f.size.width = newValue
            frame = f
        }
    }
    var height:CGFloat {
        get{
            return frame.size.height
        }
        set{
            var f = frame
            f.size.height = newValue
            frame = f
        }
    }
}

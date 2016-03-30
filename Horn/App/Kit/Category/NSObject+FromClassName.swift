//
//  NSObject+FromClassName.swift
//  Horn
//
//  Created by Thierry on 16/3/30.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    
    class func fromClassName(className : String) -> NSObject {
        let className = NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String + "." + className
        let aClass = NSClassFromString(className) as! UIViewController.Type
        return aClass.init()
    }
    
}

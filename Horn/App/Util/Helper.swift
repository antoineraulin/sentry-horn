//
//  Helper.swift
//  Horn
//
//  Created by Thierry on 16/3/7.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import Foundation

class Helper {
    
    class func stringToDate(dateStr:String) -> NSDate{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.dateFromString(dateStr)
        return date!
    }
    
}
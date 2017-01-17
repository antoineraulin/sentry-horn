//
//  CookieSyncManger.swift
//  Horn
//
//  Created by Thierry on 2017/1/17.
//  Copyright © 2017年 Thierry. All rights reserved.
//

import Foundation
import WebKit

private let shareInstance = CookieSyncManger()

class CookieSyncManger {
    
    let processPool = WKProcessPool()
    
    class var sharedInstance: CookieSyncManger {
        return shareInstance
    }

}

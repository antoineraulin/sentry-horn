//
//  SettingsObject.swift
//  Horn
//
//  Created by Thierry on 16/3/8.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import Foundation

class SimpleObject: BaseObject {
    
    var title:String = ""
    var detail:String = ""
    var viewController:String = ""
    
    convenience init(title:String){
        self.init()
        self.title = title
    }
    
    convenience init(title:String, detail:String){
        self.init()
        self.title = title
        self.detail = detail
    }
    
    convenience init(title:String, viewController:String){
        self.init()
        self.title = title
        self.viewController = viewController
    }
    
}
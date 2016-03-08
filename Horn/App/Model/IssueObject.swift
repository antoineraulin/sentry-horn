//
//  IssueObject.swift
//  Horn
//
//  Created by Thierry on 16/3/6.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import Foundation

class IssueObject: BaseObject {
    var id:String = ""
    var project:ProjectObject = ProjectObject()
    var status:String = ""
    var title:String = ""
    var count:Int = 0
    var culprit:String = ""
    var level:String = ""
    var isBookmarked:Bool = false
    var isPublic:Bool = false
    var userCount:Int = 0
    var firstSeen:String = ""
    var lastSeen:String = ""
    var permalink:String = ""
}
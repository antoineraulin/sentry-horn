//
//  DashboardObject.swift
//  Achilles
//
//  Created by Thierry on 15/12/25.
//  Copyright © 2015年 Thierry. All rights reserved.
//

import Foundation

class ProjectObject : BaseObject
{
    var slug:String = ""
    var features:[String] = []
    var isPublic:Bool = false
    var isBookmarked:Bool = false
    var firstEvent:String = ""
    var team:TeamObject = TeamObject()
    var dateCreated:String = ""
    var id:String = ""
    var name:String = ""
}
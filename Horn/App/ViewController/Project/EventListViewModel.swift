//
//  EventListViewModel.swift
//  Horn
//
//  Created by Thierry on 16/3/7.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import Foundation

class EventListViewModel: BaseListViewModel {
    
    var _dataArray = Array<IssueObject>()
    var statsPeriod = "24h"
    var query = "is:unresolved"
    var limit = 25
    var project_slug = ""
    
    override var dataArray: Array<BaseObject> {
        get {
            return _dataArray
        }
        set {
            super.dataArray = newValue
        }
    }
    
    override func buildData(data: String) {
        _dataArray += [IssueObject](json: data)
    }
    
    override func buildParams() {
        self.params = ["statsPeriod":statsPeriod,"query":query, "limit":limit, "cursor":cursor];
    }
    
    override func clearData() {
        super.clearData()
        _dataArray.removeAll()
    }
    
    override func buildRemoteUrl() {
        remoteUrl = String(format:Constants.API.Events, project_slug)
    }
    
    func titleAtIndexPath(indexPath: NSIndexPath) -> String {
        let issue: IssueObject = _dataArray[indexPath.row]
        return issue.culprit
    }
    
    func detailAtIndexPath(indexPath: NSIndexPath) -> String {
        let issue: IssueObject = _dataArray[indexPath.row]
        return issue.title
    }
    
    func flagAtIndexPath(indexPath: NSIndexPath) -> String {
        let issue: IssueObject = _dataArray[indexPath.row]
        return "Events:\(issue.count)  Users:\(issue.userCount)"
    }
    
    func timeAtIndexPath(indexPath: NSIndexPath) -> String {
        let issue: IssueObject = _dataArray[indexPath.row]
        let firstSeen = timeAgoSince(Helper.stringToDate(issue.firstSeen))
        let lastSeen = timeAgoSince(Helper.stringToDate(issue.lastSeen))
        return "\(lastSeen) - \(firstSeen)"
    }
    
    func levelColorAtIndexPath(indexPath: NSIndexPath) -> String {
        let issue: IssueObject = _dataArray[indexPath.row]
        if issue.level == "error"{
            return Color.LevelError
        }else if issue.level == "info"{
            return Color.LevelInfo
        }else if issue.level == "warning"{
            return Color.LevelWarning
        }else{
            return Color.LevelDefault
        }
    }
    
    func permalinkAtIndexPath(indexPath: NSIndexPath) -> String {
        let issue: IssueObject = _dataArray[indexPath.row]
        return issue.permalink
    }
}

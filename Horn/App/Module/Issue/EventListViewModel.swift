//
//  EventListViewModel.swift
//  Horn
//
//  Created by Thierry on 16/3/7.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import Foundation

class EventListViewModel: BaseListViewModel {
    
    var statsPeriod = "24h"
    var query = "is:unresolved"
    var limit = 25
    var project_slug = ""
    
    convenience init(project_slug:String) {
        self.init()
        self.project_slug = project_slug
    }
    
    override func buildData(data: String) {
        dataArray = dataArray + [IssueObject](json: data)
    }
    
    override func buildParams() {
        self.params = ["statsPeriod":statsPeriod,"query":query, "limit":limit, "cursor":cursor];
    }
    
    override func buildRemoteUrl() {
        remoteUrl = String(format:Constants.API.Events, project_slug)
    }
    
    func titleAtIndexPath(indexPath: NSIndexPath) -> String {
        let issue: IssueObject = dataArray[indexPath.row] as! IssueObject
        return issue.culprit
    }
    
    func detailAtIndexPath(indexPath: NSIndexPath) -> String {
        let issue: IssueObject = dataArray[indexPath.row] as! IssueObject
        return issue.title
    }
    
    func flagAtIndexPath(indexPath: NSIndexPath) -> String {
        let issue: IssueObject = dataArray[indexPath.row] as! IssueObject
        return "Events:\(issue.count)  Users:\(issue.userCount)"
    }
    
    func timeAtIndexPath(indexPath: NSIndexPath) -> String {
        let issue: IssueObject = dataArray[indexPath.row] as! IssueObject
        let firstSeen = timeAgoSince(Helper.stringToDate(issue.firstSeen))
        let lastSeen = timeAgoSince(Helper.stringToDate(issue.lastSeen))
        return "\(lastSeen) - \(firstSeen)"
    }
    
    func levelColorAtIndexPath(indexPath: NSIndexPath) -> String {
        let issue: IssueObject = dataArray[indexPath.row] as! IssueObject
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
        let issue: IssueObject = dataArray[indexPath.row]  as! IssueObject
        return issue.permalink
    }
}

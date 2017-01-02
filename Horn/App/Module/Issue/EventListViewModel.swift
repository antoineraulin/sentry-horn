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
    
    override func buildData(_ data: String) {
        dataArray = dataArray + [IssueObject](json: data)
    }
    
    override func buildParams() {
        self.params = ["statsPeriod":statsPeriod as AnyObject,"query":query as AnyObject, "limit":limit as AnyObject, "cursor":cursor as AnyObject];
    }
    
    override func buildRemoteUrl() {
        remoteUrl = String(format:Constants.API.Events, project_slug)
    }
    
    func titleAtIndexPath(_ indexPath: IndexPath) -> String {
        let issue: IssueObject = dataArray[indexPath.row] as! IssueObject
        return issue.culprit
    }
    
    func detailAtIndexPath(_ indexPath: IndexPath) -> String {
        let issue: IssueObject = dataArray[indexPath.row] as! IssueObject
        return issue.title
    }
    
    func flagAtIndexPath(_ indexPath: IndexPath) -> String {
        let issue: IssueObject = dataArray[indexPath.row] as! IssueObject
        return "Events:\(issue.count)  Users:\(issue.userCount)"
    }
    
    func timeAtIndexPath(_ indexPath: IndexPath) -> String {
        let issue: IssueObject = dataArray[indexPath.row] as! IssueObject
        let firstSeen = timeAgoSince(Helper.stringToDate(issue.firstSeen))
        let lastSeen = timeAgoSince(Helper.stringToDate(issue.lastSeen))
        return "\(lastSeen) - \(firstSeen)"
    }
    
    func levelColorAtIndexPath(_ indexPath: IndexPath) -> String {
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
    
    func permalinkAtIndexPath(_ indexPath: IndexPath) -> String {
        let issue: IssueObject = dataArray[indexPath.row]  as! IssueObject
        return issue.permalink
    }
}

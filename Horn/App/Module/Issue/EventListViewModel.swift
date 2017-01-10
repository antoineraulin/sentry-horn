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
    var projectSlug = ""
    
    convenience init(projectSlug:String) {
        self.init()
        self.projectSlug = projectSlug
    }
    
    override func buildData(_ data: String) {
        dataArray = dataArray + [IssueObject](json: data)
    }
    
    override func buildParamters() -> [String: Any] {
        return ["statsPeriod":statsPeriod,"query":query, "limit":limit, "cursor":cursor]
    }
    
    override func buildAPI() -> GMNetWorkingAPI {
        return GMNetWorkingAPI.issues(projectSlug: projectSlug)
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
            return Color.levelError
        }else if issue.level == "info"{
            return Color.levelInfo
        }else if issue.level == "warning"{
            return Color.levelWarning
        }else{
            return Color.levelDefault
        }
    }
    
    func permalinkAtIndexPath(_ indexPath: IndexPath) -> String {
        let issue: IssueObject = dataArray[indexPath.row]  as! IssueObject
        return issue.permalink
    }
}

//
//  DashboardViewModel.swift
//  Horn
//
//  Created by Thierry on 16/3/5.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import Foundation

class DashboardViewModel: BaseListViewModel {
    
    var type = "Assigned"
    var statsPeriod = "24h"
    var per_page = 5
    var status = "unresolved"
    
    convenience init(type:String){
        self.init()
        self.type = type
    }
    
    override func buildParams() {
        self.params = ["cursor": cursor as AnyObject,"statsPeriod":statsPeriod as AnyObject,"per_page":per_page as AnyObject,"status":status as AnyObject];
    }
    
    override func buildData(_ data: String) {
        dataArray = [IssueObject](json: data)
    }
    
    override func buildRemoteUrl() {
        if type == "Assigned"{
            remoteUrl = Constants.API.Assigned
        }else{
            remoteUrl = Constants.API.New
        }
    }
    
    func nameAtIndexPath(_ indexPath: IndexPath) -> String {
        let issue: IssueObject = dataArray[indexPath.row] as! IssueObject
        return issue.title
    }
    
    func detailAtIndexPath(_ indexPath: IndexPath) -> String {
        let issue: IssueObject = dataArray[indexPath.row] as! IssueObject
        return "[\(issue.project.name)] \(issue.culprit)"
    }
    
    func permalinkAtIndexPath(_ indexPath: IndexPath) -> String {
        let issue: IssueObject = dataArray[indexPath.row] as! IssueObject
        return issue.permalink
    }
    
}

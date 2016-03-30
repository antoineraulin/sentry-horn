//
//  IssueViewModel.swift
//  Horn
//
//  Created by Thierry on 16/3/30.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import Foundation
class IssueViewModel: BaseListViewModel {
    
    override func fetchRemoteData() {
        dataArray = [SimpleObject(title: "Assigned To Me", viewController: "AssignedToMeViewController"),
                     SimpleObject(title: "Bookmarks", viewController: "BookmarksViewController"),
                     SimpleObject(title: "History", viewController: "HistoryViewController")]
        self.fetchDataResult.value = FetchDataResult.Success.rawValue
    }
    
    func titleAtIndexPath(indexPath: NSIndexPath) -> String {
        let object:SimpleObject = dataArray[indexPath.row] as! SimpleObject
        return object.title
    }
    
    func detailAtIndexPath(indexPath: NSIndexPath) -> String {
        let object:SimpleObject = dataArray[indexPath.row] as! SimpleObject
        return object.detail
    }
    
    func viewControllerAtIndexPath(indexPath: NSIndexPath) -> String{
        let object:SimpleObject = dataArray[indexPath.row] as! SimpleObject
        return object.viewController
    }
    
}
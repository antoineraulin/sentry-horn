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
        self.fetchDataResult.value = FetchDataResult.success.rawValue
    }
    
    func titleAtIndexPath(_ indexPath: IndexPath) -> String {
        let object:SimpleObject = dataArray[indexPath.row] as! SimpleObject
        return object.title
    }
    
    func detailAtIndexPath(_ indexPath: IndexPath) -> String {
        let object:SimpleObject = dataArray[indexPath.row] as! SimpleObject
        return object.detail
    }
    
    func viewControllerAtIndexPath(_ indexPath: IndexPath) -> String{
        let object:SimpleObject = dataArray[indexPath.row] as! SimpleObject
        return object.viewController
    }
    
}

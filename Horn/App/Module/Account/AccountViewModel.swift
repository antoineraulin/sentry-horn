//
//  SettingsViewModel.swift
//  Horn
//
//  Created by Thierry on 16/3/8.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import Foundation

class AccountViewModel: BaseListViewModel {
    
    override func fetchRemoteData() {
        dataArray = [SimpleObject(title: "Sign out", detail: "")]
        self.fetchDataResult.value = FetchDataResult.Success.rawValue
    }
    
    func titleAtIndexPath(indexPath: NSIndexPath) -> String {
        let settings:SimpleObject = dataArray[indexPath.row] as! SimpleObject
        return settings.title
    }
    
    func detailAtIndexPath(indexPath: NSIndexPath) -> String {
        let settings:SimpleObject = dataArray[indexPath.row] as! SimpleObject
        return settings.detail
    }
    
}
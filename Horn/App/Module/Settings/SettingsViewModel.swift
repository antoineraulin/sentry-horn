//
//  SettingsViewModel.swift
//  Horn
//
//  Created by Thierry on 16/3/8.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import Foundation

class SettingsViewModel:BaseListViewModel {
    
    var _dataArray = Array<SettingsObject>()
    
    override func fetchRemoteData() {
        _dataArray = [SettingsObject(title: "Sign out", detail: "")]
        dataArray.append(BaseObject())
        self.fetchDataResult.value = FetchDataResult.Success.rawValue
    }
    
    func titleAtIndexPath(indexPath: NSIndexPath) -> String {
        let settings:SettingsObject = _dataArray[indexPath.row]
        return settings.title
    }
    
    func detailAtIndexPath(indexPath: NSIndexPath) -> String {
        let settings: SettingsObject = _dataArray[indexPath.row]
        return settings.detail
    }
    
}
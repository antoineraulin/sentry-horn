//
//  OrgnaizationListViewModel.swift
//  Horn
//
//  Created by Thierry on 16/3/6.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import Foundation

class OrganizationListViewModel: BaseListViewModel {
    
    var _dataArray = Array<OrganizationObject>()
    override var dataArray: Array<BaseObject> {
        get {
            return _dataArray
        }
        set {
            super.dataArray = newValue
        }
    }
    
    override func buildData(data: String) {
        _dataArray = [OrganizationObject](json: data)
    }
    
    override func clearData() {
        super.clearData()
        _dataArray.removeAll()
    }
    
    override func buildRemoteUrl() {
        remoteUrl = Constants.API.Organizations
    }
    
    func nameAtIndexPath(indexPath: NSIndexPath) -> String {
        let organization: OrganizationObject = _dataArray[indexPath.row]
        return organization.name
    }
    
    func detailAtIndexPath(indexPath: NSIndexPath) -> String {
        let organization: OrganizationObject = _dataArray[indexPath.row]
        return organization.dateCreated
    }
    
    func slugAtIndexPath(indexPath: NSIndexPath) -> String {
        let organization: OrganizationObject = _dataArray[indexPath.row]
        return organization.slug
    }
}

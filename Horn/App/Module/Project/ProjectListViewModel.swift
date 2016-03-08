//
//  ProjectViewModel.swift
//  Horn
//
//  Created by Thierry on 16/3/5.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import Foundation

class ProjectListViewModel: BaseListViewModel {
    
    var _dataArray = Array<ProjectObject>()
    override var dataArray: Array<BaseObject> {
        get {
            return _dataArray
        }
        set {
            super.dataArray = newValue
        }
    }
    
    override func buildData(data: String) {
        _dataArray = [ProjectObject](json: data)
    }
    
    override func clearData() {
        super.clearData()
        _dataArray.removeAll()
    }
    
    override func buildRemoteUrl() {
        remoteUrl = Constants.API.Projects
    }
    
    func nameAtIndexPath(indexPath: NSIndexPath) -> String {
        let project: ProjectObject = _dataArray[indexPath.row]
        return project.name
    }
    
    func slugAtIndexPath(indexPath: NSIndexPath) -> String {
        let project: ProjectObject = _dataArray[indexPath.row]
        return project.slug
    }
    
    func detailAtIndexPath(indexPath: NSIndexPath) -> String {
        let project: ProjectObject = _dataArray[indexPath.row]
        return project.team.name
    }
    
}
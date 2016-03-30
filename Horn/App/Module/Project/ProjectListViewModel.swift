//
//  ProjectViewModel.swift
//  Horn
//
//  Created by Thierry on 16/3/5.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import Foundation

class ProjectListViewModel: BaseListViewModel {
    
    override func buildData(data: String) {
        dataArray = [ProjectObject](json: data)
    }

    override func buildRemoteUrl() {
        remoteUrl = Constants.API.Projects
    }
    
    func nameAtIndexPath(indexPath: NSIndexPath) -> String {
        let project: ProjectObject = dataArray[indexPath.row] as! ProjectObject
        return project.name
    }
    
    func slugAtIndexPath(indexPath: NSIndexPath) -> String {
        let project: ProjectObject = dataArray[indexPath.row] as! ProjectObject
        return project.slug
    }
    
    func detailAtIndexPath(indexPath: NSIndexPath) -> String {
        let project: ProjectObject = dataArray[indexPath.row] as! ProjectObject
        return project.team.name
    }
    
}
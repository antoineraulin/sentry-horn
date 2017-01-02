//
//  ProjectViewModel.swift
//  Horn
//
//  Created by Thierry on 16/3/5.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import Foundation

class ProjectListViewModel: BaseListViewModel {
    
    override func buildData(_ data: String) {
        dataArray = [ProjectObject](json: data)
    }

    override func buildRemoteUrl() {
        remoteUrl = Constants.API.Projects
    }
    
    func nameAtIndexPath(_ indexPath: IndexPath) -> String {
        let project: ProjectObject = dataArray[indexPath.row] as! ProjectObject
        return project.name
    }
    
    func slugAtIndexPath(_ indexPath: IndexPath) -> String {
        let project: ProjectObject = dataArray[indexPath.row] as! ProjectObject
        return project.slug
    }
    
    func detailAtIndexPath(_ indexPath: IndexPath) -> String {
        let project: ProjectObject = dataArray[indexPath.row] as! ProjectObject
        return project.team.name
    }
    
}

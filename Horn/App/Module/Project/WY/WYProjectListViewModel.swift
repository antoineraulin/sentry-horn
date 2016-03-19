//
//  ProjectViewModel.swift
//  Horn
//
//  Created by Thierry on 16/3/5.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import Foundation

final class WYProjectListViewModel: FetchViewModel {

    required init() {
        super.init()
        url = Constants.API.Projects
    }

    override func clearData() {
        super.clearData()
        dataArray.removeAll()
    }

    override func buildData(jsonString json: String) {

        dataArray = [ProjectObject](json: json)
    }

    func nameAtIndexPath(indexPath: NSIndexPath) -> String {
        return objectAtIndexPath(indexPath).name
    }
    
    func slugAtIndexPath(indexPath: NSIndexPath) -> String {
        return objectAtIndexPath(indexPath).slug
    }
    
    func detailAtIndexPath(indexPath: NSIndexPath) -> String {
        return objectAtIndexPath(indexPath).team.name
    }

    func objectAtIndexPath(indexPath: NSIndexPath) -> ProjectObject {
        let project = self.dataArray[indexPath.row] as! ProjectObject
        return project
    }
}
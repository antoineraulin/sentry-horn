//
//  BookmarksViewModel.swift
//  Horn
//
//  Created by Thierry on 16/3/30.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import Foundation

class BookmarksViewModel: EventListViewModel {
    
    let per_page = 25
    
    override func buildParams() {
        self.params = ["statsPeriod":statsPeriod as AnyObject, "per_page":per_page as AnyObject, "cursor":cursor as AnyObject];
    }
    
    override func buildRemoteUrl() {
        remoteUrl = Constants.API.Bookmarks
    }
    
}

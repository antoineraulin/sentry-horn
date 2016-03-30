//
//  HistoryViewModel.swift
//  Horn
//
//  Created by Thierry on 16/3/30.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import Foundation

class HistoryViewModel: EventListViewModel {
    
    let per_page = 25
    
    override func buildParams() {
        self.params = ["statsPeriod":statsPeriod, "per_page":per_page, "cursor":cursor];
    }
    
    override func buildRemoteUrl() {
        remoteUrl = Constants.API.History
    }
    
}
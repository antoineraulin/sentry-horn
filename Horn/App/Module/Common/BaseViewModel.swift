//
//  BaseViewModel.swift
//  Achilles
//
//  Created by Thierry on 9/4/15.
//  Copyright (c) 2015 Thierry. All rights reserved.
//

import Foundation


enum FetchDataResult: Int {
    case Normal = -1
    case Success = 0
    case Failed = 1
}

class BaseViewModel: NSObject {

    override init() {
        super.init()
    }

}
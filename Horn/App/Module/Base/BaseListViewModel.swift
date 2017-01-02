//
//  BaseDataViewModel.swift
//  Achilles
//
//  Created by Thierry on 15/12/28.
//  Copyright © 2015年 Thierry. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Observable

enum FetchDataResult: Int {
    case normal = -1
    case success = 0
    case failed = 1
}

class BaseListViewModel: NSObject {

    var remoteUrl = ""
    var message = ""
    var params: [String:AnyObject]?
    var page = 1
    var cursor = ""
    var dataArray: Array<BaseObject> = Array<BaseObject>()
    var fetchDataResult = Observable(FetchDataResult.normal.rawValue)

    func fetchRemoteData() {
        self.buildRemoteUrl()
        self.buildParams()
        GMNetService.sharedInstance.startRequestWithUrlString(remoteUrl, params: params!, method: HttpMethod.httpMethodGet, success: {
            response in
            if (self.remoteUrl == "") {
                self.fetchDataResult.value = FetchDataResult.failed.rawValue
                return
            }
            if self.shouldClearDataForResponse(response) {
                self.clearData()
            }
            let headers = response.response?.allHeaderFields
            self.parseLink(headers!)
            
            let json = JSON(response.result.value!)
            self.buildData(json.rawString()!)
            self.fetchDataResult.value = FetchDataResult.success.rawValue
        }, failed: {
            errorMsg in
            self.fetchDataResult.value = FetchDataResult.failed.rawValue
        })
    }

    func buildParams() {
        self.params = ["cursor":cursor as AnyObject]
    }

    func handleHeaderRefreshing() {
        self.page = 1
        self.cursor = ""
        self.fetchRemoteData()
    }
    
    func handleFooterRereshing() {
        self.page = self.page + 1
        self.fetchRemoteData()
    }

    func shouldClearDataForResponse(_ response: DataResponse<Any>) -> Bool {
        return self.page == 1;
    }

    func clearData() {
        dataArray.removeAll()
    }
    
    func buildData(_ data: String) {
        fatalError("buildData need override by subclass")
    }
    
    func buildRemoteUrl() {
        fatalError("buildRemoteUrl need override by subclass")
    }
    
    /**
     Parse Link and get next page's cursor
     
     - parameter headers: Http Header
     */
    func parseLink(_ headers: [AnyHashable: Any]){
        if (headers["Link"] != nil) {
            let link:String = headers["Link"] as! String
            let array:[String] = link.components(separatedBy: "=")
            cursor = (array.last?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).replacingOccurrences(of: "\"", with: ""))!
        }
    }
}

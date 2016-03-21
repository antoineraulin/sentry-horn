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
    case Normal = -1
    case Success = 0
    case Failed = 1
}

class BaseListViewModel: NSObject {

    var remoteUrl = ""
    var message = ""
    var params: [String:AnyObject]?
    var page = 1
    var dataArray: Array<BaseObject> = Array<BaseObject>()
    var fetchDataResult = Observable(FetchDataResult.Normal.rawValue)
    var cursor = ""

    func fetchRemoteData() {
        self.buildRemoteUrl()
        self.buildParams()
        GMNetService.sharedInstance.startRequestWithUrlString(remoteUrl, params: params!, method: HttpMethod.HttpMethodGet, success: {
            response in
            
            if (self.remoteUrl == "") {
                self.fetchDataResult.value = FetchDataResult.Failed.rawValue
                return
            }
            
            if self.shouldClearDataForResponse(response) {
                self.clearData()
            }
            
            let headers = response.response?.allHeaderFields
            self.parseLink(headers!)
            
            let json = JSON(response.result.value!)
            self.buildData(json.rawString()!)
            self.fetchDataResult.value = FetchDataResult.Success.rawValue
        }, failed: {
            errorMsg in
            self.fetchDataResult.value = FetchDataResult.Failed.rawValue
        })
    }

    func buildParams() {
        self.params = ["cursor":cursor]
    }

    func handleHeaderRefreshing() {
        self.page = 1
        self.fetchRemoteData()
    }
    
    func handleFooterRereshing() {
        self.page = self.page + 1
        self.fetchRemoteData()
    }

    func shouldClearDataForResponse(response: Response<AnyObject, NSError>) -> Bool {
        return self.page == 1;
    }

    func clearData() {
    }
    
    func buildData(data: String) {
        fatalError("buildData need override by subclass")
    }
    
    func buildRemoteUrl() {
//        fatalError("buildRemoteUrl need override by subclass")
    }
    
    func parseLink(headers: [NSObject : AnyObject]){
        if (headers["Link"] != nil) {
            let link:String = headers["Link"] as! String
            let array:[String] = link.componentsSeparatedByString("=")
            cursor = (array.last?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).stringByReplacingOccurrencesOfString("\"", withString: ""))!
        }
    }
}
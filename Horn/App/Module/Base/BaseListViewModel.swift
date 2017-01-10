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
    
    var message = ""
    var api: GMNetWorkingAPI!
    var page = 1
    var cursor = ""
    var dataArray: Array<BaseObject> = Array<BaseObject>()
    var fetchDataResult = Observable(FetchDataResult.normal.rawValue)
    
    func fetchRemoteData() {
        GMNetWorking.doRequest(buildAPI(), extraParameters: buildParamters(), success: { moyaResponse in
            if self.shouldClearDataForResponse(moyaResponse) {
                self.clearData()
            }
            if let headers = (moyaResponse.response as? HTTPURLResponse)?.allHeaderFields {
                self.parseLink(headers)
            }
            do {
                let data = try moyaResponse.mapString()
                self.buildData(data)
                self.fetchDataResult.value = FetchDataResult.success.rawValue
            }
            catch {
                self.fetchDataResult.value = FetchDataResult.failed.rawValue
            }
        }, failed: {
            errorMsg in
            self.fetchDataResult.value = FetchDataResult.failed.rawValue
        })
    }
    
    func buildParamters() -> [String: Any] {
        return ["cursor": cursor]
    }
    
    func buildAPI() -> GMNetWorkingAPI {
        return api!
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
    
    func shouldClearDataForResponse(_ response: Any) -> Bool {
        return self.page == 1;
    }
    
    func clearData() {
        dataArray.removeAll()
    }
    
    func buildData(_ data: String) {
        fatalError("buildData need override by subclass")
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

//
//  FetchViewModel.swift
//  test
//
//  Created by wangyang on 16/3/16.
//  Copyright © 2016年 北京更美互动信息科技有限公司. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


typealias FetchRemoteDataFinish = (success: Bool, message: String) -> ()

class FetchViewModel: ViewModelProtocol{

    // TODO:     _deleteCount = 0;

    // property from protocol
    var dataArray: [BaseObject]!
    var url: String!
    var fetchDataErrorMsg: String!
    var fetchDataNilMsg: String!
    var page: Int!
    var cursor: String!
    var parameters = [String: AnyObject]()

    required init() {

        dataArray = [BaseObject]()
        url = ""
        page = 1

        // 这个属性是这个项目特有的
        cursor = ""
    }

    func buildParameters(){
        
    }

    func fetchRemoteData(fetchFinish: FetchRemoteDataFinish) {

        // 参数
        self.buildParameters()

        // 请求网络
        GMNetService.sharedInstance.startRequestWithUrlString(url, params: parameters, method: HttpMethod.HttpMethodGet,
            success: { response in

                if self.shouldClearDataForResponse(response) {
                    self.clearData()
                }

                let headers = response.response?.allHeaderFields
                self.parseLink(headers!)

                let json = JSON(response.result.value!)
                self.buildData(jsonString: json.rawString()!)

                fetchFinish(success: true, message: "")

            },
            failed: { errorMsg in
                fetchFinish(success: false, message: errorMsg)
        })
    }

    func buildData(jsonString json: String) {

    }

    func shouldClearDataForResponse(response: Response<AnyObject, NSError>) -> Bool {
        return page == 0;
    }

    func clearData() {
        page = 1
        dataArray.removeAll()
    }

    func parseLink(headers: [NSObject : AnyObject]){
        if (headers["Link"] != nil) {
            let link:String = headers["Link"] as! String
            let array:[String] = link.componentsSeparatedByString("=")
            cursor = (array.last?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).stringByReplacingOccurrencesOfString("\"", withString: ""))!
        }
    }
}

protocol ViewModelProtocol {

    var dataArray: [BaseObject]! { get set }
    var url: String! { get set }

    // TODO: 新业务，应该所有的msg由服务器返回，这里不需要再构造msg了
    var fetchDataErrorMsg: String! { get set }
    var fetchDataNilMsg: String! { get set }

    // 改成更美的代码
    var page: Int! { get set }
    // 改成更美的代码
    var cursor: String! { get set }

    func fetchRemoteData(fetchFinish: FetchRemoteDataFinish)

    func buildData(jsonString json: String)

    /**
     协议中的构造器要求，必须实现init方法
     */
    init()
}


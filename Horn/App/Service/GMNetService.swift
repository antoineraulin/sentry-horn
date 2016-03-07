//
// Created by Thierry on 16/1/5.
// Copyright (c) 2016 Thierry. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

/** @brief API Status */

enum APIStatusCode: Int {
    case APIStatusCodeSuccess = 0
    case APIStatusCodeEmpty = 1
    case APIStatusCodeFailed = 2
};

/** @brief Http Status */

enum HttpStatusCode: Int {
    case HttpStatusCodeSuccess = 200
    case HttpStatusCodeError = 500
    case HttpStatusCodeUnauthorized = 401
};

/** @brief Http Method */

enum HttpMethod: Int {
    case HttpMethodGet = 0
    case HttpMethodPost
    case HttpMethodPut
    case HttpMethodDelete
    case HttpMethodPatch
};

/** @brief Http Response Result Block */
typealias HttpSuccessBlock = (response:Response<AnyObject, NSError>) -> Void
typealias HttpFailedBlock = (errorMsg:String) -> Void

class GMNetService {

    var apiHost: String = ""
    var urlCommonParameters: String = ""

    static let sharedInstance: GMNetService = {
        return GMNetService()
    }()

    func startRequestWithUrlString(urlString: String,
                                   params: [String:AnyObject],
                                   method: HttpMethod,
                                   success: HttpSuccessBlock,
                                   failed: HttpFailedBlock) {
        let remoteUrl = apiHost + urlString
        switch method {
        case HttpMethod.HttpMethodGet:
            Alamofire.request(.GET, remoteUrl, parameters: params).responseJSON {
                response in
                self.handleWithResponse(response, success: success, failed: failed)
            }
            break
        case HttpMethod.HttpMethodPost:
            Alamofire.request(.POST, remoteUrl, parameters: params).responseJSON {
                response in
                self.handleWithResponse(response, success: success, failed: failed)
            }
            break
        case HttpMethod.HttpMethodDelete:
            Alamofire.request(.DELETE, remoteUrl, parameters: params).responseJSON {
                response in
                self.handleWithResponse(response, success: success, failed: failed)
            }
            break
        case HttpMethod.HttpMethodPut:
            Alamofire.request(.PUT, remoteUrl, parameters: params).responseJSON {
                response in
                self.handleWithResponse(response, success: success, failed: failed)
            }
            break
        default:
            break
        }
    }


    func handleWithResponse(response: Response<AnyObject, NSError>, success: HttpSuccessBlock, failed: HttpFailedBlock) {
        dispatch_async(dispatch_get_main_queue(), {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            let statusCode = response.response?.statusCode
            if statusCode == HttpStatusCode.HttpStatusCodeSuccess.rawValue {
                success(response: response)
            } else if statusCode == HttpStatusCode.HttpStatusCodeUnauthorized.rawValue{
                NSNotificationCenter.defaultCenter().postNotificationName(Constants.Notification.LoginExpired, object: nil)
            }
            else {
                failed(errorMsg: "Request Data Error")
            }
        })
    }
}

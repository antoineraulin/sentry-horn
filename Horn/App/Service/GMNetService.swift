//
// Created by Thierry on 16/1/5.
// Copyright (c) 2016 Thierry. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


/** @brief Http Method */

enum HttpMethod: Int {
    case httpMethodGet = 0
    case httpMethodPost
    case httpMethodPut
    case httpMethodDelete
    case httpMethodPatch
};

class GMNetService {

    var apiHost: String = ""
    var urlCommonParameters: String = ""

    static let sharedInstance: GMNetService = {
        return GMNetService()
    }()

    func startRequestWithUrlString(_ url: String,
                                   params: [String:AnyObject],
                                   method: HttpMethod,
                                   success: @escaping HttpSuccessBlock,
                                   failed: @escaping HttpFailedBlock) {
        let remoteUrl = url
        switch method {
        case HttpMethod.httpMethodGet:
            Alamofire.request(remoteUrl, method: .get, parameters: params, encoding: JSONEncoding.default).responseJSON {
                response in
                self.handleWithResponse(response, success: success, failed: failed)
            }
            break
        case HttpMethod.httpMethodPost:
            Alamofire.request(remoteUrl, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON {
                response in
                self.handleWithResponse(response, success: success, failed: failed)
            }
            break
        case HttpMethod.httpMethodDelete:
            Alamofire.request(remoteUrl, method: .delete, parameters: params, encoding: JSONEncoding.default).responseJSON {
                response in
                self.handleWithResponse(response, success: success, failed: failed)
            }
            break
        case HttpMethod.httpMethodPut:
            Alamofire.request(remoteUrl, method: .put, parameters: params, encoding: JSONEncoding.default).responseJSON {
                response in
                self.handleWithResponse(response, success: success, failed: failed)
            }
            break
        default:
            break
        }
    }


    func handleWithResponse(_ response: DataResponse<Any>, success: @escaping HttpSuccessBlock, failed: @escaping HttpFailedBlock) {
        DispatchQueue.main.async(execute: {
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            let statusCode = response.response?.statusCode
//            if statusCode == HttpStatusCode.httpStatusCodeSuccess.rawValue {
//                success(response)
//            } else if statusCode == HttpStatusCode.httpStatusCodeUnauthorized.rawValue{
//                NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.Notification.LoginExpired), object: nil)
//            }
//            else {
//                failed("Request Data Error")
//            }
        })
    }
}

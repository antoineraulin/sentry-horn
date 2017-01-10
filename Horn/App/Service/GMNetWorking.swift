//
//  NetService.swift
//  Horn
//
//  Created by Thierry on 2017/1/5.
//  Copyright © 2017年 Thierry. All rights reserved.
//

import Foundation
import Moya

enum APIStatusCode: Int {
    case apiStatusCodeSuccess = 0
    case apiStatusCodeEmpty = 1
    case apiStatusCodeFailed = 2
};

/** @brief Http Status */
enum HttpStatusCode: Int {
    case httpStatusCodeSuccess = 200
    case httpStatusCodeError = 500
    case httpStatusCodeUnauthorized = 401
};

/** @brief Net Working API */
enum GMNetWorkingAPI {
    case organizations()
    case projects()
    case issues(projectSlug: String)
}


// MARK: - TargetType Protocol Implementation
extension GMNetWorkingAPI: TargetType {
    
    var baseURL: URL { return URL(string: Constants.apiHost)! }
    
    var path: String {
        switch self {
        case .organizations():
            return "/organizations"
        case .projects():
            return "organizations/\(Constants.currentOrganization)/projects/"
        case .issues(let projectSlug):
            return "/projects/\(Constants.currentOrganization)/\(projectSlug)/issues/"
        }
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding()
    }
    
    var sampleData : Data {
        return Data()
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .request
    }
    
}

/** @brief Http Response Result Block */
typealias HttpSuccessBlock = (_ data: Response) -> Void
typealias HttpFailedBlock = (_ errorMsg: String) -> Void

struct GMNetWorking {
    
    static var provider: MoyaProvider<GMNetWorkingAPI>!
    
    static func url(route: TargetType) -> String {
        return route.baseURL.appendingPathComponent(route.path).absoluteString
    }
    
    static func doRequest(_ api: GMNetWorkingAPI, extraParameters: [String: Any], success: @escaping HttpSuccessBlock, failed: @escaping HttpFailedBlock) {
        
        provider = MoyaProvider(endpointClosure: buildEndPointClousure(extraParameters: extraParameters))
        
        provider.request(api) { result in
            switch result {
            case let .success(moyaResponse):
                let statusCode = moyaResponse.statusCode
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if statusCode == HttpStatusCode.httpStatusCodeSuccess.rawValue {
                    success(moyaResponse)
                } else if statusCode == HttpStatusCode.httpStatusCodeUnauthorized.rawValue{
                    NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.Notification.LoginExpired), object: nil)
                }
                break
            case let .failure(error):
                debugLog(error.errorDescription)
                failed("Request Data Error")
                break
            }
        }
    }
    
    static func buildEndPointClousure(extraParameters: [String: Any]) -> MoyaProvider<GMNetWorkingAPI>.EndpointClosure {
        
        let endpointClosure = { (target: GMNetWorkingAPI) -> Endpoint<GMNetWorkingAPI> in
            var endpoint: Endpoint<GMNetWorkingAPI> = Endpoint<GMNetWorkingAPI>(url: url(route: target), sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
            endpoint = endpoint.adding(newHTTPHeaderFields: ["Authorization": "Bearer \(Constants.apiToken)"])
            if !extraParameters.isEmpty {
                endpoint = endpoint.adding(newParameters: extraParameters)
            }
            return endpoint
        }
        
        return endpointClosure
    
    }
    
}

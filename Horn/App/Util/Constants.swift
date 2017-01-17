//
//  Constant.swift
//  Achilles
//
//  Created by Thierry on 8/29/15.
//  Copyright (c) 2015 Thierry. All rights reserved.
//

import Foundation

struct Color {
    static let levelError = "#ec5b33"
    static let levelInfo = "#25a6f7"
    static let levelWarning = "#f6d846"
    static let levelDefault = "#546076"
    
    static let blue = "#25a6f7"
    static let lineGray = "#d6dbe4"
    static let assistColor = "#546076"
    
    static let fontBlack = "#1e263c"
    static let fontBlue = "#1d87ce"
    static let fontGray = "#546076"
    static let fontLightGray = "#6f7e94"
}

struct Constants {
    
    // Default Organization
    static var currentOrganization = "sentry"
//    static var currentOrganization = "sentry-sc"
    
    // Default Host
//    static let host = "https://sentry.io"
    static let host = "http://sentry.gengmei.cc"
    static let apiHost = "\(host)/api/0"
    static let webHost = "\(host)"
    
//    static let apiToken = "5b0c2c44939d4ea3b2f85a101d6495c8a085d2134eb542158235309606d0297e"
    static let apiToken = "5c2be9b4da404b3ab818f042f4bf3a3c2967a0819b6f4cbc9e91193bcead4f13"
    
    struct Web {
        static let root = host+"/"
        static let organizationsRoot = host+"/\(currentOrganization)/"
        static let login = host+"/auth/login/\(currentOrganization)/"
        static let stats = host+"/organizations/\(currentOrganization)/stats/"
    }
    
    struct Notification {
        static let LoginExpired = "LoginExpired"
    }
}

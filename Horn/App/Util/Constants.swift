//
//  Constant.swift
//  Achilles
//
//  Created by Thierry on 8/29/15.
//  Copyright (c) 2015 Thierry. All rights reserved.
//

import Foundation

struct Color {
    static let LevelError = "#ec5b33"
    static let LevelInfo = "#25a6f7"
    static let LevelWarning = "#f6d846"
    static let LevelDefault = "#546076"
    
    static let Blue = "#25a6f7"
    static let LineGray = "#d6dbe4"
    static let AssistColor = "#546076"
    
    static let FontBlack = "#1e263c"
    static let FontBlue = "#1d87ce"
    static let FontGray = "#546076"
    static let FontLightGray = "#6f7e94"
}

struct Constants {
    
    // Default Organization
    static var CurrentOrganization = "sentry"

    // Default Host
    static let Host = "http://sentry.gengmei.cc"

    struct Web {
        static let Root = "/"
        static let Login = "/auth/login/sentry/"
    }
    
    struct API {
        static let Organizations = "/api/0/organizations/"
        static let Projects = "/api/0/organizations/\(CurrentOrganization)/projects/"
        static let New = "/api/0/organizations/\(CurrentOrganization)/issues/new/"
        static let Assigned = "/api/0/organizations/\(CurrentOrganization)/members/me/issues/assigned/"
        static let Events = "/api/0/projects/\(CurrentOrganization)/%@/issues/"
    }
    
    struct Notification {
        static let LoginExpired = "LoginExpired"
    }
}
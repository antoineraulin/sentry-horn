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
    static var CurrentOrganization = "sentry-sc"
//    static var CurrentOrganization = "sentry"

    // Default Host
//    static let Host = "http://sentry.gengmei.cc"
    static let Host = "https://sentry.io"

    struct Web {
        static let Root = Host+"/"
        static let OrganizationsRoot = Host+"/\(CurrentOrganization)/"
        static let Login = Host+"/auth/login/\(CurrentOrganization)/"
        static let Stats = Host+"/organizations/\(CurrentOrganization)/stats/"
    }
    
    struct API {
        static let Organizations = Host+"/api/0/organizations/"
        static let Projects = Host+"/api/0/organizations/\(CurrentOrganization)/projects/"
        static let New = Host+"/api/0/organizations/\(CurrentOrganization)/issues/new/"
        static let Events = Host+"/api/0/projects/\(CurrentOrganization)/%@/issues/"
        static let Assigned = Host+"/api/0/organizations/\(CurrentOrganization)/members/me/issues/assigned/"
        static let Bookmarks = Host+"/api/0/organizations/\(CurrentOrganization)/members/me/issues/bookmarked/"
        static let History = Host+"/api/0/organizations/\(CurrentOrganization)/members/me/issues/viewed/"
    }
    
    struct Notification {
        static let LoginExpired = "LoginExpired"
    }
}

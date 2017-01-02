//
//  LogUtil.swift
//  Achilles
//
//  Created by Thierry on 16/1/8.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import Foundation

func debugLog<T>(_ message: T,
    file: String = #file,
    method: String = #function,
    line: Int = #line)
{
    #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)], \(method):\n \(message)\n")
    #endif
}

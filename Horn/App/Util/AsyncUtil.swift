//
//  AsyncUtil.swift
//  Pods
//
//  Created by Thierry on 16/6/14.
//
//

import Foundation

/**
 Postpone execute [task].
 
 - parameter delay:   time to delay
 - parameter closure: the code to postpone execute.
 */
public func delay(delay: Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}

/**
 Execute [task] asynchronously.
 
 - parameter task: the code to execute asynchronously.
 */
public func doAsync(task: () -> Void) {
    DispatchQueue.global().sync(execute: task)

}

/**
 Execute [task] on the application UI thread.
 
 - parameter task: task the code to execute UI thread.
 */
public func uiThread(task: @escaping () -> Void) {
    DispatchQueue.main.async(execute: task)
}

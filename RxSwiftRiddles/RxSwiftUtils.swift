//
//  RxSwiftUtils.swift
//  RxSwiftRiddles
//
//  Created by Niedziolko on 03/06/2018.
//  Copyright © 2018 sonalyst. All rights reserved.
//

import Foundation
import RxSwift
import RxTest

public func ==(lhs: [Recorded<Event<Int>>], rhs: [Recorded<Event<Int>>]) -> Bool {
    let last = lhs.count - 1
    for i in 0...last {
        if lhs[i] == rhs[i] {
            continue
        }
        return false
    }
    return true
}

public func ==(lhs: [Recorded<Event<Bool>>], rhs: [Recorded<Event<Bool>>]) -> Bool {
    let last = lhs.count - 1
    for i in 0...last {
        if lhs[i] == rhs[i] {
            continue
        }
        return false
    }
    return true
}

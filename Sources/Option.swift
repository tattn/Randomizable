//
//  Option.swift
//  Randomizable
//
//  Created by Tatsuya Tanaka on 2018/12/07.
//  Copyright © 2018 tattn. All rights reserved.
//

import Foundation

public struct RandomizableOption {
    public var forceNil: Bool

    public init(forceNil: Bool) {
        self.forceNil = forceNil
    }

    public init() {
        forceNil = false
    }
}

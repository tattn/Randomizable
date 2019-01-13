//
//  DefaultRandomValue.swift
//  Randomizable
//
//  Created by Tatsuya Tanaka on 20181102.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

protocol DefaultRandom {
    static func defaultRandom() -> Self
}

extension Bool: DefaultRandom {
    static func defaultRandom() -> Bool {
        return .random()
    }
}

extension Int: DefaultRandom {
    static func defaultRandom() -> Int {
        return .random(in: .min...(.max))
    }
}

extension Int8: DefaultRandom {
    static func defaultRandom() -> Int8 {
        return .random(in: .min...(.max))
    }
}

extension Int16: DefaultRandom {
    static func defaultRandom() -> Int16 {
        return .random(in: .min...(.max))
    }
}

extension Int32: DefaultRandom {
    static func defaultRandom() -> Int32 {
        return .random(in: .min...(.max))
    }
}

extension Int64: DefaultRandom {
    static func defaultRandom() -> Int64 {
        return .random(in: .min...(.max))
    }
}

extension UInt: DefaultRandom {
    static func defaultRandom() -> UInt {
        return .random(in: .min...(.max))
    }
}

extension UInt8: DefaultRandom {
    static func defaultRandom() -> UInt8 {
        return .random(in: .min...(.max))
    }
}

extension UInt16: DefaultRandom {
    static func defaultRandom() -> UInt16 {
        return .random(in: .min...(.max))
    }
}

extension UInt32: DefaultRandom {
    static func defaultRandom() -> UInt32 {
        return .random(in: .min...(.max))
    }
}

extension UInt64: DefaultRandom {
    static func defaultRandom() -> UInt64 {
        return .random(in: .min...(.max))
    }
}

extension Float: DefaultRandom {
    static func defaultRandom() -> Float {
        return .random(in: -(.greatestFiniteMagnitude/2)...(.greatestFiniteMagnitude/2))
    }
}

extension Double: DefaultRandom {
    static func defaultRandom() -> Double {
        return .random(in: -(.greatestFiniteMagnitude/2)...(.greatestFiniteMagnitude/2))
    }
}

extension String: DefaultRandom {
    static func defaultRandom() -> String {
        return String(bytes: Array(repeating: 0, count: .random(in: 4...8))
            .map { _ in UInt8.random(in: 97...122) }, encoding: .utf8) ?? "???"
    }
}

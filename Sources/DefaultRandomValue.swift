//
//  DefaultRandomValue.swift
//  Randomizable
//
//  Created by Tatsuya Tanaka on 20181102.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

protocol DefaultRamdom {
    static func defaultRandom() -> Self
}

extension Bool: DefaultRamdom {
    static func defaultRandom() -> Bool {
        return .random()
    }
}

extension Int: DefaultRamdom {
    static func defaultRandom() -> Int {
        return .random(in: .min...(.max))
    }
}

extension Int8: DefaultRamdom {
    static func defaultRandom() -> Int8 {
        return .random(in: .min...(.max))
    }
}

extension Int16: DefaultRamdom {
    static func defaultRandom() -> Int16 {
        return .random(in: .min...(.max))
    }
}

extension Int32: DefaultRamdom {
    static func defaultRandom() -> Int32 {
        return .random(in: .min...(.max))
    }
}

extension Int64: DefaultRamdom {
    static func defaultRandom() -> Int64 {
        return .random(in: .min...(.max))
    }
}

extension UInt: DefaultRamdom {
    static func defaultRandom() -> UInt {
        return .random(in: .min...(.max))
    }
}

extension UInt8: DefaultRamdom {
    static func defaultRandom() -> UInt8 {
        return .random(in: .min...(.max))
    }
}

extension UInt16: DefaultRamdom {
    static func defaultRandom() -> UInt16 {
        return .random(in: .min...(.max))
    }
}

extension UInt32: DefaultRamdom {
    static func defaultRandom() -> UInt32 {
        return .random(in: .min...(.max))
    }
}

extension UInt64: DefaultRamdom {
    static func defaultRandom() -> UInt64 {
        return .random(in: .min...(.max))
    }
}

extension Float: DefaultRamdom {
    static func defaultRandom() -> Float {
        return .random(in: -(.greatestFiniteMagnitude/2)...(.greatestFiniteMagnitude/2))
    }
}

extension Double: DefaultRamdom {
    static func defaultRandom() -> Double {
        return .random(in: -(.greatestFiniteMagnitude/2)...(.greatestFiniteMagnitude/2))
    }
}

extension String: DefaultRamdom {
    static func defaultRandom() -> String {
        return String(bytes: Array(repeating: 0, count: .random(in: 4...8))
            .map { _ in UInt8.random(in: 97...122) }, encoding: .utf8) ?? "???"
    }
}

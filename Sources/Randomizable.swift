//
//  Randomizable.swift
//  Randomizable
//
//  Created by Tatsuya Tanaka on 20181102.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

public protocol Randomizable {
    static func randomValue() -> Self
}

public extension Randomizable where Self: Decodable {
    public static func randomValue() -> Self {
        let randomDecoder = RandomDecoder()
        return try! randomDecoder.decode(Self.self)
    }
}

public extension Randomizable where Self: Decodable, Self: CaseIterable {
    public static func randomValue() -> Self {
        return allCases.randomElement()!
    }
}

extension Bool: Randomizable {}
extension Int: Randomizable {}
extension Int8: Randomizable {}
extension Int16: Randomizable {}
extension Int32: Randomizable {}
extension Int64: Randomizable {}
extension UInt: Randomizable {}
extension UInt8: Randomizable {}
extension UInt16: Randomizable {}
extension UInt32: Randomizable {}
extension UInt64: Randomizable {}
extension Float: Randomizable {}
extension Double: Randomizable {}
extension String: Randomizable {}

extension Optional: Randomizable where Wrapped: Randomizable {
    public static func randomValue() -> Optional<Wrapped> {
        return Bool.random() ? nil : Wrapped.randomValue()
    }
}

extension Date: Randomizable {
    public static func randomValue() -> Date {
        return Date()
    }
}

extension Data: Randomizable {
    public static func randomValue() -> Data {
        return Data(bytes: (10...100).map{ _ in UInt.defaultRamdom() }.map(UInt8.init))
    }
}

extension URL: Randomizable {
    public static func randomValue() -> URL {
        return URL(string: "https://\(String.defaultRamdom()).com")!
    }
}

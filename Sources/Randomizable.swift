//
//  Randomizable.swift
//  Randomizable
//
//  Created by Tatsuya Tanaka on 20181102.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

public protocol Randomizable {
    static func randomValue(with configuration: RandomizableConfiguration) -> Self
}

public extension Randomizable where Self: Decodable {
    public static func randomValue(with configuration: RandomizableConfiguration = .init()) -> Self {
        let randomDecoder = RandomDecoder(configuration: configuration)
        return try! randomDecoder.decode(Self.self)
    }
}

public extension Randomizable where Self: Decodable, Self: CaseIterable {
    public static func randomValue(with configuration: RandomizableConfiguration = .init()) -> Self {
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
    public static func randomValue(with configuration: RandomizableConfiguration = .init()) -> Optional<Wrapped> {
        return Bool.random() ? nil : Wrapped.randomValue(with: configuration)
    }
}

extension Date: Randomizable {
    public static func randomValue(with configuration: RandomizableConfiguration = .init()) -> Date {
        return Date()
    }
}

extension Data: Randomizable {
    public static func randomValue(with configuration: RandomizableConfiguration = .init()) -> Data {
        return Data(bytes: (10...100).map{ _ in UInt.defaultRandom() }.map(UInt8.init))
    }
}

extension URL: Randomizable {
    public static func randomValue(with configuration: RandomizableConfiguration = .init()) -> URL {
        return URL(string: "https://\(String.defaultRandom()).com")!
    }
}

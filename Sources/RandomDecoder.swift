//
//  RandomDecoder.swift
//  Randomizable
//
//  Created by Tatsuya Tanaka on 20181102.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation


open class RandomDecoder: Decoder {
    open var codingPath: [CodingKey]
    open var userInfo: [CodingUserInfoKey: Any] = [:]

    public init(codingPath: [CodingKey] = []) {
        self.codingPath = codingPath
    }

    open func container<Key: CodingKey>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> {
        return KeyedDecodingContainer(KeyedContainer<Key>(decoder: self, codingPath: []))
    }

    open func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        return UnkeyedContanier(decoder: self)
    }

    open func singleValueContainer() throws -> SingleValueDecodingContainer {
        return SingleValueContanier(decoder: self)
    }

    func random<T: Decodable>() throws -> T {
        if let randomType = T.self as? Randomizable.Type {
            return randomType.randomValue() as! T
        } else {
            return try T(from: self)
        }
    }
}

extension RandomDecoder {
    open func decode<T : Decodable>(_ type: T.Type) throws -> T {
        return try T(from: self)
    }
}

extension RandomDecoder {
    private class KeyedContainer<Key: CodingKey>: KeyedDecodingContainerProtocol {
        private var decoder: RandomDecoder
        private(set) var codingPath: [CodingKey]

        init(decoder: RandomDecoder, codingPath: [CodingKey]) {
            self.decoder = decoder
            self.codingPath = codingPath
        }

        var allKeys: [Key] { return [] }
        func contains(_ key: Key) -> Bool { return true }

        func decodeNil(forKey key: Key) throws -> Bool { return .random() }
        func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool { return .random() }
        func decode(_ type: Int.Type, forKey key: Key) throws -> Int { return .defaultRamdom() }
        func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 { return .defaultRamdom() }
        func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 { return .defaultRamdom() }
        func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 { return .defaultRamdom() }
        func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 { return .defaultRamdom() }
        func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt { return .defaultRamdom() }
        func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 { return .defaultRamdom() }
        func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 { return .defaultRamdom() }
        func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 { return .defaultRamdom() }
        func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 { return .defaultRamdom() }
        func decode(_ type: Float.Type, forKey key: Key) throws -> Float { return .defaultRamdom() }
        func decode(_ type: Double.Type, forKey key: Key) throws -> Double { return .defaultRamdom() }
        func decode(_ type: String.Type, forKey key: Key) throws -> String { return .defaultRamdom() }
        func decode<T: Decodable>(_ type: T.Type, forKey key: Key) throws -> T {
            decoder.codingPath.append(key)
            defer { decoder.codingPath.removeLast() }
            return try decoder.random()
        }

        func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
            decoder.codingPath.append(key)
            defer { decoder.codingPath.removeLast() }
            return KeyedDecodingContainer(KeyedContainer<NestedKey>(decoder: decoder, codingPath: []))
        }

        func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
            decoder.codingPath.append(key)
            defer { decoder.codingPath.removeLast() }
            return UnkeyedContanier(decoder: decoder)
        }

        func _superDecoder(forKey key: CodingKey = AnyCodingKey.super) throws -> Decoder {
            decoder.codingPath.append(key)
            defer { decoder.codingPath.removeLast() }
            return RandomDecoder()
        }

        func superDecoder() throws -> Decoder {
            return try _superDecoder()
        }

        func superDecoder(forKey key: Key) throws -> Decoder {
            return try _superDecoder(forKey: key)
        }
    }

    private class UnkeyedContanier: UnkeyedDecodingContainer {
        private var decoder: RandomDecoder
        private(set) var codingPath: [CodingKey]

        private(set) var count: Int?
        var isAtEnd: Bool { return currentIndex >= count! }

        private(set) var currentIndex: Int = 0
        private var currentCodingPath: [CodingKey] { return decoder.codingPath + [AnyCodingKey(index: currentIndex)] }

        init(decoder: RandomDecoder) {
            self.decoder = decoder
            self.codingPath = decoder.codingPath

            count = Int.random(in: 2...4)
        }

        func ramdom<T: DefaultRamdom>(_ type: T.Type) throws -> T {
            decoder.codingPath.append(AnyCodingKey(index: currentIndex))
            defer {
                decoder.codingPath.removeLast()
                currentIndex += 1
            }
            return T.defaultRamdom()
        }

        func decodeNil() throws -> Bool { return false }
        func decode(_ type: Bool.Type) throws -> Bool { return try ramdom(type) }
        func decode(_ type: Int.Type) throws -> Int { return try ramdom(type) }
        func decode(_ type: Int8.Type) throws -> Int8 { return try ramdom(type) }
        func decode(_ type: Int16.Type) throws -> Int16 { return try ramdom(type) }
        func decode(_ type: Int32.Type) throws -> Int32 { return try ramdom(type) }
        func decode(_ type: Int64.Type) throws -> Int64 { return try ramdom(type) }
        func decode(_ type: UInt.Type) throws -> UInt { return try ramdom(type) }
        func decode(_ type: UInt8.Type) throws -> UInt8 { return try ramdom(type) }
        func decode(_ type: UInt16.Type) throws -> UInt16 { return try ramdom(type) }
        func decode(_ type: UInt32.Type) throws -> UInt32 { return try ramdom(type) }
        func decode(_ type: UInt64.Type) throws -> UInt64 { return try ramdom(type) }
        func decode(_ type: Float.Type) throws -> Float { return try ramdom(type) }
        func decode(_ type: Double.Type) throws -> Double { return try ramdom(type) }
        func decode(_ type: String.Type) throws -> String { return try ramdom(type) }
        func decode<T: Decodable>(_ type: T.Type) throws -> T {
            decoder.codingPath.append(AnyCodingKey(index: currentIndex))
            defer {
                decoder.codingPath.removeLast()
                currentIndex += 1
            }
            return try decoder.random()
        }

        func nestedContainer<NestedKey: CodingKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> {
            decoder.codingPath.append(AnyCodingKey(index: currentIndex))
            defer {
                decoder.codingPath.removeLast()
                currentIndex += 1
            }
            return KeyedDecodingContainer(KeyedContainer<NestedKey>(decoder: decoder, codingPath: []))
        }

        func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
            decoder.codingPath.append(AnyCodingKey(index: currentIndex))
            defer {
                decoder.codingPath.removeLast()
                currentIndex += 1
            }
            return UnkeyedContanier(decoder: decoder)
        }

        func superDecoder() throws -> Decoder {
            decoder.codingPath.append(AnyCodingKey(index: currentIndex))
            defer {
                decoder.codingPath.removeLast()
                currentIndex += 1
            }
            return RandomDecoder(codingPath: decoder.codingPath)
        }
    }

    private class SingleValueContanier: SingleValueDecodingContainer {
        private var decoder: RandomDecoder
        var codingPath: [CodingKey] { return decoder.codingPath }

        init(decoder: RandomDecoder) {
            self.decoder = decoder
        }

        func decodeNil() -> Bool { return true }
        func decode(_ type: Bool.Type) throws -> Bool { return .defaultRamdom() }
        func decode(_ type: Int.Type) throws -> Int { return .defaultRamdom() }
        func decode(_ type: Int8.Type) throws -> Int8 { return .defaultRamdom() }
        func decode(_ type: Int16.Type) throws -> Int16 { return .defaultRamdom() }
        func decode(_ type: Int32.Type) throws -> Int32 { return .defaultRamdom() }
        func decode(_ type: Int64.Type) throws -> Int64 { return .defaultRamdom() }
        func decode(_ type: UInt.Type) throws -> UInt { return .defaultRamdom() }
        func decode(_ type: UInt8.Type) throws -> UInt8 { return .defaultRamdom() }
        func decode(_ type: UInt16.Type) throws -> UInt16 { return .defaultRamdom() }
        func decode(_ type: UInt32.Type) throws -> UInt32 { return .defaultRamdom() }
        func decode(_ type: UInt64.Type) throws -> UInt64 { return .defaultRamdom() }
        func decode(_ type: Float.Type) throws -> Float { return .defaultRamdom() }
        func decode(_ type: Double.Type) throws -> Double { return .defaultRamdom() }
        func decode(_ type: String.Type) throws -> String { return .defaultRamdom() }
        func decode<T: Decodable>(_ type: T.Type) throws -> T { return try decoder.random() }
    }
}

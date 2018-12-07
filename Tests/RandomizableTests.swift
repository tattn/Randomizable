//
//  RandomizableTests.swift
//  RandomizableTests
//
//  Created by Tatsuya Tanaka on 20181102.
//  Copyright © 2018年 tattn. All rights reserved.
//

import XCTest
import Randomizable

class RandomizableTests: XCTestCase {
    
    func testPrimitiveValue() {
        _ = Bool.randomValue()
        _ = Int.randomValue()
        _ = Int8.randomValue()
        _ = Int16.randomValue()
        _ = Int32.randomValue()
        _ = Int64.randomValue()
        _ = UInt.randomValue()
        _ = UInt8.randomValue()
        _ = UInt16.randomValue()
        _ = UInt32.randomValue()
        _ = UInt64.randomValue()
        _ = Float.randomValue()
        _ = Double.randomValue()
        _ = String.randomValue()
    }

    func testOptionalValue() {
        _ = Bool?.randomValue()
        _ = Int?.randomValue()
        _ = Int8?.randomValue()
        _ = Int16?.randomValue()
        _ = Int32?.randomValue()
        _ = Int64?.randomValue()
        _ = UInt?.randomValue()
        _ = UInt8?.randomValue()
        _ = UInt16?.randomValue()
        _ = UInt32?.randomValue()
        _ = UInt64?.randomValue()
        _ = Float?.randomValue()
        _ = Double?.randomValue()
        _ = String?.randomValue()
    }

    func testComplexStruct() {
        struct A: Decodable, Randomizable {
            let bool: Bool?
            let int: Int
            let int8: Int8?
            let int16: Int16
            let int32: Int32?
            let int64: Int64
            let uint: UInt?
            let uint8: UInt8
            let uint16: UInt16?
            let uint32: UInt32
            let uint64: UInt64?
            let float: Float
            let double: Double?
            let string: String
            let child: Child?
            let array: [Child]?
            let dictionary: [String: Child]?
            let date: Date
            let data: Data
            let url: URL

            struct Child: Decodable, Randomizable {
                let string: String
                let child: ChildChild?

                struct ChildChild: Decodable, Randomizable {
                    let string: String
                }
            }
        }

        _ = A.randomValue()
        _ = A?.randomValue()
    }

    func testCustomRamdomValue() {
        struct A: Decodable, Randomizable {
            let bool: Bool
            let child: Child

            struct Child: Decodable, Randomizable {
                let string: String
                let child: ChildChild

                struct ChildChild: Decodable, Randomizable {
                    let ramdomString: String
                    let fixedString: String

                    static func randomValue(with option: RandomizableOption) -> A.Child.ChildChild {
                        return A.Child.ChildChild(ramdomString: .randomValue(),
                                                  fixedString: "hello")
                    }
                }
            }
        }

        XCTAssertEqual(A.randomValue().child.child.fixedString, "hello")
    }

    func testEnum() {
        struct A: Decodable, Randomizable {
            let animal: Animal
            enum Animal: String, Decodable, CaseIterable, Randomizable {
                case cat
                case dog
                case rabbit
            }
        }
        _ = A.randomValue()
    }

    func testEnumWithAssociatedValue() {
        struct A: Decodable, Randomizable {
            let animal: Animal
            enum Animal: Decodable, Randomizable {
                case cat(name: String)
                case dog(name: String)
                case rabbit(name: String)

                init(from decoder: Decoder) throws {
                    fatalError()
                }

                static func randomValue(with option: RandomizableOption) -> A.Animal {
                    switch Int.random(in: 0...2) {
                    case 0: return .cat(name: .randomValue())
                    case 1: return .dog(name: .randomValue())
                    default: return .rabbit(name: .randomValue())
                    }
                }
            }
        }
        _ = A.randomValue()
    }

    func testForceNil() {
        struct A: Decodable, Randomizable {
            let int: Int?
            let string: String?
            let double: Double?
            let bool: Bool?
        }
        let a = A.randomValue(with: .init(forceNil: true))
        XCTAssertNil(a.int)
        XCTAssertNil(a.string)
        XCTAssertNil(a.double)
        XCTAssertNil(a.bool)
    }
}

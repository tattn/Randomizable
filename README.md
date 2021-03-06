<h1 align="center">Randomizable</h1>

<h5 align="center">Any type random value generator to reduce boilerplates for unittest</h5>

<div align="center">
  <a href="https://app.bitrise.io/app/199f887ce5359b4e">
    <img src="https://app.bitrise.io/app/199f887ce5359b4e/status.svg?token=bLqDl7vgLlFeGrk0towLWw" alt="Bitrise" />
  </a>
  <a href="https://github.com/Carthage/Carthage">
    <img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" alt="Carthage compatible" />
  </a>
  <a href="https://developer.apple.com/swift">
    <img src="https://img.shields.io/badge/Swift-4-F16D39.svg" alt="Swift Version" />
  </a>
  <a href="./LICENSE">
    <img src="https://img.shields.io/badge/license-MIT-green.svg?style=flat-square" alt="license:MIT" />
  </a>
</div>

<br />

## Features

- [x] Generate random value for any type
- [x] Customize rules for random

# Requirements

- Xcode 10.x
- Swift 4.x
- iOS 9.0+

# Installation

## Carthage

```ruby
github "tattn/Randomizable"
```

## Swift Package Manager

```ruby
.package(url: "https://github.com/tattn/Randomizable.git", from: “1.0.3")
```

# Usage

## Generate random value for `struct`

```swift
import Randomizable

// conform Decodable to auto-implement Randomizable
struct User: Decodable, Randomizable {
    let id: ID
    let name: String

    struct ID: Decodable, Randomizable {
        let id: Int
    }
}

let user = User.randomValue()
// => User(id: ID(id: 1823), name: "raewfbaw")
```

## Customize random value

```swift
struct User: Decodable, Randomizable {
    let name: String
    let profile: Profile

    struct Profile: Decodable, Randomizable {
        let email: String
        let birthday: Date?

        static func randomValue() -> Profile {
            return Profile(email: "\(String.randomValue())@test.com",
                           birthday: Date?.randomValue())
        }
    }
}

let user = User.randomValue()
// => User(name: "gaoaweja", profile: Profile(email: "iwelasm@test.com"
//                           birthday: 2018-11-02 16:25:17 +0000))
```

## Enum support

```swift
struct A: Decodable, Randomizable {
    let animal: Animal
    enum Animal: String, Decodable, CaseIterable, Randomizable {
        case cat
        case dog
        case rabbit
    }
}

A.randomValue()
// => A(animal: Animal.cat)
```

## Configuration

```swift
struct A: Decodable, Randomizable {
    let int: Int?
    let string: String?
}

let configuration = RandomizableConfiguration()
configuration.forceNil = true

let a = A.randomValue(with: configuration)
a.int // nil
a.string // nil
```


# Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D


# License

Randomizable is released under the MIT license. See LICENSE for details.


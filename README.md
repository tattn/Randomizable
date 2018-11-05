<h1 align="center">Randomizable</h1>

<h5 align="center">Any type random value generator</h5>

<div align="center">
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

# Requirements

- Xcode 10.x
- Swift 4.x
- iOS 9.0+

# Installation

## Carthage

```ruby
github "tattn/Randomizable"
```

# Usage

## Generate random value of struct

```swift
import Randomizable

struct User: Decodable, Randomizable {
    let id: ID
    let name: String

    struct ID: Decodable, Randomizable {
        let id: Int
    }
}

let user = User.randomValue() # => User(id: ID(id: 1823), name: "raewfbaw")
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
# => User(name: "gaoaweja", profile: Profile(email: "iwelasm@test.com" birthday: 2018-11-02 16:25:17 +0000))
```


# Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D


# License

Randomizable is released under the MIT license. See LICENSE for details.


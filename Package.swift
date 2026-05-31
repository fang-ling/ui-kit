// swift-tools-version: 6.2

//
//  Package.swift
//  ui-framework
//
//  Created by Fang Ling on 2025/12/28.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import PackageDescription

let isDevelopment = false

let dependencies = [
  ("c-kit", "main"),
  ("core-animation-kit", "main"),
  ("core-foundation-kit", "main"),
  ("foundation-kit", "main"),
  ("javascript-core-kit", "main"),
  ("objective-c-kit", "main")
]

let package = Package(
  name: "ui-kit",
  products: [
    .library(name: "UIKit", targets: ["UIKit"])
  ],
  dependencies: dependencies.map({
    if isDevelopment {
      return .package(path: "../\($0.0)")
    } else {
      return .package(url: "https://github.com/fang-ling/\($0.0)", branch: $0.1)
    }
  }),
  targets: [
    .target(
      name: "UIKit",
      dependencies: [
        .product(name: "CKit", package: "c-kit"),
        .product(name: "CoreAnimationKit", package: "core-animation-kit"),
        .product(name: "CoreFoundationKit", package: "core-foundation-kit"),
        .product(name: "FoundationKit", package: "foundation-kit"),
        .product(name: "JavaScriptCoreKit", package: "javascript-core-kit"),
        .product(name: "ObjectiveCKit", package: "objective-c-kit")
      ],
      publicHeadersPath: "Includes",
      cSettings: [
        .unsafeFlags(["-fobjc-runtime=objfw-1.5"], .when(platforms: [.wasi])),
        .unsafeFlags(["-fobjc-arc"]),
        .unsafeFlags(["-fno-constant-cfstrings"]),
        .unsafeFlags(["-fconstant-string-class=_FoundationConstantString"])
      ]
    ),
    .executableTarget(
      name: "UIKitExample",
      dependencies: [
        .product(name: "CKit", package: "c-kit"),
        .product(name: "CoreFoundationKit", package: "core-foundation-kit"),
        "UIKit"
      ],
      publicHeadersPath: "Includes",
      cSettings: [
        .unsafeFlags(["-fobjc-runtime=objfw-1.5"], .when(platforms: [.wasi])),
        .unsafeFlags(["-fobjc-arc"]),
        .unsafeFlags(["-fno-constant-cfstrings"]),
        .unsafeFlags(["-fconstant-string-class=_FoundationConstantString"])
      ]
    )
  ]
)

// swift-tools-version: 6.2

//
//  Package.swift
//  ui-kit-examples
//
//  Created by Fang Ling on 2026/6/6.
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

let package = Package(
  name: "ui-kit-examples",
  dependencies: [
    .package(path: "../")
  ],
  targets: [
    .executableTarget(
      name: "UIKitExample",
      dependencies: [
        .product(name: "UIKit", package: "ui-kit")
      ],
      publicHeadersPath: "Includes",
      cSettings: [
        .unsafeFlags(["-fobjc-runtime=objfw-1.5"], .when(platforms: [.wasi])),
        .unsafeFlags([
          "-fobjc-arc",
          "-fno-constant-cfstrings",
          "-fconstant-string-class=_FoundationConstantString"
        ])
      ]
    )
  ]
)

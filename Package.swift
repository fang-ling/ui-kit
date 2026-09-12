// swift-tools-version: 6.3

//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  Package.swift
//  ui-kit
//
//  Created by Fang Ling on 2025/12/28.
//
//  This source file is part of the UIKit open source project
//
//  Copyright (c) 2025-2026 Fang Ling <fangling@fangl.ing>
//  Licensed under Apache License v2.0
//
//  See LICENSE for license information
//
//  SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//

import PackageDescription

let isDevelopment = false

let dependencies = [
  ("c-kit", "CKit", "main"),
  ("core-animation-kit", "CoreAnimationKit", "main"),
  ("core-foundation-kit", "CoreFoundationKit", "main"),
  ("core-graphics-kit", "CoreGraphicsKit", "main"),
  ("foundation-kit", "FoundationKit", "main"),
  ("java-script-core-kit", "JavaScriptCoreKit", "main")
]

let package = Package(
  name: "ui-kit",
  products: [
    .library(name: "UIKit", targets: ["UIKit"])
  ],
  dependencies: dependencies.map { isDevelopment ? .package(path: "../\($0.0)") : .package(url: "https://github.com/fang-ling/\($0.0)", branch: $0.2) },
  targets: [
    .target(
      name: "UIKit",
      dependencies: dependencies.map { .product(name: $0.1, package: $0.0) }
    )
  ]
)

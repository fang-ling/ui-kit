//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIAction+Identifier.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/9/25.
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

#if !os(iOS)

import SwiftFramework

extension UIAction {
  /// A type that represents an action identifier.
  public struct Identifier: SwiftRawRepresentable, SwiftHashable {
    public var rawValue: SwiftString

    /// Creates an action identifier from the specified string.
    ///
    /// - Parameter rawvalue: A string that uniquely identifies the action.
    public init(rawValue: SwiftString) {
      self.rawValue = rawValue
    }
  }
}

#endif

//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIFont+Weight.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/10/1.
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

import CKit
import SwiftFramework

extension UIFont {
  /// Constants that represent standard typeface styles.
  ///
  /// Use system-defined constants as interchangeable values for weight. Each constant corresponds to a different value that indicates the weight of a font. Use these constants to specify the weight
  /// parameter in ``systemFont(ofSize:weight:)``. When providing a weight that doesn't precisely match a font face in the family, the system locates a face that most closely matches the request.
  ///
  /// > Note: Font ``UIFont/familyNames`` don't include all system-defined font constants.
  ///
  /// ## Topics
  ///
  /// ### Using system-defined font weights
  ///
  /// - ``regular``
  /// - ``medium``
  public struct Weight: SwiftRawRepresentable, SwiftSendable {
    /// The corresponding value of the font weight.
    public var rawValue: CFloatingPoint64

    /// The regular font weight.
    public static let regular: Weight = Weight(rawValue: 400)

    /// The medium font weight.
    public static let medium: Weight = Weight(rawValue: 510)

    /// Creates a font weight from the specified value.
    ///
    /// - Parameter rawvalue: The value of the font weight.
    public init(rawValue: CFloatingPoint64) {
      self.rawValue = rawValue
    }
  }
}

#endif

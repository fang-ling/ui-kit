//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIImage+SymbolWeight.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/10/4.
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

extension UIImage {
  /// Constants that indicate which weight variant of a symbol image to use.
  ///
  /// The definition of a symbol image includes multiple scale and weight variants. The weight variants offer a way to progressively thicken some or all of the image's lines. Weights do not correspond
  /// to a specific line thickness.
  ///
  /// ## Topics
  ///
  /// ### Symbol image weights
  ///
  /// - ``regular``
  /// - ``medium``
  public enum SymbolWeight: CInteger {
    /// A regular weight.
    case regular = 400

    /// A medium weight.
    case medium = 510
  }
}

#endif

//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIImage+SymbolConfiguration.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/6/6.
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

extension UIImage {
  /// An object that contains the specific font, size, style, and weight attributes to apply to a symbol image.
  ///
  /// Symbol image configuration objects include details such as the point size, scale, text style, weight, and font to apply to your symbol image. The system uses these details to determine which
  /// variant of the image to use and how to scale or style the image.
  ///
  /// ``UIImage/SymbolConfiguration`` objects are immutable after you create them. If you use the ``applying(_:)`` method on the object, the new image attributes replace any previous attributes you
  /// supplied. After creating a symbol configuration object, assign it to the ``UIImageView/preferredSymbolConfiguration`` property of the ``UIImageView`` object you use to display the image. If you
  /// draw the image directly, use the ``withConfiguration(_:)`` method to create a new image that contains the new attributes.
  ///
  /// ## Topics
  ///
  /// ### Creating a symbol configuration
  ///
  /// - ``init(pointSize:)``
  /// - ``init(pointSize:weight:)``
  /// - ``UIImage/SymbolWeight``
  public class SymbolConfiguration: Configuration {
    internal var pointSize: CFloatingPoint64

    internal var weight: SymbolWeight

    private override init() {
      self.pointSize = 17
      self.weight = .regular
    }

    /// Creates a configuration object with the specified point-size information.
    ///
    /// - Parameter pointSize: The system font point size to use for the configuration.
    public convenience init(pointSize: CFloatingPoint64) {
      self.init(pointSize: pointSize, weight: .regular)
    }

    /// Creates a configuration object with the specified point-size and weight information.
    ///
    /// - Parameters:
    ///   - pointSize: The system font point size to use for the configuration.
    ///   - weight: The symbol image weight variant to select. Specify a value that is comparable to the font weight of any matching text. For a list of possible values, see ``UIImage/SymbolWeight``.
    public convenience init(pointSize: CFloatingPoint64, weight: UIImage.SymbolWeight) {
      self.init()

      self.pointSize = pointSize
      self.weight = weight
    }
  }
}

#endif

//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIFont.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/6/19.
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

/// An object that provides access to the font's characteristics.
///
/// Use ``UIFont`` to access your font's characteristics within your app. It also provides the system with access to the glyph information, used during layout. Font objects are immutable, so it's safe
/// to use them from multiple threads in your app.
///
/// ## Topics
///
/// ### Creating System Fonts
///
/// - ``systemFont(ofSize:)``
/// - ``systemFont(ofSize:weight:)``
/// - ``UIFont/Weight``
///
/// ### Getting Font Metrics
///
/// - ``pixelSize``
/// - ``lineHeight``
public class UIFont {
  internal var weight: Weight = .regular

  /// The font's pixel size, or the effective vertical pixel size for a font with a nonstandard matrix.
  public private(set) var pixelSize: CFloatingPoint64

  /// The height, in pixels, of text lines.
  public private(set) var lineHeight: CFloatingPoint64

  private init(pixelSize: CFloatingPoint64, lineHeight: CFloatingPoint64) {
    self.pixelSize = pixelSize
    self.lineHeight = lineHeight
  }

  /// Returns the font object for standard interface items in the specified size.
  ///
  /// Instead of using this method to get a font, it's often more appropriate to use ``preferredFont(forTextStyle:)`` because that method respects the user's selected content size category.
  ///
  /// - Parameter fontSize: The size (in pixels) to which the font is scaled. This value must be greater than `0.0`.
  ///
  /// - Returns: A font object of the specified size.
  public class func systemFont(ofSize fontSize: CFloatingPoint64) -> UIFont {
    return UIFont.systemFont(ofSize: fontSize, weight: .regular)
  }

  /// Returns the font object for standard interface items in the specified size and weight.
  ///
  /// Instead of using this method to get a font, it's often more appropriate to use ``preferredFont(forTextStyle:)`` because that method respects the user's selected content size category.
  ///
  /// - Parameters:
  ///   - fontSize: The size (in pixels) to which the font is scaled. This value must be greater than `0.0`.
  ///   - weight: The weight of the font, specified as a font weight constant. For a list of possible values, see "Font Weights" in ``UIFontDescriptor``. Avoid passing an arbitrary floating-point
  ///     number for weight, because a font might not include a variant for every weight.
  ///
  /// - Returns: A font object of the specified size and weight.
  public class func systemFont(ofSize fontSize: CFloatingPoint64, weight: UIFont.Weight) -> UIFont {
    var lineHeight = 0.0
    if (fontSize == 10.0) {
      lineHeight = 11.933594;
    } else if (fontSize == 17) {
      lineHeight = 20.287109;
    }

    let font = UIFont(pixelSize: fontSize, lineHeight: lineHeight)
    font.weight = weight

    return font
  }
}

#endif

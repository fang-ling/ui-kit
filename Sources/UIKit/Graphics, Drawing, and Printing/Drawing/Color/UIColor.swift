//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIColor.swift
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

import SwiftFramework

/// An object that stores color data and sometimes opacity.
///
/// Use color to customize your app's appearance, communicate status, and help people visualize data.
///
/// ``UIColor`` provides a list of class properties that create adaptable and fixed colors such as blue, green, purple, and more. ``UIColor`` also offers properties to specify system-provided colors
/// for UI elements such as labels, text, and buttons. You can create color objects by specifying color component values such as RGB, hue, and saturation. You can also create colors from other color
/// objects and even create a pattern-based color from an image.
///
/// > Important: Most developers have no need to subclass ``UIColor``. The only time subclassing might be necessary is if you require support for additional color spaces or color models. If you do
///   subclass, the properties and methods you add must be safe to use from multiple threads.
///
/// ## Topics
///
/// ### Getting existing colors
///
/// - <doc:UI-Element-Colors>
/// - <doc:Color-Creation>
open class UIColor {
  internal var name: SwiftString

  /// The color for text labels that contain primary content.
  public class var label: UIColor {
    return UIColor(named: "color-label-primary")!
  }

  /// A color value that resolves at runtime based on the current tint color of the app or trait hierarchy.
  public class var tintColor: UIColor {
    return UIColor(named: "color-accent")!
  }

  /// Creates a color object using the information from the named asset.
  ///
  /// - Parameter name: The name of the asset containing the color.
  public init?(named name: SwiftString) {
    self.name = name
  }
}

#endif

//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIBarAppearance.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/6/20.
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

/// An object for customizing the basic appearance of system bars.
///
/// A ``UIBarAppearance`` object contains the common traits shared by navigation bars, tab bars, and toolbars. When configuring a specific type of bar, you usually instantiate the appropriate bar
/// appearance subclass. However, you may also create a ``UIBarAppearance`` object, configure its properties, and use it to create new bar appearance objects in your app.
///
/// ## Topics
///
/// ### Creating a custom bar appearance object
///
/// - ``init()``
///
/// ### Configuring the background appearance
///
/// - ``backgroundEffect``
///
/// ### Configuring the shadow appearance
///
/// - ``shadowColor``
@MainActor
open class UIBarAppearance {
  /// The blur effect to apply to the bar's background.
  ///
  /// The blur effect provides the base layer for the bar's appearance, and it determines how much of the underlying content is visible. UIKit applies the ``backgroundColor`` and ``backgroundImage``
  /// on top of this effect.
  public var backgroundEffect: UIBlurEffect?

  /// The color to apply to the bar's custom or default shadow.
  ///
  /// UIKit uses this property and the ``shadowImage`` property to determine the shadow's appearance. When ``shadowImage`` is `nil`, the bar displays a default shadow tinted according to the value of
  /// this property. If this property is `nil` or contains the clear color, the bar displays no shadow.
  ///
  /// If ``shadowImage`` contains a template image, the bar uses the image for the shadow and tints it using the value in this property. If this property is `nil` or contains the clear color, the bar
  /// displays no shadow. However, if ``shadowImage`` doesn't contain a template image, the bar displays the image without applying the color in this property.
  public var shadowColor: UIColor?

  /// Creates a new bar appearance object containing default values.
  public init() {}
}

#endif

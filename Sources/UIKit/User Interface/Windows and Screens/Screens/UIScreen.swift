//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIScreen.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/3/29.
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

import CoreGraphicsKit
import JavaScriptCoreKit

/// An object that defines the properties associated with a hardware-based display.
///
/// A ``UIScreen`` object provides information about the screens attached to a device. A screen object for a device has information about the integrated display or an attached display.
///
/// Avoid using screen objects to make decisions about your app's interface. Use a screen object only as needed to retrieve screen-related information, such as the screen's bounds rectangle,
/// brightness, and overscan settings.
///
/// ## Topics
///
/// ### Getting the Available Screens
///
/// - ``main``
///
/// ### Getting the size and scale
///
/// - ``bounds``
@MainActor
public class UIScreen {
  /// The screen object representing the device's screen.
  public static let main = UIScreen()

  /// The bounding rectangle of the screen, measured in pixels.
  ///
  /// This rectangle is specified in the current coordinate space, which takes into account any interface rotations in effect for the device. Therefore, the value of this property may change when the
  /// device rotates between portrait and landscape orientations.
  public var bounds: CoreGraphicsRectangle {
    return CoreGraphicsRectangle(x: 0, y: 0, width: JavaScriptCoreGlobalObject.default.width, height: JavaScriptCoreGlobalObject.default.height)
  }
}

//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIBarItem.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/10/3.
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

/// An abstract superclass for items that you can add to a bar that appears at the bottom of the screen.
///
/// Items on a bar behave in a way similar to buttons (instances of ``UIButton``). They have a title, image, action, and target. You can also enable and disable an item on a bar.
///
/// ### Customize appearance
///
/// You can customize the image to represent the item, and the position of the image, using ``image`` and ``imageInsets`` respectively.
///
/// You can also customize the title's text attributes using ``setTitleTextAttributes(_:for:)``, either for a single item, or for all items by using the appearance proxy.
///
/// ## Topics
///
/// ### Creating a bar item
///
/// - ``init()``
///
/// ### Getting and setting properties
///
/// - ``title``
/// - ``image``
/// - ``tag``
@MainActor
public class UIBarItem {
  /// The title displayed on the item.
  ///
  /// You should set this property before adding the item to a bar. The default value is `nil`.
  public var title: SwiftString?

  /// The image used to represent the item.
  ///
  /// This image can be used to create other images to represent this item on the bar—for example, a selected and unselected image may be derived from this image. You should set this property before
  /// adding the item to a bar. The default value is `nil`.
  public var image: UIImage?

  /// The bar item's tag, an app-supplied integer that you can use to identify bar item objects in your app.
  ///
  /// The default value is `0`.
  public var tag: CInteger

  /// Initializes the bar item to its default state.
  public init() {
    self.tag = 0
  }
}

#endif

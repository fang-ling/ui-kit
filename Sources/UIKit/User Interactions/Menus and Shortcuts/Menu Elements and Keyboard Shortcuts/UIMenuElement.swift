//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIMenuElement.swift
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

/// An object representing a menu, action, or command.
///
/// ``UIMenuElement`` defines the behavior shared by all menus, actions, and commands. You don't create ``UIMenuElement`` objects directly. Instead, you create an appropriate object that inherits from
/// this class, such as ``UIMenu``, ``UIAction``, or ``UICommand``.
///
/// ## Topics
///
/// ### Getting the element attributes
///
/// - ``title``
/// - ``subtitle``
/// - ``image``
@MainActor
public class UIMenuElement {
  /// The title of the menu element.
  public var title: SwiftString

  /// The subtitle to display alongside the menu element's title.
  ///
  /// Only the ``UIMenuSystem/context`` menu system supports the display of a subtitle.
  public var subtitle: SwiftString?

  /// The image to display alongside the menu element's title.
  ///
  /// Only the ``UIMenuSystem/context`` menu system supports the display of an image.
  public var image: /*UIImage*/Any?

  internal init(title: SwiftString, subtitle: SwiftString?, image: /*UIImage*/Any?) {
    self.title = title
    self.subtitle = subtitle
    self.image = image
  }
}

#endif

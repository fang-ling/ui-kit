//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIMenuLeaf.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/9/27.
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

/// An interface for an object that represents a menu element without child elements.
///
/// ``UIMenuLeaf`` defines the behavior shared by menu elements that don't have child elements. Don't implement the ``UIMenuLeaf`` protocol in your object directly. Instead, create an appropriate
/// object that implements this protocol, such as ``UIAction`` or ``UICommand``.
///
/// ## Topics
///
/// ### Managing the appearance
///
/// - ``title``
/// - ``subtitle``
/// - ``discoverabilityTitle``
/// - ``image``
/// - ``attributes``
///
/// ### Managing the selection state
///
/// - ``state``
///
/// ### Performing actions
///
/// - ``performWithSender(_:target:)``
@MainActor
public protocol UIMenuLeaf {
  /// A short display title for the menu element.
  var title: SwiftString { get set }

  /// The element's subtitle.
  var subtitle: SwiftString? { get set }

  /// A long, informative title to use in the keyboard shortcut overlay.
  var discoverabilityTitle: SwiftString? { get set }

  /// An image that appears next to the menu element.
  var image: /*UIImage?*/Any? { get set }

  /// The attributes that determine the style of the menu element.
  var attributes: /*UIMenuElement.Attributes*/Any? { get set }

  /// The menu element's selection state.
  var state: /*UIMenuElement.State*/Any? { get set }

  /// Performs the element's primary action.
  func performWithSender(_ sender: Any?, target: Any?)
}

#endif

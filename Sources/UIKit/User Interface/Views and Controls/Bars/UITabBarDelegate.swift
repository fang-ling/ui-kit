//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UITabBarDelegate.swift
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

import SwiftFramework

/// The ``UITabBarDelegate`` protocol defines optional methods for a delegate of a ``UITabBar`` object.
///
/// The ``UITabBar`` class provides the ability for the user to reorder, remove, and add items to the tab bar; this process is referred to as customizing the tab bar. The tab bar delegate receives
/// messages when customizing occurs.
///
/// Send ``beginCustomizingItems(_:)`` to a ``UITabBar`` object to begin customizing. Implement the methods in Customizing tab bars to intervene while a user is customizing a tab bar. The customizing
/// modal view is dismissed when the user taps the Done button on the modal view.
///
/// ## Topics
///
/// ### Customizing tab bars
///
/// - ``tabBar(_:didSelect:)``
@MainActor
public protocol UITabBarDelegate: SwiftAnyObject {
  /// Sent to the delegate when the user selects a tab bar item.
  ///
  /// - Parameters:
  ///   - tabBar: The tab bar that is being customized.
  ///   - item: The tab bar item that was selected.
  func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)
}

extension UITabBarDelegate {
  public func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {}
}

#endif

//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UITab.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/6/14.
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

/// An object that manages a tab in a tab bar.
///
/// To create a tab, call ``init(title:image:identifier:viewControllerProvider:)``. In the closure, return the view controller your app presents when someone selects the tab. Then pass an array of
/// tabs to your ``UITabBarController`` object's tabs property.
///
/// ## Topics
///
/// ### Creating tabs
///
/// - ``init(title:image:identifier:viewControllerProvider:)``
///
/// ### Accessing a tab's appearance
///
/// - ``title``
/// - ``identifier``
/// - ``image``
/// - ``viewController``
@MainActor
public class UITab {
  private var _viewController: UIViewController?

  private var _viewControllerProvider: ((UITab) -> UIViewController)?

  /// A tab's title.
  public var title: SwiftString

  /// A string identifier for a tab.
  public private(set) var identifier: SwiftString

  /// A tab's image.
  public var image: UIImage?

  /// The view controller that the system presents when someone selects a tab.
  public var viewController: UIViewController? {
    if self._viewController == nil {
      self._viewController = self._viewControllerProvider?(self)
    }

    return self._viewController
  }

  /// Creates a tab object.
  ///
  /// - Parameters:
  ///   - title: The tab's title.
  ///   - image: The tab's image.
  ///   - identifier: An identifier string for the tab. Each identifier must be unique across all the tabs managed by a ``UITabBarController``.
  ///   - viewControllerProvider: The view controller that the system presents when someone selects the tab.
  public init(title: SwiftString, image: UIImage?, identifier: SwiftString, viewControllerProvider: ((UITab) -> UIViewController)? = nil) {
    self.title = title
    self.image = image
    self.identifier = identifier
    self._viewControllerProvider = viewControllerProvider
  }
}

#endif

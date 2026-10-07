//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UITabBarItem.swift
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

/// An object that describes an item in a tab bar.
///
/// A tab bar item is a segment of a tab bar that represents a specific section of your app. A tab bar displays one or more items that allow the user to switch between the different sections. The user
/// can select one item at a time.
///
/// The most common approach for displaying a tab bar is to use a tab bar controller. The controller's tab bar displays an item for each view controller you provide when you set the
/// ``viewControllers`` property or call the ``setViewControllers(_:animated:)`` method. You're responsible for supplying the tab bar items. Do this by setting each view controller's ``tabBarItem``
/// property. When the user selects an item, the tab bar controller displays its view controller. For more information, see ``UITabBarController``.
///
/// You can also use a tab bar independent of a tab bar controller. After creating a tab bar, add it to your view hierarchy. Provide the items by setting the tab bar's items property or by using the
/// ``setItems(_:animated:)`` method. In this configuration, you're responsible for updating the view hierarchy to display the correct content. Use ``UITabBarDelegate`` to know when the selection
/// changes. For more information, see ``UITabBar``.
///
/// The system provides several tab bar items for common use cases. If you need a custom item, create one with a title and an image. You can further customize the item by providing an alternate image
/// that appears when the user selects it. By default, the item doesn't display the images you provide. Instead, it generates new images from the alpha values of your images and tints them. To prevent
/// this, provide images that use the ``UIImage/RenderingMode/alwaysOriginal`` rendering mode.
///
/// An item can adjust its appearance when in certain conditions. For example, you can specify different appearances for inline and compact inline layouts or for when the item's state changes. To do
/// this, set the item's ``standardAppearance`` property. If you don't want this behavior, you can set the individual properties on the item instead.
///
/// A tab bar item can display a supplementary value in a badge that provides extra information to the user. For example, the Phone app uses a badge's value to display the number of missed calls. You
/// can customize the badge's appearance, including its background color and text attributes.
///
/// ## Topics
///
/// ### Creating a tab bar item
///
/// - ``init(title:image:tag:)``
@MainActor
public class UITabBarItem: UIBarItem {
  internal var _identifier: SwiftString?

  internal convenience init(title: SwiftString?, image: UIImage?, tag: CInteger, identifier: SwiftString) {
    self.init(title: title, image: image, tag: tag)

    self._identifier = identifier
  }

  /// Creates a tab bar item that displays a title and an image.
  ///
  /// Use `nil` for `title` or `image` to not display that element.
  ///
  /// By default, the item displays the same image regardless of its selected state. To display a different image for the selected state, set its ``selectedImage`` property. The item creates the
  /// images it displays from the alpha values in the source images. To prevent system tinting, use images with the ``UIImage/RenderingMode/alwaysOriginal`` rendering mode. The item clips any image
  /// that's larger than its bounds.
  ///
  /// - Parameters:
  ///   - title: The item's title.
  ///   - image: The item's source image.
  ///   - tag: An integer you use to identify the object.
  public convenience init(title: SwiftString?, image: UIImage?, tag: CInteger) {
    self.init()

    self.title = title
    self.image = image
    self.tag = tag
  }
}

#endif

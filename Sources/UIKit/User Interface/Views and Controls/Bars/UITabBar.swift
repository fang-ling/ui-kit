//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UITabBar.swift
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

import CKit
import CoreGraphicsKit

/// A control that displays one or more buttons in a tab bar for selecting between different subtasks, views, or modes in an app.
///
/// Typically, you use tab bars in conjunction with a ``UITabBarController`` object, but you can also use them as standalone controls in your app. Tab bars always appear across the bottom edge of the
/// screen and display the contents of one or more ``UITabBarItem`` objects. A tab bar's appearance can be customized with a background image or tint color to suit the needs of your interface. Tapping
/// an item selects and highlights that item, and you use the selection of the item to enable the corresponding mode for your app.
///
/// A ``UITabBarController`` object provides its own tab bar object and you must configure the object provided to you. When creating a tab bar programmatically, use the ``init(frame:)`` method or
/// another view initializer method to set its initial configuration. Use the methods of this class to configure the appearance of the tab bar. For tab bars you create yourself, you also use the
/// methods of this class to specify the items displayed by the tab bar.
///
/// > Note: The ``UITabBar`` class and ``UIToolbar`` classes have similar appearances but different purposes. Use tab bars to convey and change your app's mode. Use toolbars to present the user with a
///   set of actions that are relevant to the currently presented content.
///
/// A tab bar reports selections and user customizations to its delegate object. For tab bars you create yourself, use the delegate to respond to selections or to the addition, removal, or reordering
/// of items in the tab bar. (A ``UITabBarController`` object acts as the delegate for the tab bar it manages.) For more information on implementing a tab bar delegate, see ``UITabBarDelegate``.
///
/// ### Configure the tab bar items
///
/// How you configure items at design time depends on whether your tab bar is associated with a ``UITabBarController`` object:
///
///   - To configure the tab bar associated with a ``UITabBarController`` object, configure the view controllers associated with the tab bar controller. The tab bar automatically obtains its items
///     from the ``tabBarItem`` property of each view controller associated with the tab bar controller.
///   - To configure tab bar items directly, use the ``setItems(_:animated:)`` method of the tab bar itself.
///
/// A tab bar displays all of its tabs onscreen at once, using the ``itemPositioning`` property to determine how to position items in the available space. If you have more items than can fit in the
/// available space, display only a subset of them and let the user select which tabs are displayed. The ``beginCustomizingItems(_:)`` method displays an interface for selecting which tab bar items to
/// display.
///
/// The contents of each item are stored in a ``UITabBarItem`` object. Each item contains a title and an image to display in the tab. You can also use tab bar items to add a badge to the corresponding
/// tab. For more information about creating and configuring items, see ``UITabBarItem``.
///
/// ### Respond to tab selections
///
/// For tab bars with an associated tab bar controller, the tab bar controller automatically manages selections and displays the appropriate view controller. The only time you have to manage
/// selections yourself is when you create the tab bar without a tab bar controller. The tab bar reports selections to the ``tabBar(_:didSelect:)`` method of its delegate object, which you can use to
/// respond to selection changes. For more information about implementing the delegate object, see ``UITabBarDelegate``.
///
/// ### Internationalize a tab bar
///
/// To internationalize a tab bar, you must provide localized strings for the tab bar item titles.
///
/// ### Make a tab bar accessible
///
/// Tab bars are accessible by default.
///
/// ## Topics
///
/// ### Customizing the tab bar behavior
///
/// - ``delegate``
/// - ``UITabBarDelegate``
///
/// ### Configuring tab bar items
///
/// - ``items``
/// - ``setItems(_:animated:)``
/// - ``selectedItem``
@MainActor
public class UITabBar: UIView {
  /// The tab bar's delegate object.
  ///
  /// Use the delegate to track the selection of tab bar items and to respond to the user customization of the tab bar. The default value of this property is `nil`.
  ///
  /// For more information on how to implement the methods of this protocol, see ``UITabBarDelegate``.
  public weak var delegate: (any UITabBarDelegate)?

  /// The items displayed by the tab bar.
  ///
  /// This property contains an array of ``UITabBarItem`` objects, each of which corresponds to a tab displayed by the tab bar. The order of the items in this property corresponds to the order of the
  /// items onscreen. You can use this property to access the items as needed.
  ///
  /// For tab bars you create, you can assign a new set of items to this property to change the displayed items. Changing the items replaces them immediately without animations. You must not modify
  /// this property if the tab bar is managed by a ``UITabBarController`` object, and doing so raises an exception. When the tab bar is owned by a tab bar controller, use the tab bar controller's
  /// methods to make changes.
  ///
  /// The default value of this property is `nil`.
  public var items: [UITabBarItem]? {
    didSet {
      for index in self.subviews.indices.reversed() {
        if let button = self.subviews[index] as? UIButton {
          button.removeFromSuperview()
        }
      }

      if let items = self.items {
        for index in 0 ..< items.count {
          var configuration = UIButton.Configuration.plain()
          configuration.title = items[index].title
          configuration.image = items[index].image
          configuration.imagePlacement = .top
          configuration.imagePadding = 4

          let button = UIButton(
            configuration: configuration,
            primaryAction: UIAction { _ in
              self.selectedItem = items[index]
              self.delegate?.tabBar(self, didSelect: items[index])
            }
          )
          button.frame = CoreGraphicsRectangle(
            x: CFloatingPoint64(index) * self.frame.size.width / CFloatingPoint64(items.count),
            y: 6,
            width: self.frame.size.width / CFloatingPoint64(items.count),
            height: 40
          )
          button.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .medium)

          self.addSubview(button)
        }
      }

      self.setNeedsLayout()
      self.setNeedsDisplay()
    }
  }

  /// The currently selected item on the tab bar.
  ///
  /// Use this property to get the currently selected item. If you change the value of this property, the tab bar selects the corresponding item and updates the tab bar's appearance accordingly. Set
  /// the property to `nil` to clear the selection.
  ///
  /// When an item is selected, the tab bar displays the image in the tab bar item's ``selectedImage`` property. If the ``selectedImageTintColor`` property is set, the tab bar also applies the color
  /// in that property to the selected image. To prevent system coloring of an item, provide images using the ``UIImage/RenderingMode/alwaysOriginal`` rendering mode.
  ///
  /// The default value for this property is `nil`.
  public weak var selectedItem: UITabBarItem? {
    didSet {
      if self.selectedItem === oldValue {
        return
      }

      if let selectedItem = self.selectedItem {
        let selectedIndex = self.items?.firstIndex(where: { $0 === selectedItem })

        var buttonIndex = 0
        for subview in self.subviews {
          if let button = subview as? UIButton {
            button.configurationUpdateHandler = { button in
              button.configuration?.baseForegroundColor = buttonIndex == selectedIndex ? UIColor.tintColor : UIColor(named: "color-tab-unselected")
            }
            button.setNeedsUpdateConfiguration()

            buttonIndex += 1
          }
        }
      }
    }
  }

  /// Sets the items on the tab bar, optionally animating any changes into position.
  ///
  /// Use this method to make changes to the currently visible items at runtime. Calling this method on a tab bar that is managed by a ``UITabBarController`` object raises an exception. When the tab
  /// bar is owned by a tab bar controller, use the tab bar controller's methods to make changes to items.
  ///
  /// - Parameters:
  ///   - items: The array of ``UITabBarItem`` objects to display.
  ///   - animated: A Boolean indicating whether changes should be animated. Specify `true` to animate changes or `false` to display the new items without animations. When animations are enabled, the
  ///     tab bar fades out removed items and fades in new items, adjusting the spacing between items as needed.
  public func setItems(_ items: [UITabBarItem]?, animated: CBoolean) {
    self.items = items
  }
}

#endif

//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UITabBarController.swift
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

import CoreGraphicsKit

/// A container view controller that manages a multiselection interface, where the selection determines which child view controller to display.
///
/// The tab bar interface displays tabs at the bottom of the window for selecting between the different modes and for displaying the views for that mode. This class is generally used as-is, but may
/// also be subclassed.
///
/// Each tab of a tab bar controller interface is associated with a custom view controller. When the user selects a specific tab, the tab bar controller displays the root view of the corresponding
/// view controller, replacing any previous views. (User taps always display the root view of the tab, regardless of which tab was previously selected. This is true even if the tab was already
/// selected.) Because selecting a tab replaces the contents of the interface, the type of interface managed in each tab need not be similar in any way. In fact, tab bar interfaces are commonly used
/// either to present different types of information or to present the same information using a completely different style of interface.
///
/// You should never access the tab bar view of a tab bar controller directly. To configure the tabs of a tab bar controller, you assign the view controllers that provide the root view for each tab to
/// the ``viewControllers`` property. The order in which you specify the view controllers determines the order in which they appear in the tab bar. When setting this property, you should also assign a
/// value to the ``selectedViewController`` property to indicate which view controller is selected initially. (You can also select view controllers by array index using the ``selectedIndex``
/// property.) When you embed the tab bar controller's view (obtained using the inherited ``view`` property) in your app window, the tab bar controller automatically selects that view controller and
/// displays its contents, resizing them as needed to fit the tab bar interface.
///
/// Tab bar items are configured through their corresponding view controller. To associate a tab bar item with a view controller, create a new instance of the ``UITabBarItem`` class, configure it
/// appropriately for the view controller, and assign it to the view controller's ``tabBarItem`` property. If you don't provide a custom tab bar item for your view controller, the view controller
/// creates a default item containing no image and the text from the view controller's ``title`` property.
///
/// As the user interacts with a tab bar interface, the tab bar controller object sends notifications about the interactions to its delegate. The delegate can be any object you specify but must
/// conform to the ``UITabBarControllerDelegate`` protocol. You can use the delegate to prevent specific tab bar items from being selected and to perform additional tasks when tabs are selected. You
/// can also use the delegate to monitor changes to the tab bar that are made by the More navigation controller.
///
/// ### The views of a tab bar controller
///
/// Because the ``UITabBarController`` class inherits from the ``UIViewController`` class, tab bar controllers have their own view that's accessible through the ``view`` property. The view for a tab
/// bar controller is just a container for a tab bar view and the view containing your custom content. The tab bar view provides the selection controls for the user and consists of one or more tab bar
/// items. Although the items in the tab bar and toolbar views can change, the views that manage them don't. Only the custom content view changes to reflect the view controller for the currently
/// selected tab.
///
/// You can use navigation controllers or custom view controllers as the root view controller for a tab. If the root view controller is a navigation controller, the tab bar controller makes further
/// adjustments to the size of the displayed navigation content so that it doesn't overlap the tab bar. Any views you display in a tab bar interface should therefore have their ``autoresizingMask``
/// property set to resize the view appropriately under any conditions.
///
/// ### The More navigation controller
///
/// The tab bar has limited space for displaying your custom items. If you add six or more custom view controllers to a tab bar controller, the tab bar controller displays only the first four items
/// plus the standard More item on the tab bar. Tapping the More item brings up a standard interface for selecting the remaining items.
///
/// The interface for the standard More item includes an Edit button that allows the user to reconfigure the tab bar. By default, the user is allowed to rearrange all items on the tab bar. If you do
/// not want the user to modify some items, though, you can remove the appropriate view controllers from the array in the ``customizableViewControllers`` property.
///
/// ### State preservation
///
/// When you assign a value to this view controller's ``restorationIdentifier`` property, it preserves a reference to the view controller in the selected tab. At restore time, it uses the reference to
/// select the tab with the same view controller.
///
/// When preserving a tab bar controller, assign unique restoration identifiers to the child view controllers you want to preserve. Omitting a restoration identifier from a child view controller
/// causes that tab to return to its default configuration. Although the tab bar controller saves its tabs in the same order that they are listed in the ``viewControllers`` property, the save order is
/// actually irrelevant. Your code is responsible for providing the new tab bar controller during the next launch cycle, so your code can adjust the order of the tabs as needed. The state preservation
/// system restores the contents of each tab based on the assigned restoration identifier, not based on the position of the tab.
///
/// ## Topics
///
/// ### Creating tab bar controllers
///
/// - ``init(tabs:)``
///
/// ### Assigning tabs
///
/// - ``tabs``
///
/// ### Managing the selected tab
///
/// - ``selectedTab``
///
/// ### Accessing the tab bar controller properties
///
/// - ``tabBar``
@MainActor
public class UITabBarController: UIViewController, UITabBarDelegate {
  private var _contentView: UIView?

  private var _tabBar: UITabBar?

  /// An array of tabs that the tab bar displays.
  public var tabs: [UITab]

  /// The currently selected tab, which can be a root tab or any of their descendants.
  public var selectedTab: UITab? {
    didSet {
      if self.selectedTab === oldValue {
        return
      }

      oldValue?.viewController?.view.removeFromSuperview()
      oldValue?.viewController?.removeFromParent()

      if let viewController = self.selectedTab?.viewController, let contentView = self._contentView {
        self.addChild(viewController)
        viewController.view.frame = contentView.bounds
        contentView.addSubview(viewController.view)
      }

      self.tabBar.selectedItem = self.tabBar.items?.first(where: { $0._identifier == selectedTab?.identifier })
    }
  }

  /// The tab bar view associated with this controller.
  ///
  /// You should never attempt to manipulate the ``UITabBar`` object itself stored in this property. If you attempt to do so, the tab bar view throws an exception. To configure the items for your tab
  /// bar interface, you should instead assign one or more custom view controllers to the ``viewControllers`` property. The tab bar collects the needed tab bar items from the view controllers you
  /// specify.
  ///
  /// The tab bar view provided by this property is only for situations where you want to display an action sheet using the ``show(from:)`` method of the ``UIActionSheet`` class.
  public var tabBar: UITabBar {
    if let tabBar = self._tabBar {
      return tabBar
    } else {
      let tabBar = UITabBar(frame: CoreGraphicsRectangle(x: 0, y: UIScreen.main.bounds.size.height - 83, width: UIScreen.main.bounds.size.width, height: 83))

      self._tabBar = tabBar
      self._tabBar?.delegate = self
      self._tabBar?.setItems(self.tabs.enumerated().map({ UITabBarItem(title: $0.1.title, image: $0.1.image, tag: $0.0, identifier: $0.1.identifier) }), animated: true)

      self.view.addSubview(tabBar)

      return tabBar
    }
  }

  /// Creates a tab bar controller with the specified tabs.
  ///
  /// - Parameter tabs: An array of tabs that the tab bar displays.
  public init(tabs: [UITab]) {
    self.tabs = tabs
  }

  private func setupContentView() {
    let view = UIView(frame: UIScreen.main.bounds)
    self._contentView = view

    self.view.addSubview(view)
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

    self.setupContentView()

    if self.tabs.count > 0 {
      self.selectedTab = self.tabs[0]
    }
  }

  public func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    self.selectedTab = self.tabs.first(where: { $0.identifier == item._identifier })
  }
}

#endif

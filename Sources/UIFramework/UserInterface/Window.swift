//
//  Window.swift
//  ui-framework
//
//  Created by Fang Ling on 2026/3/22.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import FoundationFramework
import JavaScriptBridgeFramework

/// The backdrop for your app's user interface and the object that dispatches
/// events to your views.
///
/// Windows work with your view controllers to handle events and to perform many
/// other tasks that are fundamental to your app's operation. System handles
/// most window-related interactions, working with other objects as needed to
/// implement many app behaviors.
///
/// You use windows only when you need to do the following:
///   - Provide a main window to display your app's content.
///   - Create additional windows (as needed) to display additional content.
///
/// Most apps need only one window, which displays the app's content on the
/// device's main screen.
///
/// You also use ``Window`` objects for a handful of other tasks:
///   - Setting the z-axis level of your window, which affects the visibility of
///     the window relative to other windows.
///   - Showing windows and making them the target of keyboard events.
///   - Converting coordinate values to and from the window's coordinate system.
///   - Changing the root view controller of a window.
///   - Changing the screen on which the window is displayed.
///
/// Windows don't have any visual appearance of their own. Instead, a window
/// hosts one or more views, which are managed by the window's root view
/// controller. You configure the root view controller, adding whatever views
/// are appropriate for your interface.
///
/// You should rarely need to subclass ``Window``. The kinds of behaviors you
/// might implement in a window can usually be implemented in a higher-level
/// view controller more easily. One of the few times you might want to subclass
/// is to override the ``becomeKeyWindow`` or ``resignKeyWindow`` methods to
/// implement custom behaviors when a window's key status changes. For
/// information about how to display a window on a specific screen, see
/// ``Screen``.
///
/// ### Understand keyboard interactions
///
/// Whereas touch events are delivered to the window where they occurred, events
/// that don't have a relevant coordinate value are delivered to the key window.
/// Only one window at a time can be the key window, and you can use a window's
/// ``keyWindow`` property to determine its status. Most of the time, your app's
/// main window is the key window, but system may designate a different window
/// as needed.
@available(macOS 13.3.0, *)
@MainActor public class Window: View {
  /// Initializes the window with the specified values.
  ///
  /// - Parameter frame: Origin and size of the window's content area in screen
  ///   coordinates.
  public override init(frame: Rectangle) {
    super.init(frame: frame)

    next = Application.shared

    isHidden = true
  }

  public var rootViewController: ViewController? {
    didSet {
      if oldValue === rootViewController {
        return
      }

      oldValue?.view?.removeFromSuperview()

      guard let viewController = rootViewController else {
        return
      }

      addSubview(viewController.view)
    }
  }

  public func makeKeyAndVisible() {
    Application.shared.windows.append(self)
    isHidden = false
  }
}

//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIApplication.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/3/22.
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

import FoundationKit
import CoreAnimationKit

/// The centralized point of control and coordination for apps using UIKit.
///
/// Every UIKit app has exactly one instance of ``UIApplication`` (or, very rarely, a subclass of ``UIApplication``). When an app launches, the system calls the ``UIApplicationMain(_:_:_:_:)``
/// function. Among its other tasks, this function creates a singleton ``UIApplication`` object that you access using ``shared``.
///
/// Your app's application object handles the initial routing of incoming user events. It dispatches action messages forwarded to it by control objects (instances of the ``UIControl`` class) to
/// appropriate target objects. The application object maintains a list of open windows (``UIWindow`` objects), which it can use to retrieve any of the app's ``UIView`` objects.
///
/// The ``UIApplication`` class defines a delegate that conforms to the ``UIApplicationDelegate`` protocol and must implement some of the protocol's methods. The application object informs the
/// delegate of significant runtime events—for example, app launch, low-memory warnings, and app termination—giving it an opportunity to respond appropriately.
///
/// Apps can cooperatively handle a resource, such as an email or an image file, through the ``open(_:options:completionHandler:)`` method. For example, an app that calls this method with an email URL
/// causes the Mail app to launch and display the message.
///
/// The APIs in this class allow you to manage device-specific behavior. Use your ``UIApplication`` object to do the following:
///
///   - Temporarily suspend incoming touch events (``beginIgnoringInteractionEvents()``)
///   - Register for remote notifications (``registerForRemoteNotifications()``)
///   - Trigger the undo-redo UI (``applicationSupportsShakeToEdit``)
///   - Determine whether there is an installed app registered to handle a URL scheme (``canOpenURL(_:)``)
///   - Extend the execution of the app so that it can finish a task in the background (``beginBackgroundTask(expirationHandler:)`` and ``beginBackgroundTask(withName:expirationHandler:)``)
///   - Schedule and cancel local notifications (``scheduleLocalNotification(_:)`` and ``cancelLocalNotification(_:)``)
///   - Coordinate the reception of remote-control events (``beginReceivingRemoteControlEvents()`` and ``endReceivingRemoteControlEvents()``)
///   - Perform app-level state restoration tasks
///
/// ### Subclassing notes
///
/// Most apps don't need to subclass ``UIApplication``. Instead, use an app delegate to manage interactions between the system and the app.
///
/// If your app must handle incoming events before the system does—a very rare situation—you can implement a custom event or action dispatching mechanism. To do this, subclass ``UIApplication`` and
/// override the ``sendEvent(_:)`` and/or the ``sendAction(_:to:from:for:)`` methods. For every event you intercept, after you handle the event, dispatch it back to the system by calling:
///
///    ```swift
///    super.sendEvent(event)
///    ```
///
/// Intercepting events is only rarely required and you should avoid it if possible.
///
/// ## Topics
///
/// ### Accessing the shared application
///
/// - ``shared``
///
/// ### Configuring your app's behavior
///
/// - ``delegate``
///
/// ### Accessing App Windows
///
/// - ``keyWindow``
/// - ``windows``
@MainActor
open class UIApplication: UIResponder {
  internal static var _shared = UIApplication()

  /// The singleton app instance.
  ///
  /// The ``UIApplicationMain(_:_:_:_:)`` function creates the shared app instance at launch time.
  public class var shared: UIApplication! {
    return self._shared
  }

  /// The delegate of the app object.
  ///
  /// Every app must have an app delegate object to respond to app-related messages. For example, the app notifies its delegate when the app finishes launching and when its foreground or background
  /// execution status changes. Similarly, app-related messages coming from the system are often routed to the app delegate for handling.
  ///
  /// The delegate must adopt the ``UIApplicationDelegate`` formal protocol.
  public weak var delegate: (any UIApplicationDelegate)?

  /// The app's key window.
  ///
  /// This property holds the ``UIWindow`` object in the windows array that is most recently sent the ``UIWindow/makeKeyAndVisible()`` message.
  public var keyWindow: UIWindow? {
    return self.windows.first(where: { $0.isKeyWindow })
  }

  /// The app's visible and hidden windows.
  ///
  /// This property contains the ``UIWindow`` objects currently associated with the app. This list doesn't include windows created and managed by the system, such as the window used to display the
  /// status bar.
  ///
  /// The array orders the windows from back to front by window level; thus, the last window in the array is on top of all other app windows.
  public var windows: FoundationArray<UIWindow> = []
}

@MainActor
internal func UIApplicationMain(delegate: UIApplicationDelegate) {
  UIApplication.shared.delegate = delegate

  _ = UIApplication.shared.delegate?.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)

  // Initial rendering.
  if let keyWindow = UIApplication.shared.keyWindow {
    CoreAnimationTransaction._flush(with: keyWindow.layer)
  }
}

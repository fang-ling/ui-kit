//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIApplicationDelegate.swift
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

import CKit

/// A set of methods to manage shared behaviors for your app.
///
/// Your app delegate object manages your app's shared behaviors. The app delegate is effectively the root object of your app, and it works in conjunction with ``UIApplication`` to manage some
/// interactions with the system. Like the ``UIApplication`` object, UIKit creates your app delegate object early in your app's launch cycle so it's always present.
///
/// Use your app delegate object to handle the following tasks:
///
///   - Initializing your app's central data structures
///   - Configuring your app's scenes
///   - Responding to notifications originating from outside the app, such as low-memory warnings, download completion notifications, and more
///   - Responding to events that target the app itself, and aren't specific to your app's scenes, views, or view controllers
///   - Registering for any required services at launch time
///
/// ## Topics
///
/// ### Creating a delegate
///
/// - ``init()``
///
/// ### Initializing the app
///
/// - ``application(_:didFinishLaunchingWithOptions:)``
///
/// ### Providing a window
///
/// - ``window``
///
/// ### Providing the main entry point
///
/// - ``main()``
@MainActor
public protocol UIApplicationDelegate: AnyObject {
  /// This property contains the window used to present the app's visual content on the device's main screen.
  var window: UIWindow? { get set }

  /// Creates a new delegate object.
  ///
  /// The system calls this method to initialize the delegate object in your app's `main` function.
  init()

  /// Tells the delegate that the launch process is almost done and the app is almost ready to run.
  ///
  /// Use this method (and the corresponding ``application(_:willFinishLaunchingWithOptions:)`` method) to complete your app's initialization. In an app that supports scenes:
  ///
  ///   - The system calls this method as soon as the process is done launching.
  ///   - The system then creates the scene(s) that you configured for your app.
  ///   - The system calls scene life-cycle methods, such as ``scene(_:willConnectTo:options:)``.
  ///   - As the system presents a scene, it updates that scene's ``activationState``. The app's state is the aggregate of all the scene ``UIScene.ActivationState`` values.
  ///
  /// In an app that doesn't support scenes:
  ///
  ///   - The system performs state restoration before calling this method.
  ///   - The system calls this method when the process is done launching.
  ///   - The system presents your app's window, scene(s), and other UI.
  ///   - At some point after this method returns, the system calls another of your app delegate's methods to move the app to the active (foreground) state or the background state.
  ///
  /// This method represents your last chance to process any keys in the `launchOptions` dictionary. If you didn't evaluate the keys in your ``application(_:willFinishLaunchingWithOptions:)`` method,
  /// review them in this method and provide an appropriate response.
  ///
  /// Objects that aren't the app delegate can access the same `launchOptions` dictionary values by observing the notification named ``didFinishLaunchingNotification`` and accessing the
  /// notification's ``userInfo`` dictionary. The system sends that notification shortly after this method returns.
  ///
  /// The system combines the return result from this method with the return result from the ``application(_:willFinishLaunchingWithOptions:)`` method to determine whether to handle a URL. If either
  /// method returns `false`, the system doesn't handle the URL. If you don't implement one of the methods, the system only considers the return value of the implemented method.
  ///
  /// - Parameters:
  ///   - application: The singleton app object.
  ///   - launchOptions: A dictionary indicating the reason the person or system launched the app. The contents of this dictionary may be empty in situations where a person launched the app directly.
  ///     If the app supports scenes, this is `nil`. For information about the possible keys in this dictionary and how to handle them, see ``UIApplication.LaunchOptionsKey``.
  ///
  /// - Returns: Return `false` if the app can't handle the URL resource or continue a user activity, otherwise return `true`. The system ignores the return value if the app launches as a result of a
  ///   remote notification.
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: /*[UIApplication.LaunchOptionsKey : Any]*/Any?) -> CBoolean

  /// Provides the top-level entry point for the app.
  ///
  /// ``UIApplicationDelegate`` provides an implementation of the ``main()`` method so that it can serve as the main entry point for a UIKit app. The system calls the ``main()`` method to launch your
  /// app; you never call it yourself. You can have exactly one entry point in your app, which you mark with the `@main` attribute.
  static func main()
}

extension UIApplicationDelegate {
  public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: /*[UIApplication.LaunchOptionsKey : Any]*/Any?) -> CBoolean {
    return true
  }

  public static func main() {
    UIApplicationMain(delegate: Self.init())
  }
}

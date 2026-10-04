//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIResponder.swift
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

#if !os(iOS)

import SwiftFramework

/// An abstract interface for responding to and handling events.
///
/// Responder objects — instances of ``UIResponder`` — constitute the event-handling backbone of a UIKit app. Many key objects are also responders, including the ``UIApplication`` object,
/// ``UIViewController`` objects, and all ``UIView`` objects (which includes ``UIWindow``). As events occur, UIKit dispatches them to your app's responder objects for handling.
///
/// There are several kinds of events, including touch events, motion events, remote-control events, and press events. To handle a specific type of event, a responder must override the corresponding
/// methods. For example, to handle touch events, a responder implements the ``touchesBegan(_:with:)``, ``touchesMoved(_:with:)``, ``touchesEnded(_:with:)``, and ``touchesCancelled(_:with:)`` methods.
/// In the case of touches, the responder uses the event information provided by UIKit to track changes to those touches and to update the app's interface appropriately.
///
/// In addition to handling events, UIKit responders also manage the forwarding of unhandled events to other parts of your app. If a given responder doesn't handle an event, it forwards that event to
/// the next event in the responder chain. UIKit manages the responder chain dynamically, using predefined rules to determine which object should be next to receive an event. For example, a view
/// forwards events to its superview, and the root view of a hierarchy forwards events to its view controller.
///
/// Responders process ``UIEvent`` objects but can also accept custom input through an input view. The system's keyboard is the most obvious example of an input view. When the user taps a
/// ``UITextField`` and ``UITextView`` object onscreen, the view becomes the first responder and displays its input view, which is the system keyboard. Similarly, you can create custom input views and
/// display them when other responders become active. To associate a custom input view with a responder, assign that view to the ``inputView`` property of the responder.
///
/// ## Topics
///
/// ### Creating a responder
///
/// - ``init()``
///
/// ### Managing the responder chain
///
/// - ``next``
///
/// ### Responding to touch events
///
/// - ``touchesBegan(_:with:)``
/// - ``touchesMoved(_:with:)``
/// - ``touchesEnded(_:with:)``
/// - ``touchesCancelled(_:with:)``
@MainActor
open class UIResponder {
  /// The next responder in the responder chain, or `nil` if there's no next responder.
  ///
  /// The ``UIResponder`` class doesn't store or set the next responder automatically, so this method returns `nil` by default. Subclasses must override this method and return an appropriate next
  /// responder. For example, ``UIView`` implements this method and returns the ``UIViewController`` object that manages it (if it has one) or its superview (if it doesn't). ``UIViewController``
  /// similarly implements the method and returns its view's superview. ``UIWindow`` returns the application object. The shared ``UIApplication`` object normally returns `nil`, but it returns its app
  /// delegate if that object is a subclass of ``UIResponder`` and hasn't already been called to handle the event.
  open var next: UIResponder? {
    return nil
  }

  /// Creates a new responder object.
  ///
  /// The default implementation does nothing; subclasses can override this method to perform whatever actions are necessary.
  public init() {}

  /// Tells this object that one or more new touches occurred in a view or window.
  ///
  /// UIKit calls this method when a new touch is detected in a view or window. Many UIKit classes override this method and use it to handle the corresponding touch events. The default implementation
  /// of this method forwards the message up the responder chain. When creating your own subclasses, call `super` to forward any events that you don't handle yourself, like in the following code.
  ///
  ///    ```swift
  ///    super.touchesBegan(touches, with: event)
  ///    ```
  ///
  /// If you override this method without calling `super` (a common use pattern), you must also override the other methods for handling touch events, even if your implementations do nothing.
  ///
  /// - Parameters:
  ///   - touches: A set of ``UITouch`` instances that represent the touches for the starting phase of the event, which is represented by event. For touches in a view, this set contains only one touch
  ///     by default. To receive multiple touches, you must set the view's ``isMultipleTouchEnabled`` property to `true`.
  ///   - event: The event to which the touches belong.
  public func touchesBegan(_ touches: SwiftSet<UITouch>, with event: UIEvent?) {
    self.next?.touchesBegan(touches, with: event)
  }

  /// Tells the responder when one or more touches associated with an event changed.
  ///
  /// UIKit calls this method when the location or force of a touch changes. Many UIKit classes override this method and use it to handle the corresponding touch events. The default implementation of
  /// this method forwards the message up the responder chain. When creating your own subclasses, call `super` to forward any events that you don't handle yourself, like in the following code.
  ///
  ///    ```swift
  ///    super.touchesMoved(touches, with: event)
  ///    ```
  ///
  /// If you override this method without calling `super` (a common use pattern), you must also override the other methods for handling touch events, even if your implementations do nothing.
  ///
  /// - Parameters:
  ///   - touches: A set of ``UITouch`` instances that represent the touches whose values changed. These touches all belong to the specified event. For touches in a view, this set contains only one
  ///     touch by default. To receive multiple touches, you must set the view's ``isMultipleTouchEnabled`` property to `true`.
  ///   - event: The event to which the touches belong.
  public func touchesMoved(_ touches: SwiftSet<UITouch>, with event: UIEvent?) {
    self.next?.touchesMoved(touches, with: event)
  }

  /// Tells the responder when one or more fingers are raised from a view or window.
  ///
  /// UIKit calls this method when a finger or Apple Pencil is no longer touching the screen. Many UIKit classes override this method and use it to clean up state involved in the handling of the
  /// corresponding touch events. The default implementation of this method forwards the message up the responder chain. When creating your own subclasses, call `super` to forward any events that you
  /// don't handle yourself, like in the following code.
  ///
  ///    ```swift
  ///    super.touchesEnded(touches, with: event)
  ///    ```
  ///
  /// If you override this method without calling `super` (a common use pattern), you must also override the other methods for handling touch events, even if your implementations do nothing.
  ///
  /// - Parameters:
  ///   - touches: A set of ``UITouch`` instances that represent the touches for the ending phase of the event represented by event. For touches in a view, this set contains only one touch by default.
  ///     To receive multiple touches, you must set the view's ``isMultipleTouchEnabled`` property to `true`.
  ///   - event: The event to which the touches belong.
  public func touchesEnded(_ touches: SwiftSet<UITouch>, with event: UIEvent?) {
    self.next?.touchesEnded(touches, with: event)
  }

  /// Tells the responder when a system event (such as a system alert) cancels a touch sequence.
  ///
  /// UIKit calls this method when it receives a system interruption requiring cancellation of the touch sequence. An interruption is anything that causes the application to become inactive or causes
  /// the view handling the touch events to be removed from its window. Your implementation of this method should clean up any state associated with handling the touch sequence. The default
  /// implementation of this method forwards the message up the responder chain. When creating your own subclasses, call `super` to forward any events that you don't handle yourself, like in the
  /// following code.
  ///
  ///    ```swift
  ///    super.touchesCancelled(touches, with: event)
  ///    ```
  ///
  /// If you override this method without calling `super` (a common use pattern), you must also override the other methods for handling touch events, if only as stub (empty) implementations.
  ///
  /// - Parameters:
  ///   - touches: A set of ``UITouch`` instances that represent the touches for the ending phase of the event represented by event. For touches in a view, this set contains only one touch by default.
  ///     To receive multiple touches, you must set the view's ``isMultipleTouchEnabled`` property to `true`.
  ///   - event: The event to which the touches belong.
  public func touchesCancelled(_ touches: SwiftSet<UITouch>, with event: UIEvent?) {
    self.next?.touchesCancelled(touches, with: event)
  }
}

#endif

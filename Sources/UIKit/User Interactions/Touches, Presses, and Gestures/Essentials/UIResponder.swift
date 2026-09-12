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
/// ### Managing the responder chain
///
/// - ``next``
@MainActor
open class UIResponder {
  /// Returns the next responder in the responder chain, or `nil` if there's no next responder.
  ///
  /// The ``UIResponder`` class doesn't store or set the next responder automatically, so this method returns `nil` by default. Subclasses must override this method and return an appropriate next
  /// responder. For example, ``UIView`` implements this method and returns the ``UIViewController`` object that manages it (if it has one) or its superview (if it doesn't). ``UIViewController``
  /// similarly implements the method and returns its view's superview. ``UIWindow`` returns the application object. The shared ``UIApplication`` object normally returns `nil`, but it returns its app
  /// delegate if that object is a subclass of ``UIResponder`` and hasn't already been called to handle the event.
  ///
  /// - Returns: The next object in the responder chain, or `nil` if this is the last object in the chain.
  open var next: UIResponder? {
    return nil
  }
}

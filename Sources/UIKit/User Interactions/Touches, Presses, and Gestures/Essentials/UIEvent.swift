//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIEvent.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/9/20.
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

/// An object that describes a single user interaction with your app.
///
/// Apps can receive many different types of events, including touch events, motion events, remote-control events, and press events. Touch events are the most common and are delivered to the view in
/// which the touch originally occurred. You can determine the type of an event using the ``type`` and ``subtype`` properties.
///
/// A touch event object contains the touches (that is, the fingers on the screen) that have some relation to the event. A touch event object may contain one or more touches, and each touch is
/// represented by a ``UITouch`` object. When a touch event occurs, the system routes it to the appropriate responder and calls the appropriate method, such as ``UIResponder/touchesBegan(_:with:)``.
/// The responder then uses the touches to determine an appropriate course of action.
///
/// During a multitouch sequence, UIKit reuses the same ``UIEvent`` object when delivering updated touch data to your app. You should never retain an event object or any object returned from an event
/// object. If you need to retain data outside of the responder method you use to process that data, copy that data from the ``UITouch`` or ``UIEvent`` object to your local data structures.
///
/// ## Topics
///
/// ### Getting the touches for an event
///
/// - ``allTouches``
///
/// ### Getting the event type
///
/// - ``type``
/// - ``UIEvent/EventType``
@MainActor
public class UIEvent {
  // TODO: Use a dictionary to specify the views and windows.
  internal var _allTouches: SwiftSet<UITouch> = []

  /// All touches associated with the event.
  ///
  /// If the touches of the event originate in different views and windows, the ``UITouch`` objects obtained from this method will be associated with different responder objects.
  public var allTouches: SwiftSet<UITouch>? {
    return self._allTouches
  }

  /// The type of the event.
  ///
  /// The ``UIEvent/EventType`` constant returned by this property indicates the general type of this event — for example, whether it's a touch or motion event.
  public private(set) var type: EventType

  internal init(touches: SwiftSet<UITouch>, type: EventType) {
    self._allTouches = touches
    self.type = type
  }
}

#endif

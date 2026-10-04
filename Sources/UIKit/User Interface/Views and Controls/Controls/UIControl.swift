//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIControl.swift
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

import CKit
import SwiftFramework

/// The base class for controls, which are visual elements that convey a specific action or intention in response to user interactions.
///
/// Controls implement elements such as buttons and sliders, which your app can use to facilitate navigation, gather user input, or manipulate content. Controls use the target-action mechanism to
/// report user interactions to your app.
///
/// You don't create instances of this class directly. The ``UIControl`` class is a subclassing point that you extend to implement custom controls. You can also subclass existing control classes to
/// extend or modify their behaviors. For example, you might override the methods of this class to track touch events yourself or to determine when the state of the control changes.
///
/// A control's state determines its appearance and its ability to support user interactions. Controls can be in one of several states, which the ``UIControl/State`` type defines. You can change the
/// state of a control programmatically according to your app's needs. For example, you might disable a control to prevent the user from interacting with it. User interactions can also change the
/// state of a control.
///
/// ### Respond to user interaction
///
/// The target-action mechanism simplifies the code that you write to use controls in your app. Instead of writing code to track touch events, you write actions to respond to control-specific events.
/// For example, you might write an action object with a action method that responds to changes in the value of a slider. The control handles all the work of tracking incoming touch events and
/// determining when to call your methods.
///
/// When adding an action object to a control, you specify both the action object and control events. The system calls action methods when the user interacts with the control in specific ways. The
/// ``UIControl/Event`` type defines the types of user interactions that a control can report and those interactions mostly correlate to specific touch events within the control. When configuring a
/// control, you must specify which events trigger the calling of your method. For a button control, you might use the ``UIControl/Event/touchDown`` or ``UIControl/Event/touchUpInside`` event to
/// trigger calls to your action method. For a slider, you might care only about changes to the slider's value, so you might choose to attach your action method to ``UIControl/Event/valueChanged``
/// events.
///
/// When a control-specific event occurs, the control calls any associated action methods immediately. The current ``UIApplication`` object dispatches action methods and finds an appropriate object to
/// handle the message, following the responder chain, if necessary.
///
/// ### Support localization
///
/// Because ``UIControl`` is an abstract class, you don't internationalize it specifically. However, you do internationalize the content of subclasses like ``UIButton``. For information about
/// internationalizing a specific control, see the reference for that control.
///
/// ### Subclassing notes
///
/// Subclassing ``UIControl`` gives you access to the built-in target-action mechanism and simplified event-handling support. You can subclass existing controls and modify their behavior in one of two
/// ways:
///
///   - Override the ``sendAction(_:)`` method of an existing subclass to observe or modify the dispatching of action methods to the control's associated targets. You might use this method to modify
///     the dispatch behavior for the specified object.
///   - Override the ``beginTracking(_:with:)``, ``continueTracking(_:with:)``, ``endTracking(_:with:)``, and ``cancelTracking(with:)`` methods to track touch events occurring in the control. You can
///     use the tracking information to perform additional actions. Always use these methods to track touch events instead of the methods that the ``UIResponder`` class defines.
///
/// If you subclass ``UIControl`` directly, your subclass is responsible for setting up and managing your control's visual appearance. Use the methods for tracking events to update your control's
/// state and to send an action when the control's value changes.
///
/// ## Topics
///
/// ### Managing state
///
/// - ``isHighlighted``
///
/// ### Managing the control's targets and actions
///
/// - ``addAction(_:for:)``
/// - ``UIControl/Event``
///
/// ### Triggering actions
///
/// - ``sendAction(_:)``
/// - ``sendActions(for:)``
///
/// ### Tracking touches and redrawing controls
///
/// - ``beginTracking(_:with:)``
/// - ``continueTracking(_:with:)``
/// - ``endTracking(_:with:)``
/// - ``cancelTracking(with:)``
/// - ``isTracking``
@MainActor
open class UIControl: UIView {
  private var _eventActionEntries: SwiftDictionary<UIAction.Identifier, (Event, UIAction)> = [:]

  /// A Boolean value indicating whether the control draws a highlight.
  ///
  /// When the value of this property is `true`, the control draws a highlight; otherwise, the control doesn't draw a highlight. Controls automatically set and clear this state in response to
  /// appropriate touch events. You can change the value of this property as needed to apply or remove a highlight programmatically.
  ///
  /// The default value of this property is `false` for a newly created control.
  public var isHighlighted: CBoolean = false

  /// A Boolean value that indicates whether the control is currently tracking touch events.
  ///
  /// While tracking of a touch event is in progress, the control sets the value of this property to `true`. When tracking ends or is canceled for any reason, it sets this property to `false`.
  public private(set) var isTracking: CBoolean = false

  /// Adds the ``UIAction`` to a given event.
  ///
  /// ``UIAction``s are uniqued based on their identifier, and subsequent actions with the same identifier replace previously added actions. You may add multiple ``UIAction``s for corresponding
  /// `controlEvents`, and you may add the same action to multiple `controlEvents`.
  ///
  /// - Parameters:
  ///   - action: An action object.
  ///   - controlEvents: A bitmask specifying the control-specific events for which the action method is called. Always specify at least one constant. For a list of possible constants, see
  ///     ``UIControl/Event``.
  public func addAction(_ action: UIAction, for controlEvents: Event) {
    self._eventActionEntries[action.identifier] = (controlEvents, action)
  }

  /// Calls the specified action method.
  ///
  /// This method is called by ``sendActions(for:)``. You may override this method to observe or modify behavior. If you override this method, you should call `super` precisely once to dispatch the
  /// action, or not call `super` to suppress sending that action.
  ///
  /// - Parameter action: An action object contains the action method to call.
  public func sendAction(_ action: UIAction) {
    action.performWithSender(nil, target: nil)
  }

  /// Calls the action methods associated with the specified events.
  ///
  /// You call this method when you want the control to perform the actions associated with the specified events. This method iterates over the control's registered action methods and calls the
  /// ``sendAction(_:)`` method for each one that is associated with an event in the `controlEvents` parameter.
  ///
  /// - Parameter controlEvents: A bitmask with flags that specify the control events for which the control sends action messages. See ``UIControl/Event`` for bitmask constants.
  public func sendActions(for controlEvents: Event) {
    for entry in self._eventActionEntries {
      if !entry.value.0.isDisjoint(with: controlEvents) {
        self.sendAction(entry.value.1)
      }
    }
  }

  /// Notifies the control when a touch event enters the control's bounds.
  ///
  /// The default implementation of this method always returns `true`. Subclasses can override this method and use it to respond to events. Use the provided event information to detect which part of
  /// your control was hit and to set up any initial state information. If you want to continue tracking the touch event, return `true`. If you want to stop tracking the touch event, return `false`.
  ///
  /// - Parameters:
  ///   - touch: The object containing information about the touch event.
  ///   - event: The event object containing the touch event.
  ///
  /// - Returns: `true` if the control should continue tracking touch events or `false` if it should stop. This value is used to update the ``isTracking`` property of the control.
  public func beginTracking(_ touch: UITouch, with event: UIEvent?) -> CBoolean {
    return true
  }

  /// Notifies the control when a touch event for the control updates.
  ///
  /// This method is called repeatedly while a touch event is being tracked inside the control's bounds. The default implementation of this method always returns `true`. Subclasses can override this
  /// method and use it to update their state based on changes to the touch event. If you want to continue tracking the touch event, return `true`. If you want to stop tracking the touch event, return
  /// `false`.
  ///
  /// - Parameters:
  ///   - touch: The touch object containing updated information.
  ///   - event: The event object containing the touch event.
  ///
  /// - Returns: `true` if the control should continue tracking touch events or `false` if it should stop. This value is used to update the ``isTracking`` property of the control.
  public func continueTracking(_ touch: UITouch, with event: UIEvent?) -> CBoolean {
    return true
  }

  /// Notifies the control when a touch event associated with the control ends.
  ///
  /// This method is called at the end of a sequence of touch events inside the control's bounds. Subclasses can override this method and use it to perform any actions relevant to the completion of
  /// the touch sequence. You should also use it to perform any cleanup associated with tracking the event.
  ///
  /// If you override this method, you must call `super` at some point in your implementation. The default implementation updates the ``isTracking`` property of the control.
  ///
  /// - Parameters:
  ///   - touch: The touch object containing the final touch information.
  ///   - event: The event object containing the touch event.
  public func endTracking(_ touch: UITouch?, with event: UIEvent?) {
    self.isTracking = false
  }

  /// Notifies the control to cancel tracking related to the specified event.
  ///
  /// The control calls this method when a control-related touch event is canceled. The default implementation cancels any ongoing tracking and updates the control's state information. Subclasses can
  /// override this method and use it to perform any actions relevant to the cancellation of the touch sequence. You should also use it to perform any cleanup associated with tracking the event.
  ///
  /// If you override this method, you must call `super` at some point in your implementation.
  ///
  /// - Parameter event: An event object related to touches that occurred in the control. This parameter might be `nil`, indicating that the cancelation was caused by something other than an event,
  ///   such as the view being removed from the window.
  public func cancelTracking(with event: UIEvent?) {
    self.isTracking = false
  }

  public override func touchesBegan(_ touches: SwiftSet<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else {
      return
    }

    self.isHighlighted = true

    self.isTracking = self.beginTracking(touch, with: event)

    self.sendActions(for: .touchDown)
  }

  public override func touchesMoved(_ touches: SwiftSet<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else {
      return
    }

    self.isTracking = self.continueTracking(touch, with: event)
  }

  public override func touchesEnded(_ touches: SwiftSet<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else {
      return
    }

    self.isHighlighted = false

    self.endTracking(touch, with: event)

    self.sendActions(for: [.touchUpInside, .primaryActionTriggered])
  }

  public override func touchesCancelled(_ touches: SwiftSet<UITouch>, with event: UIEvent?) {
    self.isHighlighted = false

    self.cancelTracking(with: event)

    self.sendActions(for: .touchCancel)
  }
}

#endif

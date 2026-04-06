//
//  Control.swift
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

/// The base class for controls, which are visual elements that convey a
/// specific action or intention in response to user interactions.
///
/// Controls implement elements such as buttons and sliders, which your app can
/// use to facilitate navigation, gather user input, or manipulate content.
/// Controls use the target-action mechanism to report user interactions to your
/// app.
///
/// You don't create instances of this class directly. The ``Control`` class is
/// a subclassing point that you extend to implement custom controls. You can
/// also subclass existing control classes to extend or modify their behaviors.
/// For example, you might override the methods of this class to track touch
/// events yourself or to determine when the state of the control changes.
///
/// A control's state determines its appearance and its ability to support user
/// interactions. Controls can be in one of several states, which the
/// ``Control.State`` type defines. You can change the state of a control
/// programmatically according to your app's needs. For example, you might
/// disable a control to prevent the user from interacting with it. User
/// interactions can also change the state of a control.
///
/// #### Respond to user interaction
///
/// The target-action mechanism simplifies the code that you write to use
/// controls in your app. Instead of writing code to track touch events, you
/// write action methods to respond to control-specific events. For example, you
/// might write an action method that responds to changes in the value of a
/// slider. The control handles all the work of tracking incoming touch events
/// and determining when to call your methods.
///
/// The system calls action methods when the user interacts with the control in
/// specific ways. The ``Control.Event`` type defines the types of user
/// interactions that a control can report and those interactions mostly
/// correlate to specific touch events within the control. When configuring a
/// control, you must specify which events trigger the calling of your method.
/// For a button control, you might use the ``touchDown`` or ``touchUpInside``
/// event to trigger calls to your action method. For a slider, you might care
/// only about changes to the slider's value, so you might choose to attach your
/// action method to ``valueChanged`` events.
///
/// When a control-specific event occurs, the control calls any associated
/// action methods immediately. The current ``Application`` object dispatches
/// action methods and finds an appropriate object to handle the message,
/// following the responder chain, if necessary.
///
/// #### Support localization
///
/// Because ``Control`` is an abstract class, you don't internationalize it
/// specifically. However, you do internationalize the content of subclasses
/// like ``Button``.
///
/// #### Subclassing notes
///
/// Subclassing ``Control`` gives you access to the built-in target-action
/// mechanism and simplified event-handling support. You can subclass existing
/// controls and modify their behavior in one of two ways:
///   - Override the ``sendAction(_:)`` method of an existing subclass to
///     observe or modify the dispatching of action methods to the control's
///     associated targets. You might use this method to modify the dispatch
///     behavior for the specified object or event.
///   - Override the ``beginTracking(_:with:)``, ``continueTracking(_:with:)``,
///     ``endTracking(_:with:)``, and ``cancelTracking(with:)`` methods to track
///     touch events occurring in the control. You can use the tracking
///     information to perform additional actions. Always use these methods to
///     track touch events instead of the methods that the ``Responder`` class
///     defines.
///
/// If you subclass ``Control`` directly, your subclass is responsible for
/// setting up and managing your control's visual appearance. Use the methods
/// for tracking events to update your control's state and to send an action
/// when the control's value changes.
@available(macOS 13.3.0, *)
@MainActor public class Control: View {
  // TODO: Use FoundationFramework's dictionary
  private var actions = [(String, Action, Event)]()

  /// Adds the `action` to a given event. Actions are uniqued based on their
  /// identifier, and subsequent actions with the same identifier replace
  /// previously added actions. You may add multiple Actions for corresponding
  /// `controlEvents`, and you may add the same action to multiple
  /// `controlEvents`.
  public func addAction(_ action: Action, for controlEvents: Event) {
    // TODO: Replace the same identifier
    actions.append((action.identifier, action, controlEvents))

    // Register the JavaScript event listener for this control
    JavaScriptBridge.addElementEventListener(
      elementID: layer.contents,
      eventTypeRawValue: controlEvents.rawValue
    )
  }

  /// Removes the action from the set of passed control events.
  public func removeAction(_ action: Action, for event: Event) {
    actions.removeAll(where: { $0.0 == action.identifier })
  }

  /// This method is called by ``sendActions(for:)``:. You may override this
  /// method to observe or modify behavior. If you override this method, you
  /// should call super precisely once to dispatch the action, or not call super
  /// to suppress sending that action.
  public func sendAction(_ action: Action) {
    action.handler(action)
  }

  /// Calls the action methods associated with the specified events.
  ///
  /// - Parameter controlEvents: A bit-mask with flags that specify the control
  ///   events for which the control sends action messages. See
  ///   ``Control.Event`` for bit-mask constants.
  public func sendActions(for controlEvents: Control.Event) {
    for action in actions {
      if action.2.contains(controlEvents) {
        sendAction(action.1)
      }
    }
  }
}

@available(macOS 13.3.0, *)
extension Control {
  /// Constants describing the types of events possible for controls.
  ///
  /// You set up a control so that it sends an action message to a target object
  /// by associating both target and action with one or more control events.
  public struct Event: OptionSet, Sendable {
    public let rawValue: UnsignedInteger32

    /// Creates a control event with the specified raw value.
    ///
    /// - Parameter rawValue: The raw value.
    public init(rawValue: UnsignedInteger32 = 0) {
      self.rawValue = rawValue
    }

    /// A touch-up event in the control where the finger is inside the bounds of
    /// the control.
    public static let touchUpInside = Event(rawValue: 1 << 0)

    /// A touch-down event in the control.
    public static let touchDown = Event(rawValue: 1 << 1)

    /// A touch dragging or otherwise manipulating a control, causing it to emit
    /// a series of different values.
    public static let valueChanged = Event(rawValue: 1 << 2)
  }
}

@available(macOS 13.3.0, *)
extension Control {
  /// Constants describing the state of a control.
  ///
  /// A control can have more than one state at a time. Controls can have
  /// different configurations according to their state. For example, a
  /// ``Button`` object can display one image when it's in its normal state and
  /// a different image when it's highlighted.
  public struct State: OptionSet, Sendable {
    public let rawValue: UnsignedInteger32

    public init(rawValue: UnsignedInteger32) {
      self.rawValue = rawValue
    }

    /// The normal, or default, state of a control where the control is enabled
    /// but neither selected nor highlighted.
    public static let normal = State(rawValue: 1 << 0)
  }
}

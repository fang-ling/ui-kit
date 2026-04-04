//
//  Responder.swift
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

/// An abstract interface for responding to and handling events.
///
/// Responder objects — instances of ``Responder`` — constitute the
/// event-handling backbone of an app. Many key objects are also responders,
/// including the ``Application`` object, ``ViewController`` objects, and all
/// ``View`` objects (which includes ``Window``). As events occur, system
/// dispatches them to your app's responder objects for handling.
///
/// There are several kinds of events, including touch events, motion events,
/// remote-control events, and press events. To handle a specific type of event,
/// a responder must override the corresponding methods. For example, to handle
/// touch events, a responder implements the ``touchesBegan(_:with:)``,
/// ``touchesMoved(_:with:)``, ``touchesEnded(_:with:)``, and
/// ``touchesCancelled(_:with:)`` methods. In the case of touches, the responder
/// uses the event information provided by system to track changes to those
/// touches and to update the app's interface appropriately.
///
/// In addition to handling events, responders also manage the forwarding of
/// unhandled events to other parts of your app. If a given responder doesn't
/// handle an event, it forwards that event to the next event in the responder
/// chain. UIKit manages the responder chain dynamically, using predefined rules
/// to determine which object should be next to receive an event. For example, a
/// view forwards events to its superview, and the root view of a hierarchy
/// forwards events to its view controller.
///
/// Responders process ``Event`` objects but can also accept custom input
/// through an input view. The system's keyboard is the most obvious example of
/// an input view. When the user taps a ``TextField`` and ``TextView`` object
/// onscreen, the view becomes the first responder.
@MainActor
open class Responder {
  /// The next responder in the responder chain, or `nil` if there's no next
  /// responder.
  ///
  /// The ``Responder`` class doesn't store or set the next responder
  /// automatically, so this method returns `nil` by default. Subclasses must
  /// override this method and return an appropriate next responder. For
  /// example, ``View`` implements this method and returns the
  /// ``ViewController`` object that manages it (if it has one) or its superview
  /// (if it doesn't). ``ViewController`` similarly implements the method and
  /// returns its view's superview. ``Window`` returns the application object.
  /// The shared ``Application`` object normally returns nil, but it returns its
  /// app delegate if that object is a subclass of ``Responder`` and hasn't
  /// already been called to handle the event.
  var next: Responder?
}

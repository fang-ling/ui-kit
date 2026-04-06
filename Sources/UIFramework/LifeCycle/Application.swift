//
//  Application.swift
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

import AnimationFramework
import FoundationFramework
import JavaScriptBridgeFramework

@available(macOS 13.3.0, *)
@MainActor public class Application: Responder {
  private override init() { }

  public static let shared = Application()

  public weak var delegate: (any ApplicationDelegate)?

  var keyWindow: Window? { windows.last }

  var windows: [Window] = []

  /// Dispatches an event to the appropriate responder objects in the app.
  ///
  /// - Parameter target: The object to receive the action message. If target is
  ///   `nil`, the app sends the message to the first responder, from whence it
  ///   progresses up the responder chain until it is handled.
  func sendEvent(
    to targetPointer: UnsafePointer<Integer32>, // TODO: UUID
    targetPointerCount: UnsignedInteger64,
    for event: Control.Event
  ) {
    func isEqual(
      _ lhs: String,
      _ rhs: UnsafePointer<Integer32>,
      _ rhsCount: UnsignedInteger64
    ) -> BinaryLogic {
      if lhs.count == rhsCount {
        for i in 0 ..< Int(rhsCount) {
          if lhs.charactersView[i] != rhs[i] {
            return false
          }
        }

        return true
      }

      return false
    }

    func walkTree(view: View, perform action: (View) -> Void) {
      for subview in view.subviews {
        // TODO: Make UUID conforms to Equatable
        if isEqual(
          subview.layer.contents.uuidString,
          targetPointer,
          targetPointerCount
        ) {
          action(subview)
        }

        walkTree(view: subview, perform: action)
      }
    }

    for window in Application.shared.windows {
      walkTree(view: window) { view in
        (view as? Control)?.sendActions(for: event)
      }
    }
  }
}

@available(macOS 13.3.0, *)
@MainActor public func ApplicationMain(delegate: some ApplicationDelegate) {
  Application.shared.delegate = delegate

  delegate.applicationDidFinishLaunching()

  // Initial rendering
  Transaction.flush(Application.shared.keyWindow?.layer)
}

@_expose(wasm, "UIFramework_DispatchElementEvent")
@_cdecl("UIFramework_DispatchElementEvent")
@available(macOS 13.3.0, *)
@MainActor func UIFramework_DispatchElementEvent(
  elementIDString: UnsafePointer<Integer32>,
  elementIDStringCount: UnsignedInteger64,
  eventType: UnsignedInteger32
) {
  Application.shared.sendEvent(
    to: elementIDString,
    targetPointerCount: elementIDStringCount,
    for: .init(rawValue: eventType)
  )

  // TODO: Support async event

  Transaction.flush(Application.shared.keyWindow?.layer)
}

////
////  Control.swift
////  ui-framework
////
////  Created by Fang Ling on 2026/3/22.
////
////  Licensed under the Apache License, Version 2.0 (the "License");
////  you may not use this file except in compliance with the License.
////  You may obtain a copy of the License at
////
////    http://www.apache.org/licenses/LICENSE-2.0
////
////  Unless required by applicable law or agreed to in writing, software
////  distributed under the License is distributed on an "AS IS" BASIS,
////  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
////  See the License for the specific language governing permissions and
////  limitations under the License.
////
//
//import FoundationFramework
//
//@available(macOS 13.3.0, *)
//@MainActor public class Control: View {
//  // TODO: Use FoundationFramework's dictionary
//  private var actions = [(String, Action, Event)]()
//
//  public func addAction(_ action: Action, for event: Event) {
//    actions.append((action.identifier, action, event))
//    // Register JS event listener for this control once it has an id
//    needsDisplay = true
//  }
//
//  public func removeAction(_ action: Action, for event: Event) {
//    actions.removeAll(where: { $0.0 == action.identifier })
//  }
//
//  public func sendAction(_ action: Action) {
//    action.handler(action)
//  }
//
//  public func sendActions(for controlEvents: Control.Event) {
//    for action in actions {
//      if action.2.contains(controlEvents) {
//        sendAction(action.1)
//      }
//    }
//  }
//}
//
//@available(macOS 13.3.0, *)
//extension Control {
//  public struct Event: OptionSet, Sendable {
//
//    public let rawValue: UnsignedInteger32
//
//    public init(rawValue: UnsignedInteger32 = 0) {
//      self.rawValue = rawValue
//    }
//
//    public static let touchUpInside = Event(rawValue: 1 << 0)
//    public static let touchDown = Event(rawValue: 1 << 1)
//    public static let valueChanged = Event(rawValue: 1 << 2)
//  }
//}

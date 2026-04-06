//
//  Action.swift
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

/// A type that defines the closure for an action handler.
@available(macOS 13.3.0, *)
public typealias ActionHandler = (Action) -> Void

/// An element that performs its action in a closure.
@available(macOS 13.3.0, *)
@MainActor public class Action {
  /// The unique identifier for the action.
  var identifier: String

  /// The handler to invoke after a person selects the action.
  var handler: ActionHandler

  /// Creates an action with the specified identifier and handler.
  ///
  /// - Parameters:
  ///   - identifier: The unique identifier for the action. Specify `nil` to let
  ///     this method create a unique identifier for you.
  ///   - handler: The handler to invoke after a person selects the action. This
  ///     handler has the following parameter:
  ///       - action: The action that a person selects.
  public init(
    identifier: String? = nil,
    handler: @escaping ActionHandler
  ) {
    self.identifier = identifier ?? UUID().uuidString
    self.handler = handler
  }
}

////
////  Action.swift
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
//public typealias ActionHandler = (Action) -> Void
//
//@available(macOS 13.3.0, *)
//@MainActor public class Action {
//  var identifier: String
//  var handler: ActionHandler
//
//  public init(
//    identifier: String = String( // TODO: Use the FoundationFramework's UUID
//      "com.apple.action.dynamic.\(UnsignedInteger64.random(in: 0 ..< .max)))"
//    ),
//    handler: @escaping ActionHandler
//  ) {
//    self.identifier = identifier
//    self.handler = handler
//  }
//}
//
//@available(macOS 13.3.0, *)
//extension Action {
//  struct Identifier: RawRepresentable {
//    var rawValue: String
//
//    public init(rawValue: String) {
//      self.rawValue = rawValue
//    }
//  }
//}

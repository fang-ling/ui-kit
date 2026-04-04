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
import JavaScriptBridgeFramework

@available(macOS 13.3.0, *)
@MainActor public class Application: Responder {
  private override init() { }

  public static let shared = Application()

  public weak var delegate: (any ApplicationDelegate)?

  var keyWindow: Window? { windows.last }

  var windows: [Window] = []
}

@available(macOS 13.3.0, *)
@MainActor public func ApplicationMain(delegate: some ApplicationDelegate) {
  Application.shared.delegate = delegate

  delegate.applicationDidFinishLaunching()

  // Initial rendering
  Transaction.flush(Application.shared.keyWindow?.layer)
  if let contents = Application.shared.keyWindow?.layer.contents {
    JavaScriptBridge.linkElements(elementID: contents, parentID: nil)
  }
}

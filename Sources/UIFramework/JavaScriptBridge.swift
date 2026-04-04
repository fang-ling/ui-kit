//
//  JavaScriptBridge.swift
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

//extension UIJavaScriptBridge.HTMLElement {
//
//
//  @_extern(
//    wasm,
//    module: "env",
//    name: "UIJavaScriptBridge_HTMLElement_UpdateText"
//  )
//  static func updateText(
//    _ id: UnsignedInteger32,
//    _ text: UnsafePointer<Integer32>,
//    _ textCount: UnsignedInteger64
//  )
//
//  @_extern(
//    wasm,
//    module: "env",
//    name: "UIJavaScriptBridge_HTMLElement_AddEventListener"
//  )
//  static func addEventListener(
//    _ htmlEventType: UnsignedInteger32,
//    _ id: UnsignedInteger32
//  )
//
//  @available(macOS 13.3.0, *)
//  @MainActor static func dispatchEvent(
//    _ id: UnsignedInteger32,
//    _ htmlEventType: UnsignedInteger32
//  ) {
//    func walkTree(view: View, perform action: (View) -> Void) {
//      for subview in view.subviews {
//        if subview.id == id {
//          action(subview)
//        }
//
//        walkTree(view: subview, perform: action)
//      }
//    }
//
//    for window in Application.shared.windows {
//      walkTree(view: window) { view in
//        (view as? Control)?.sendActions(
//          for: Control.Event(
//            rawValue: htmlEventType
//          )
//        )
//      }
//    }
//  }
//}
//
//@_expose(wasm, "UIJavaScriptBridge_HTMLElement_DispatchEvent")
//@_cdecl("UIJavaScriptBridge_HTMLElement_DispatchEvent")
//@available(macOS 13.3.0, *)
//@MainActor func UIJavaScriptBridge_HTMLElement_DispatchEvent(
//  _ id: UnsignedInteger32,
//  _ htmlEventType: UnsignedInteger32
//) {
//  UIJavaScriptBridge.HTMLElement.dispatchEvent(id, htmlEventType)
//  // TODO: Supports async event
//  Application.shared.keyWindow?.displayIfNeeded()
//  Application.shared.keyWindow?.updateConstraintsIfNeeded()
//}

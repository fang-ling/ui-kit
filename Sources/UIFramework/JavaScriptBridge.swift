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

import FoundationFramework

enum ElementType: UnsignedInteger32 {
  case division = 1
  case span = 2
  case button = 3
}

@_extern(
  wasm,
  module: "env",
  name: "UIFramework_JavaScriptBridge_InitializeElement"
)
func UIFramework_JavaScriptBridge_InitializeElement(
  _ htmlElementType: UnsignedInteger32,
  _ id: UnsafePointer<Integer32>,
  _ idCount: UnsignedInteger64
)

@_extern(
  wasm,
  module: "env",
  name: "UIFramework_JavaScriptBridge_LinkElements"
)
func UIFramework_JavaScriptBridge_LinkElements(
  _ id: UnsafePointer<Integer32>,
  _ idCount: UnsignedInteger64,
  _ parentID: UnsafePointer<Integer32>,
  _ parentIDCount: UnsignedInteger64
)

@_extern(
  wasm,
  module: "env",
  name: "UIFramework_JavaScriptBridge_GetWindowWidth"
)
func UIFramework_JavaScriptBridge_GetWindowWidth() -> FloatingPoint64

@_extern(
  wasm,
  module: "env",
  name: "UIFramework_JavaScriptBridge_GetWindowHeight"
)
func UIFramework_JavaScriptBridge_GetWindowHeight() -> FloatingPoint64

@_extern(
  wasm,
  module: "env",
  name: "UIFramework_JavaScriptBridge_SetElementStyleProperty"
)
func UIFramework_JavaScriptBridge_SetElementStyleProperty(
  _ id: UnsafePointer<Integer32>,
  _ idCount: UnsignedInteger64,
  _ property: UnsafePointer<Integer32>,
  _ propertyCount: UnsignedInteger64,
  _ value: UnsafePointer<Integer32>,
  _ valueCount: UnsignedInteger64
)

@_extern(
  wasm,
  module: "env",
  name: "UIFramework_JavaScriptBridge_RemoveElementStyleProperty"
)
func UIFramework_JavaScriptBridge_RemoveElementStyleProperty(
  _ id: UnsafePointer<Integer32>,
  _ idCount: UnsignedInteger64,
  _ property: UnsafePointer<Integer32>,
  _ propertyCount: UnsignedInteger64
)

@available(macOS 13.3.0, *)
enum JavaScriptBridge {
  static func initializeElement(
    elementType: ElementType,
    id: UUID
  ) {
    let id = id.uuidString
    UIFramework_JavaScriptBridge_InitializeElement(
      elementType.rawValue,
      id.charactersView,
      id.count
    )
  }

  static func linkElements(id: UUID, parentID: UUID?) {
    let id = id.uuidString
    let parentID = parentID?.uuidString ?? String("")
    UIFramework_JavaScriptBridge_LinkElements(
      id.charactersView,
      id.count,
      parentID.charactersView,
      parentID.count
    )
  }

  static func getWindowWidth() -> FloatingPoint64 {
    UIFramework_JavaScriptBridge_GetWindowWidth()
  }

  static func getWindowHeight() -> FloatingPoint64 {
    UIFramework_JavaScriptBridge_GetWindowHeight()
  }

  static func setElementStyleProperty(
    id: UUID,
    property: String,
    value: String
  ) {
    let id = id.uuidString
    UIFramework_JavaScriptBridge_SetElementStyleProperty(
      id.charactersView,
      id.count,
      property.charactersView,
      property.count,
      value.charactersView,
      value.count
    )
  }

  static func removeElementStyleProperty(id: UUID, property: String) {
    let id = id.uuidString
    UIFramework_JavaScriptBridge_RemoveElementStyleProperty(
      id.charactersView,
      id.count,
      property.charactersView,
      property.count,
    )
  }
}

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

////
////  Button.swift
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
//@MainActor public class Button: Control {
//  public var title: String? {
//    didSet {
//      needsDisplay = true
//    }
//  }
//
//  override func displayIfNeeded() {
//    guard needsDisplay else {
//      return
//    }
//
//    if id == nil {
//      let id = UIFramework_GetNextViewID()
//      self.id = id
//
//      let type: UIJavaScriptBridge.HTMLElement.`Type` = .button
//      UIJavaScriptBridge.HTMLElement.initialize(
//        type.rawValue,
//        id,
//        superview?.id ?? 0
//      )
//      UIJavaScriptBridge.HTMLElement.addEventListener(
//        Control.Event.touchUpInside.rawValue,
//        id
//      )
//    }
//
//    if let id, let title {
//      UIJavaScriptBridge.HTMLElement.updateText(
//        id,
//        title.charactersView,
//        title.count
//      )
//    }
//
//    needsDisplay = false
//  }
//}

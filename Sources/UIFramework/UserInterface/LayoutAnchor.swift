////
////  LayoutAnchor.swift
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
//@MainActor public class LayoutAnchor<AnchorType> where AnchorType: AnyObject {
//  weak var item: AnyObject?
//
//  let attribute: LayoutConstraint.Attribute
//
//  init(item: AnyObject, attribute: LayoutConstraint.Attribute) {
//    self.item = item
//    self.attribute = attribute
//  }
//
//  public func constraint(
//    equalTo anchor: LayoutAnchor<AnchorType>,
//    constant: FloatingPoint64 = 0.0
//  ) -> LayoutConstraint {
//    LayoutConstraint(
//      item: item!,
//      attribute: attribute,
//      relatedBy: .equal,
//      toItem: anchor.item,
//      attribute: anchor.attribute,
//      multiplier: 1.0,
//      constant: constant
//    )
//  }
//}
//
//@available(macOS 13.3.0, *)
//@MainActor public class LayoutDimension: LayoutAnchor<LayoutDimension> {
//  public func constraint(
//    equalToConstant constant: FloatingPoint64
//  ) -> LayoutConstraint {
//    LayoutConstraint(
//      item: item!,
//      attribute: attribute,
//      relatedBy: .equal,
//      toItem: nil,
//      attribute: .notAnAttribute,
//      multiplier: 1.0,
//      constant: constant
//    )
//  }
//}
//
//@available(macOS 13.3.0, *)
//public final class LayoutXAxisAnchor: LayoutAnchor<LayoutXAxisAnchor> {}
//
//@available(macOS 13.3.0, *)
//public final class LayoutYAxisAnchor: LayoutAnchor<LayoutYAxisAnchor> {}

////
////  LayoutConstraint.swift
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
//@MainActor public class LayoutConstraint {
//  public weak var firstItem: AnyObject?
//
//  public let firstAttribute: Attribute
//
//  public let relation: Relation
//
//  public weak var secondItem: AnyObject?
//
//  public let secondAttribute: Attribute
//
//  public let multiplier: FloatingPoint64
//
//  public let constant: FloatingPoint64
//
////  public var isActive: Bool = false {
////    didSet {
////      guard isActive != oldValue else {
////        return
////      }
////
////      let ancestor = findCommonAncestor()
////
////      if isActive {
////        ancestor?.addConstraint(self)
////      } else {
////        ancestor?.removeConstraint(self)
////      }
////    }
////  }
//
//  private func findCommonAncestor() -> View? {
//    guard let firstView = firstItem as? View else { return nil }
//    guard let secondView = secondItem as? View else {
//      return firstView
//    }
//
//    var ancestors: [ObjectIdentifier: View] = [:]
//    var current: View? = firstView
//    while let view = current {
//      ancestors[ObjectIdentifier(view)] = view
//      current = view.superview
//    }
//
//    current = secondView
//    while let view = current {
//      if ancestors[ObjectIdentifier(view)] != nil {
//        return view
//      }
//      current = view.superview
//    }
//
//    return nil
//  }
//
//  public init(
//    item firstItem: AnyObject,
//    attribute firstAttribute: Attribute,
//    relatedBy relation: Relation = .equal,
//    toItem secondItem: AnyObject?,
//    attribute secondAttribute: Attribute,
//    multiplier: FloatingPoint64 = 1.0,
//    constant: FloatingPoint64 = 0.0
//  ) {
//    self.firstItem = firstItem
//    self.firstAttribute = firstAttribute
//    self.relation = relation
//    self.secondItem = secondItem
//    self.secondAttribute = secondAttribute
//    self.multiplier = multiplier
//    self.constant = constant
//  }
//
//  // TODO: Use FoundationFramework's Array
//  public static func activate(_ constraints: [LayoutConstraint]) {
//    for constraint in constraints {
//      constraint.isActive = true
//    }
//  }
//
//  // TODO: Use FoundationFramework's Array
//  public static func deactivate(_ constraints: [LayoutConstraint]) {
//    for constraint in constraints {
//      constraint.isActive = false
//    }
//  }
//}
//
//@available(macOS 13.3.0, *)
//extension LayoutConstraint {
//  public enum Attribute {
//    case leading
//    case trailing
//    case top
//    case bottom
//    case centerX
//    case centerY
//    case width
//    case height
//    case notAnAttribute
//  }
//
//  public enum Relation {
//    case equal
//    // lessThanOrEqual, greaterThanOrEqual — TODO
//  }
//}

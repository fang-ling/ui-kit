//
//  View.swift
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

@available(macOS 13.3.0, *)
@MainActor public class View: Responder {
  var id: UnsignedInteger32?

  var needsDisplay = true {
    didSet {
      if needsDisplay {
        superview?.needsDisplay = true
      }
    }
  }

  var constraintsNeedUpdate = true {
    didSet {
      if constraintsNeedUpdate {
        superview?.constraintsNeedUpdate = true
      }
    }
  }

  public var translatesAutoresizingMaskIntoConstraints = true

  var superview: View?

  var subviews: [View] = [] // TODO: Use FoundationFramework's Array

  // TODO: Use FoundationFramework's Array
  var constraints: [LayoutConstraint] = []

  public private(set) lazy var leadingAnchor = LayoutXAxisAnchor(
    item: self,
    attribute: .leading
  )

  public private(set) lazy var trailingAnchor = LayoutXAxisAnchor(
    item: self,
    attribute: .trailing
  )

  public private(set) lazy var topAnchor = LayoutYAxisAnchor(
    item: self,
    attribute: .top
  )

  public private(set) lazy var bottomAnchor = LayoutYAxisAnchor(
    item: self,
    attribute: .bottom
  )

  public private(set) lazy var centerXAnchor = LayoutXAxisAnchor(
    item: self,
    attribute: .centerX
  )

  public private(set) lazy var centerYAnchor = LayoutYAxisAnchor(
    item: self,
    attribute: .centerY
  )

  public private(set) lazy var widthAnchor = LayoutDimension(
    item: self,
    attribute: .width
  )

  public private(set) lazy var heightAnchor = LayoutDimension(
    item: self,
    attribute: .height
  )

  public func addSubview(_ view: View) {
    if view.superview !== self {
      view.removeFromSuperview()
    }

    subviews.append(view)

    view.superview = self

    needsDisplay = true
  }

  func displayIfNeeded() {
    guard needsDisplay else {
      return
    }

    if id == nil {
      let id = UIFramework_GetNextViewID()
      self.id = id

      let type: UIJavaScriptBridge.HTMLElement.`Type` = .division
      UIJavaScriptBridge.HTMLElement.initialize(
        type.rawValue,
        id,
        superview?.id ?? 0
      )
    }

    // TODO: Support view removal
    for child in subviews {
      child.displayIfNeeded()
    }

    needsDisplay = false
  }

  func removeFromSuperview() {
    guard
      let index = superview?.subviews.firstIndex(where: { $0 === self })
    else {
      return
    }

    superview?.subviews.remove(at: index)
  }

  func addConstraint(_ constraint: LayoutConstraint) {
    constraints.append(constraint)
    constraintsNeedUpdate = true
    superview?.constraintsNeedUpdate = true
  }

  func removeConstraint(_ constraint: LayoutConstraint) {
    constraints.removeAll(where: { $0 === constraint })
    constraintsNeedUpdate = true
    superview?.constraintsNeedUpdate = true
  }

  func updateConstraintsIfNeeded() {
    // Bottom-up: children first
    for child in subviews {
      child.updateConstraintsIfNeeded()
    }

    guard constraintsNeedUpdate else {
      return
    }
    updateConstraints()
    constraintsNeedUpdate = false
  }

  func updateConstraints() {
    for constraint in constraints where constraint.isActive {
      guard let firstView = constraint.firstItem as? View else {
        continue
      }

      guard !firstView.translatesAutoresizingMaskIntoConstraints else {
        continue
      }

      let property = cssProperty(for: constraint.firstAttribute)
      let value = cssValue(for: constraint)

      if let firstViewID = firstView.id,
         let property,
         let value {
        UIJavaScriptBridge.HTMLElement.setStyleProperty(
          firstViewID,
          property.charactersView,
          property.count,
          value.charactersView,
          value.count
        )

        if constraint.firstAttribute == .centerX {
          let property = String("--translate-x")
          let value = String("-50%")
          UIJavaScriptBridge.HTMLElement.setStyleProperty(
            firstViewID,
            property.charactersView,
            property.count,
            value.charactersView,
            value.count
          )
        } else if constraint.firstAttribute == .centerY {
          let property = String("--translate-y")
          let value = String("-50%")
          UIJavaScriptBridge.HTMLElement.setStyleProperty(
            firstViewID,
            property.charactersView,
            property.count,
            value.charactersView,
            value.count
          )
        }
      }
    }
  }

  // TODO: Move to the enum itself.
  private func cssProperty(
    for attribute: LayoutConstraint.Attribute
  ) -> String? {
    switch attribute {
    case .leading: return String("left")
    case .trailing: return String("right")
    case .top: return String("top")
    case .bottom: return String("bottom")
    case .centerX: return String("left")
    case .centerY: return String("top")
    case .width: return String("width")
    case .height: return String("height")
    case .notAnAttribute: return String("")
    }
  }

  // TODO: Move to the enum itself.
  private func cssValue(for constraint: LayoutConstraint) -> String? {
    let constant = constraint.constant

    guard let secondView = constraint.secondItem as? View else {
      return String("\(constant)px")
    }

    let anchorName = "--view-\(secondView.id ?? 0)"

    switch constraint.firstAttribute {
    case .width:
      if constant == 0 {
        return String("anchor-size(\(anchorName) width)")
      }
      return String("calc(anchor-size(\(anchorName) width) + \(constant)px)")

    case .height:
      if constant == 0 {
        return String("anchor-size(\(anchorName) height)")
      }
      return String("calc(anchor-size(\(anchorName) height) + \(constant)px)")

    case .centerX, .centerY:
      if constant == 0 {
        return String("anchor(\(anchorName) center)")
      }
      return String("calc(anchor(\(anchorName) center) + \(constant)px)")

    default:
      let side = switch constraint.secondAttribute {
      case .leading: "left"
      case .trailing: "right"
      case .top: "top"
      case .bottom: "bottom"
      case .centerX: "center"
      case .centerY: "center"
      default: "left"
      }
      if constant == 0 {
        return String("anchor(\(anchorName) \(side))")
      }
      return String("calc(anchor(\(anchorName) \(side)) + \(constant)px)")
    }
  }
}

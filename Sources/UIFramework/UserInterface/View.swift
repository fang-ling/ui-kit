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

import AnimationFramework
import FoundationFramework
import JavaScriptBridgeFramework

@available(macOS 13.3.0, *)
@MainActor public class View: Responder {
  /// A Boolean value indicating whether the receiver's entire bounds rectangle
  /// as needing to be redrawn.
  ///
  /// You can use set this value to `true` to notify the system that your view's
  /// contents need to be redrawn. The view is not actually redrawn until the
  /// next drawing cycle, at which point all invalidated views are updated.
  ///
  /// You should update this value to request that a view be redrawn only when
  /// the content or appearance of the view change. If you simply change the
  /// geometry of the view, the view is typically not redrawn. Instead, its
  /// existing content is adjusted based on the value in the view's
  /// ``contentMode`` property. Redisplaying the existing content improves
  /// performance by avoiding the need to redraw content that has not changed.
  var needsDisplay: BinaryLogic {
    get { layer.needsDisplay }
    set { layer.needsDisplay = newValue }
  }

  /// A Boolean value indicating whether the current layout of the receiver as
  /// needing a layout update during the next update cycle.
  ///
  /// Update this value to `true` on your application's main thread when you
  /// want to adjust the layout of a view's subviews. Because updating this
  /// value does not force an immediate update, but instead waits for the next
  /// update cycle, you can use it to invalidate the layout of multiple views
  /// before any of those views are updated. This behavior allows you to
  /// consolidate all of your layout updates to one update cycle, which is
  /// usually better for performance.
  var needsLayout: BinaryLogic {
    get { layer.needsLayout }
    set { layer.needsLayout = newValue }
  }

  //  /// A Boolean value that determines whether the view's constraints need
  //  /// updating.
  //  var needsUpdateConstraints = true {
  //    didSet {
  //      if needsUpdateConstraints {
  //        superview?.needsUpdateConstraints = true
  //      }
  //    }
  //  }

  /// The view's Animation Framework layer to use for rendering.
  ///
  /// This property is never `nil`. The view is the layer's delegate.
  ///
  /// > Warning: Because the view is the layer's delegate, never make the view
  ///   the delegate of another ``Layer`` object. Additionally, never change the
  ///   delegate of this layer object.
  public var layer = Layer()

  /// The frame rectangle, which describes the view's location and size in its
  /// superview's coordinate system.
  ///
  /// This rectangle defines the size and position of the view in its
  /// superview's coordinate system. Use this rectangle during layout operations
  /// to set the size and position the view. Setting this property changes the
  /// point specified by the ``center`` property and changes the size in the
  /// bounds rectangle accordingly. The coordinates of the frame rectangle are
  /// always specified in pixels.
  ///
  /// > Warning: If the ``transform`` property is not the identity transform,
  ///   the value of this property is undefined and therefore should be ignored.
  ///
  /// Changing the frame rectangle automatically redisplays the view without
  /// calling its ``draw()`` method. If you want UIFramework to call the
  /// ``draw()`` method when the frame rectangle changes, set the
  /// ``contentMode`` property to ``View.ContentMode.redraw``.
  ///
  /// Changes to this property can be animated. However, if the ``transform``
  /// property contains a non-identity transform, the value of the ``frame``
  /// property is undefined and should not be modified. In that case, reposition
  /// the view using the ``center`` property and adjust the size using the
  /// ``bounds`` property instead.
  var frame: Rectangle {
    get { layer.frame }
    set { layer.frame = newValue }
  }

  /// The bounds rectangle, which describes the view's location and size in its
  /// own coordinate system.
  ///
  /// The default bounds origin is `(0,0)` and the size is the same as the size
  /// of the rectangle in the ``frame`` property. Changing the size portion of
  /// this rectangle grows or shrinks the view relative to its center point.
  /// Changing the size also changes the size of the rectangle in the ``frame``
  /// property to match. The coordinates of the bounds rectangle are always
  /// specified in pixels.
  ///
  /// Changing the bounds rectangle automatically redisplays the view without
  /// calling its ``draw()`` method. If you want UIFramework to call the
  /// ``draw()`` method, set the ``contentMode`` property to
  /// ``View.ContentMode.redraw``.
  ///
  /// Changes to this property can be animated.
  var bounds: Rectangle {
    get { layer.bounds }
    set { layer.bounds = newValue }
  }

  /// A Boolean value that determines whether the view is hidden.
  ///
  /// Setting the value of this property to `true` hides the receiver and
  /// setting it to `false` shows the receiver. The default value is `false`.
  ///
  /// A hidden view disappears from its window and does not receive input
  /// events. It remains in its superview's list of subviews, however, and
  /// participates in autoresizing as usual. Hiding a view with subviews has the
  /// effect of hiding those subviews and any view descendants they might have.
  /// This effect is implicit and does not alter the hidden state of the
  /// receiver's descendants.
  ///
  /// Hiding the view that is the window's current first responder causes the
  /// view's next valid key view to become the new first responder.
  ///
  /// The value of this property reflects the state of the receiver only and
  /// does not account for the state of the receiver's ancestors in the view
  /// hierarchy. Thus this property can be false but the receiver may still be
  /// hidden if an ancestor is hidden.
  var isHidden: BinaryLogic {
    get { layer.isHidden }
    set { layer.isHidden = newValue }
  }

//  public var translatesAutoresizingMaskIntoConstraints = true

  var superview: View?

  var subviews: [View] = [] // TODO: Use FoundationFramework's Array

  /// Creates a view with the specified frame rectangle.
  ///
  /// - Parameter frame: The frame rectangle for the view, measured in pixels.
  ///   The origin of the frame is relative to the superview in which you plan
  ///   to add it. This method uses the frame rectangle to set the ``center``
  ///   and ``bounds`` properties accordingly.
  public init(frame: Rectangle) {
    super.init()

    self.frame = frame
    self.layer.delegate = self

    JavaScriptBridge.initializeElement(
      elementID: self.layer.contents,
      elementType: .division
    )
  }

  /// Lays out subviews.
  ///
  /// The default implementation uses any constraints you set to determine the
  /// size and position of any subviews.
  ///
  /// Subclasses can override this method as needed to perform more precise
  /// layout of their subviews. You should override this method only if the
  /// autoresizing and constraint-based behaviors of the subviews don't offer
  /// the behavior you want. You can use your implementation to set the frame
  /// rectangles of your subviews directly.
  ///
  /// Don't call this method directly. If you want to force a layout update, set
  /// the ``needsLayout`` to `true` instead to do so prior to the next drawing
  /// update. If you want to update the layout of your views immediately, call
  /// the ``layoutIfNeeded()`` method.
  func layoutSubviews() {
    // TODO: Start the constraint pass here
  }

  func addSubview(_ view: View) {
    if view.superview !== self {
      view.removeFromSuperview()
    }

    subviews.append(view)

    layer.addSublayer(view.layer)

    view.superview = self

    // TODO: Auto Layout
//    view.needsUpdateConstraints = true
//    needsUpdateConstraints = true
  }

  /// Unlinks the view from its superview and its window, and removes it from
  /// the responder chain.
  ///
  /// If the view's superview is not `nil`, the superview releases the view.
  ///
  /// Calling this method removes any constraints that refer to the view you are
  /// removing, or that refer to any view in the subtree of the view you are
  /// removing.
  ///
  /// > Important: Never call this method from inside your view's ``draw()``
  ///   method.
  func removeFromSuperview() {
    guard
      let index = superview?.subviews.firstIndex(where: { $0 === self })
    else {
      return
    }

    superview?.subviews.remove(at: index)

    superview = nil

    layer.removeFromSuperlayer()

    // TODO: Auto Layout
  }

//  // TODO: Use FoundationFramework's Array
//  var constraints: [LayoutConstraint] = []
//
//  public private(set) lazy var leadingAnchor = LayoutXAxisAnchor(
//    item: self,
//    attribute: .leading
//  )
//
//  public private(set) lazy var trailingAnchor = LayoutXAxisAnchor(
//    item: self,
//    attribute: .trailing
//  )
//
//  public private(set) lazy var topAnchor = LayoutYAxisAnchor(
//    item: self,
//    attribute: .top
//  )
//
//  public private(set) lazy var bottomAnchor = LayoutYAxisAnchor(
//    item: self,
//    attribute: .bottom
//  )
//
//  public private(set) lazy var centerXAnchor = LayoutXAxisAnchor(
//    item: self,
//    attribute: .centerX
//  )
//
//  public private(set) lazy var centerYAnchor = LayoutYAxisAnchor(
//    item: self,
//    attribute: .centerY
//  )
//
//  public private(set) lazy var widthAnchor = LayoutDimension(
//    item: self,
//    attribute: .width
//  )
//
//  public private(set) lazy var heightAnchor = LayoutDimension(
//    item: self,
//    attribute: .height
//  )

//  func addConstraint(_ constraint: LayoutConstraint) {
//    constraints.append(constraint)
//    needsUpdateConstraints = true
//    superview?.needsUpdateConstraints = true
//  }
//
//  func removeConstraint(_ constraint: LayoutConstraint) {
//    constraints.removeAll(where: { $0 === constraint })
//    needsUpdateConstraints = true
//    superview?.needsUpdateConstraints = true
//  }

//  /// Updates the constraints for the receiving view and its subviews.
//  ///
//  /// Whenever a new layout pass is triggered for a view, the system invokes
//  /// this method to ensure that any constraints for the view and its subviews
//  /// are updated with information from the current view hierarchy and its
//  /// constraints. This method is called automatically by the system, but may be
//  /// invoked manually if you need to examine the most up to date constraints.
//  ///
//  /// Subclasses should not override this method.
//  func updateConstraintsIfNeeded() {
//    for subview in subviews {
//      subview.updateConstraintsIfNeeded()
//    }
//
//    if needsUpdateConstraints {
//      updateConstraints()
//      needsUpdateConstraints = false
//    }
//  }

  /// Updates constraints for the view.
  ///
  /// Override this method to optimize changes to your constraints.
  ///
  /// > Note: It's almost always cleaner and easier to update a constraint
  ///   immediately after the affecting change has occurred. For example, if you
  ///   want to change a constraint in response to a button tap, make that
  ///   change directly in the button's action method.
  ///
  ///   You should only override this method when changing constraints in place
  ///   is too slow, or when a view is producing a number of redundant changes.
  ///
  /// To schedule a change, set ``needsUpdateConstraints`` to `true` on the
  /// view. The system then calls your implementation of ``updateConstraints()``
  /// before the layout occurs. This lets you verify that all necessary
  /// constraints for your content are in place at a time when your custom
  /// view's properties aren't changing.
  ///
  /// Your implementation must be as efficient as possible. Don't deactivate all
  /// your constraints, then reactivate the ones you need. Instead, your app
  /// must have some way of tracking your constraints, and validating them
  /// during each update pass. Only change items that need to be changed. During
  /// each update pass, you must ensure that you have the appropriate
  /// constraints for the app's current state.
  ///
  /// Don't call set ``needsUpdateConstraints`` to `true` inside your
  /// implementation. Setting ``needsUpdateConstraints`` to `true` schedules
  /// another update pass, creating a feedback loop.
//  func updateConstraints() {
//    for constraint in constraints where constraint.isActive {
//      guard let firstView = constraint.firstItem as? View else {
//        continue
//      }
//
//      guard !firstView.translatesAutoresizingMaskIntoConstraints else {
//        continue
//      }
//
//      let property = cssProperty(for: constraint.firstAttribute)
//      let value = cssValue(for: constraint)
//
//      if let firstViewID = firstView.id,
//         let property,
//         let value {
//        UIJavaScriptBridge.HTMLElement.setStyleProperty(
//          firstViewID,
//          property.charactersView,
//          property.count,
//          value.charactersView,
//          value.count
//        )
//
//        if constraint.firstAttribute == .centerX {
//          let property = String("--translate-x")
//          let value = String("-50%")
//          UIJavaScriptBridge.HTMLElement.setStyleProperty(
//            firstViewID,
//            property.charactersView,
//            property.count,
//            value.charactersView,
//            value.count
//          )
//        } else if constraint.firstAttribute == .centerY {
//          let property = String("--translate-y")
//          let value = String("-50%")
//          UIJavaScriptBridge.HTMLElement.setStyleProperty(
//            firstViewID,
//            property.charactersView,
//            property.count,
//            value.charactersView,
//            value.count
//          )
//        }
//      }
//    }
//  }

  // TODO: Move to the enum itself.
//  private func cssProperty(
//    for attribute: LayoutConstraint.Attribute
//  ) -> String? {
//    switch attribute {
//    case .leading: return String("left")
//    case .trailing: return String("right")
//    case .top: return String("top")
//    case .bottom: return String("bottom")
//    case .centerX: return String("left")
//    case .centerY: return String("top")
//    case .width: return String("width")
//    case .height: return String("height")
//    case .notAnAttribute: return String("")
//    }
//  }
//
//  // TODO: Move to the enum itself.
//  private func cssValue(for constraint: LayoutConstraint) -> String? {
//    let constant = constraint.constant
//
//    guard let secondView = constraint.secondItem as? View else {
//      return String("\(constant)px")
//    }
//
//    let anchorName = "--view-\(secondView.id ?? 0)"
//
//    switch constraint.firstAttribute {
//    case .width:
//      if constant == 0 {
//        return String("anchor-size(\(anchorName) width)")
//      }
//      return String("calc(anchor-size(\(anchorName) width) + \(constant)px)")
//
//    case .height:
//      if constant == 0 {
//        return String("anchor-size(\(anchorName) height)")
//      }
//      return String("calc(anchor-size(\(anchorName) height) + \(constant)px)")
//
//    case .centerX, .centerY:
//      if constant == 0 {
//        return String("anchor(\(anchorName) center)")
//      }
//      return String("calc(anchor(\(anchorName) center) + \(constant)px)")
//
//    default:
//      let side = switch constraint.secondAttribute {
//      case .leading: "left"
//      case .trailing: "right"
//      case .top: "top"
//      case .bottom: "bottom"
//      case .centerX: "center"
//      case .centerY: "center"
//      default: "left"
//      }
//      if constant == 0 {
//        return String("anchor(\(anchorName) \(side))")
//      }
//      return String("calc(anchor(\(anchorName) \(side)) + \(constant)px)")
//    }
//  }
}

@available(macOS 13.3.0, *)
extension View: @MainActor LayerDelegate {
  public func display(_ layer: Layer) {
    if isHidden {
      JavaScriptBridge.setElementStyleProperty(
        elementID: layer.contents,
        property: String("visibility"),
        value: String("hidden")
      )
    } else {
      JavaScriptBridge.removeElementStyleProperty(
        elementID: layer.contents,
        property: String("visibility")
      )
    }

    // Apply the frame
    JavaScriptBridge.setElementStyleProperty(
      elementID: layer.contents,
      property: String("left"),
      value: String("\(frame.origin.x)px")
    )
    JavaScriptBridge.setElementStyleProperty(
      elementID: layer.contents,
      property: String("top"),
      value: String("\(frame.origin.y)px")
    )
    JavaScriptBridge.setElementStyleProperty(
      elementID: layer.contents,
      property: String("width"),
      value: String("\(frame.size.width)px")
    )
    JavaScriptBridge.setElementStyleProperty(
      elementID: layer.contents,
      property: String("height"),
      value: String("\(frame.size.height)px")
    )
  }

  public func layoutSublayers(of layer: Layer) {
    layoutSubviews()
  }
}

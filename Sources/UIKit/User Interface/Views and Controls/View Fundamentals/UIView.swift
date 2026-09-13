//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIView.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/3/22.
//
//  This source file is part of the UIKit open source project
//
//  Copyright (c) 2025-2026 Fang Ling <fangling@fangl.ing>
//  Licensed under Apache License v2.0
//
//  See LICENSE for license information
//
//  SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//

import CKit
import CoreAnimationKit
import CoreGraphicsKit
import FoundationKit

/// An object that manages the content for a rectangular area on the screen.
///
/// Views are the fundamental building blocks of your app's user interface, and the ``UIView`` class defines the behaviors that are common to all views. A view object renders content within its bounds
/// rectangle, and handles any interactions with that content. The ``UIView`` class is a concrete class that you can instantiate and use to display a fixed background color. You can also subclass it
/// to draw more sophisticated content. To display labels, images, buttons, and other interface elements commonly found in apps, use the view subclasses that the UIKit framework provides rather than
/// trying to define your own.
///
/// Because view objects are the main way your application interacts with the user, they have a number of responsibilities. Here are just a few:
///
///   - Drawing and animation
///     - Views draw content in their rectangular area using UIKit or CoreGraphicsKit.
///     - You can animate some view properties to new values.
///   - Layout and subview management
///     - Views may contain zero or more subviews.
///     - Views can adjust the size and position of their subviews.
///     - Use Auto Layout to define the rules for resizing and repositioning your views in response to changes in the view hierarchy.
///   - Event handling
///     - A view is a subclass of ``UIResponder`` and can respond to touches and other types of events.
///     - Views can install gesture recognizers to handle common gestures.
///
/// Views can nest inside other views to create view hierarchies, which offer a convenient way to organize related content. Nesting a view creates a parent-child relationship between the nested child
/// view (known as the _subview_) and the parent (known as the _superview_). A parent view may contain any number of subviews, but each subview has only one superview. By default, when a subview's
/// visible area extends outside of the bounds of its superview, no clipping of the subview's content occurs. Use the ``clipsToBounds`` property to change that behavior.
///
/// The ``frame`` and ``bounds`` properties define the geometry of each view. The ``frame`` property defines the origin and dimensions of the view in the coordinate system of its superview. The
/// ``bounds`` property defines the internal dimensions of the view as it sees them, and its use is almost exclusive to custom drawing code. The ``center`` property provides a convenient way to
/// reposition a view without changing its ``frame`` or ``bounds`` properties directly.
///
/// ### Create a view
///
/// Normally, you create create views programmatically. When creating a view, you typically specify its initial size and position relative to its future superview. For example, the following example
/// creates a view and places its top-left corner at the point `(10, 10)` in the superview's coordinate system (once it is added to that superview).
///
///    ```swift
///    let myView = UIView(frame: CoreGraphicsRectangle(x: 10, y: 10, width: 100, height: 100))
///    ```
///
/// To add a subview to another view, call the ``addSubview(_:)`` method on the superview. You may add any number of subviews to a view, and sibling views may overlap each other without any issues in
/// UIKit. Each call to the ``addSubview(_:)`` method places the new view on top of all other siblings. You can specify the relative z-order of subview by adding it using the
/// ``insertSubview(_:aboveSubview:)`` and ``insertSubview(_:belowSubview:)`` methods. You can also exchange the position of already added subviews using the ``exchangeSubview(at:withSubviewAt:)``
/// method.
///
/// After creating a view, create Auto Layout rules to govern how the size and position of the view change in response to changes in the rest of the view hierarchy.
///
/// ### Draw views
///
/// View drawing occurs on an as-needed basis. When a view is first shown, or when all or part of it becomes visible due to layout changes, the system asks the view to draw its contents. For views
/// that contain custom content using UIKit or CoreGraphicsKit, the system calls the view's ``draw(_:)`` method. Your implementation of this method is responsible for drawing the view's content into
/// the current graphics context, which is set up by the system automatically prior to calling this method. This creates a static visual representation of your view's content that can then be
/// displayed on the screen.
///
/// When the actual content of your view changes, it's your responsibility to notify the system that your view needs to be redrawn. You do this by calling your view's ``setNeedsDisplay()`` or
/// ``setNeedsDisplay(_:)`` method of the view. These methods let the system know that it should update the view during the next drawing cycle. Because it waits until the next drawing cycle to update
/// the view, you can call these methods on multiple views to update them at the same time.
///
/// ### Animate views
///
/// Changes to several view properties can be animated — that is, changing the property creates an animation starting at the current value and ending at the new value that you specify. The following
/// properties of the ``UIView`` class are animatable:
///
///   - ``frame``
///   - ``bounds``
///   - ``center``
///   - ``transform``
///   - ``alpha``
///   - ``backgroundColor``
///
/// To animate your changes, create a ``UIViewPropertyAnimator`` object and use its handler block to change the values of your view's properties. The ``UIViewPropertyAnimator`` class lets you specify
/// the duration and timing of your animations, but it performs the actual animations. You can pause a property-based animator that's currently running to interrupt the animation and drive it
/// interactively. For more information, see ``UIViewPropertyAnimator``.
///
/// ### Threading considerations
///
/// Manipulations to your app's user interface must occur on the main thread. Thus, you should always call the methods of the ``UIView`` class from code running in the main thread of your app. The
/// only time this may not be strictly necessary is when creating the view object itself, but all other manipulations should occur on the main thread.
///
/// ### Subclassing notes
///
/// The ``UIView`` class is a key subclassing point for visual content that also requires user interactions. Although there are many good reasons to subclass ``UIView``, it is recommended that you do
/// so only when the basic ``UIView`` class or the standard system views do not provide the capabilities that you need. Subclassing requires more work on your part to implement the view and to tune
/// its performance.
///
/// For information about ways to avoid subclassing, see _Alternatives to subclassing_.
///
/// #### Methods to override
///
/// When subclassing ``UIView``, there are only a handful of methods you should override and many methods that you might override depending on your needs. Because ``UIView`` is a highly configurable
/// class, there are also many ways to implement sophisticated view behaviors without overriding custom methods, which are discussed in the _Alternatives to Subclassing_ section. In the meantime, the
/// following list includes the methods you might consider overriding in your ``UIView`` subclasses:
///
///   - Initialization:
///     - ``init(frame:)`` - It is recommended that you implement this method. You can also implement custom initialization methods in addition to, or instead of, this method.
///     - ``layerClass`` - Use this property only if you want your view to use a different CoreAnimationKit layer for its backing store. For example, if your view uses tiling to display a large
///       scrollable area, you might want to set the property to the ``CoreAnimationTiledLayer`` class.
///   - Drawing and printing:
///     - ``draw(_:)`` - Implement this method if your view draws custom content. If your view does not do any custom drawing, avoid overriding this method.
///     - ``draw(_:for:)`` - Implement this method only if you want to draw your view's content differently during printing.
///   - Layout and Constraints:
///     - ``requiresConstraintBasedLayout`` - Use this property if your view class requires constraints to work properly.
///     - ``updateConstraints()`` - Implement this method if your view needs to create custom constraints between your subviews.
///     - ``alignmentRect(forFrame:)``, ``frame(forAlignmentRect:)`` - Implement these methods to override how your views are aligned to other views.
///     - ``didAddSubview(_:)``, ``willRemoveSubview(_:)`` - Implement these methods as needed to track the additions and removals of subviews.
///     - ``willMove(toSuperview:)``, ``didMoveToSuperview()`` - Implement these methods as needed to track the movement of the current view in your view hierarchy.
///   - Event Handling:
///     - ``gestureRecognizerShouldBegin(_:)`` - Implement this method if your view handles touch events directly and might want to prevent attached gesture recognizers from triggering additional
///       actions.
///     - ``touchesBegan(_:with:)``, ``touchesMoved(_:with:)``, ``touchesEnded(_:with:)``, ``touchesCancelled(_:with:)`` - Implement these methods if you need to handle touch events directly. (For
///       gesture-based input, use gesture recognizers.)
///
/// #### Alternatives to subclassing
///
/// Many view behaviors can be configured without the need for subclassing. Before you start overriding methods, consider whether modifying the following properties or behaviors would provide the
/// behavior you need.
///
///   - ``addConstraint(_:)`` - Define automatic layout behavior for the view and its subviews.
///   - ``autoresizingMask`` - Provides automatic layout behavior when the superview's frame changes. These behaviors can be combined with constraints.
///   - ``contentMode`` - Provides layout behavior for the view's content, as opposed to the frame of the view. This property also affects how the content is scaled to fit the view and whether it is
///     cached or redrawn.
///   - ``isHidden`` or ``alpha`` - Change the transparency of the view as a whole rather than hiding or applying alpha to your view's rendered content.
///   - ``backgroundColor`` - Set the view's color rather than drawing that color yourself.
///   - Subviews - Rather than draw your content using a ``draw(_:)`` method, embed image and label subviews with the content you want to present.
///   - Gesture recognizers - Rather than subclass to intercept and handle touch events yourself, you can use gesture recognizers to send an action to a target object.
///   - Animations - Use the built-in animation support rather than trying to animate changes yourself. The animation support provided by CoreAnimationKit is fast and easy to use.
///   - Image-based backgrounds - For views that display relatively static content, consider using a ``UIImageView`` object with gesture recognizers instead of subclassing and drawing the image
///     yourself.
///
/// Animations are another way to make visible changes to a view without requiring you to subclass and implement complex drawing code. Many properties of the ``UIView`` class are animatable, which
/// means changes to those properties can trigger system-generated animations. Starting animations requires as little as one line of code to indicate that any changes that follow should be animated.
/// For more information about animation support for views, see _Animate views_.
///
/// ## Topics
///
/// ### Creating a view object
///
/// - ``init(frame:)``
///
/// ### Configuring a view's visual appearance
///
/// - ``isHidden``
/// - ``layerClass``
/// - ``layer``
///
/// ### Configuring the bounds and frame rectangles
///
/// - ``frame``
/// - ``bounds``
/// - ``center``
///
/// ### Managing the view hierarchy
///
/// - ``superview``
/// - ``subviews``
/// - ``addSubview(_:)``
/// - ``removeFromSuperview()``
/// - ``insertSubview(_:at:)``
///
/// ### Laying out subviews
///
/// - ``layoutSubviews()``
/// - ``setNeedsLayout()``
///
/// ### Drawing and updating the view
///
/// - ``setNeedsDisplay()``
@MainActor
open class UIView: UIResponder {
  /// The class used to create the view's CoreAnimationKit layer.
  ///
  /// The default is ``CoreAnimationKit/CoreAnimationLayer`` class object. Subclasses can override this method and return a different layer class as needed. For example, if your view displays a text
  /// content, you might want to override this property and return the ``CoreAnimationKit/CoreAnimationTextLayer`` class, as shown in the following code.
  ///
  ///    ```swift
  ///    override class var layerClass: AnyClass {
  ///      return CoreAnimationTextLayer.self
  ///    }
  ///    ```
  /// This method is called only once early in the creation of the view in order to create the corresponding layer object.
  open class var layerClass: CoreAnimationLayer.Type {
    return CoreAnimationLayer.self
  }

  /// A Boolean value that determines whether the view is hidden.
  ///
  /// Setting the value of this property to `true` hides the view and setting it to `false` shows the view. The default value is `false`.
  ///
  /// A hidden view disappears from its window and does not receive input events. It remains in its superview's list of subviews, however, and participates in autoresizing as usual. Hiding a view with
  /// subviews has the effect of hiding those subviews and any view descendants they might have. This effect is implicit and does not alter the hidden state of the view's descendants.
  ///
  /// Hiding the view that is the window's current first responder causes the view's next valid key view to become the new first responder.
  ///
  /// The value of this property reflects the state of the view only and does not account for the state of the view's ancestors in the view hierarchy. Thus this property can be `false` but the view
  /// may still be hidden if an ancestor is hidden.
  public var isHidden: CBoolean {
    get {
      return self.layer.isHidden
    }

    set {
      self.layer.isHidden = newValue
      // TODO: Update the responder as necessary.
    }
  }

  /// The view's CoreAnimationKit layer to use for rendering.
  ///
  /// The value of the ``layerClass`` property determines the actual class of the layer object. The view is the layer's delegate.
  ///
  /// > Warning: Because the view is the layer's delegate, never make the view the delegate of another ``CoreAnimationKit/CoreAnimationLayer`` object. Additionally, never change the delegate of this
  ///   layer object.
  public var layer: CoreAnimationLayer

  /// The frame rectangle, which describes the view's location and size in its superview's coordinate system.
  ///
  /// This rectangle defines the size and position of the view in its superview's coordinate system. Use this rectangle during layout operations to set the size and position the view. Setting this
  /// property changes the point specified by the ``center`` property and changes the size in the ``bounds`` rectangle accordingly. The coordinates of the frame rectangle are always specified in
  /// pixels.
  ///
  /// > Warning: If the ``transform`` property is not the identity transform, the value of this property is undefined and therefore should be ignored.
  ///
  /// Changing the frame rectangle automatically redisplays the view without calling its ``draw(_:)`` method. If you want UIKit to call the ``draw(_:)`` method when the frame rectangle changes, set
  /// the ``contentMode`` property to ``UIView.ContentMode.redraw``.
  ///
  /// Changes to this property can be animated. However, if the ``transform`` property contains a non-identity transform, the value of the ``frame`` property is undefined and should not be modified.
  /// In that case, reposition the view using the ``center`` property and adjust the size using the ``bounds`` property instead.
  public var frame: CoreGraphicsRectangle {
    get {
      return self.layer.frame
    }

    set {
      self.layer.frame = newValue
    }
  }

  /// The bounds rectangle, which describes the view's location and size in its own coordinate system.
  ///
  /// The default bounds origin is `(0, 0)` and the size is the same as the size of the rectangle in the ``frame`` property. Changing the size portion of this rectangle grows or shrinks the view
  /// relative to its center point. Changing the size also changes the size of the rectangle in the ``frame`` property to match. The coordinates of the bounds rectangle are always specified in pixels.
  ///
  /// Changes to this property can be animated.
  public var bounds: CoreGraphicsRectangle {
    get {
      return self.layer.bounds
    }

    set {
      self.layer.bounds = newValue
    }
  }

  /// The center point of the view's frame rectangle.
  ///
  /// The center point is specified in pixels in the coordinate system of its superview. Setting this property updates the origin of the rectangle in the ``frame`` property appropriately.
  ///
  /// Use this property, instead of the ``frame`` property, when you want to change the position of a view. The center point is always valid, even when scaling or rotation factors are applied to the
  /// view's transform. Changes to this property can be animated.
  public var center: CoreGraphicsPoint {
    get {
      return self.layer.position
    }

    set {
      self.layer.position = newValue
    }
  }

  /// The view's superview, or `nil` if it has none.
  public private(set) weak var superview: UIView?

  /// The view's immediate subviews.
  ///
  /// You can use this property to retrieve the subviews associated with your custom view hierarchies. The order of the subviews in the array reflects their visible order on the screen, with the view
  /// at index 0 being the back-most view.
  ///
  /// For complex views declared in UIKit and other system frameworks, any subviews of the view are generally considered private and subject to change at any time. Therefore, you should not attempt to
  /// retrieve or modify subviews for these types of system-supplied views. If you do, your code may break during a future system update.
  public private(set) var subviews: FoundationArray<UIView>

  /// Creates a view with the specified frame rectangle.
  ///
  /// The new view object must be inserted into the view hierarchy of a window before it can be used. This method is the designated initializer for the ``UIView`` class. Subclasses can override this
  /// method to perform any custom initialization but must call `super` at the beginning of their implementation.
  ///
  /// - Parameter frame: The frame rectangle for the view, measured in pixels. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to
  ///   set the ``center`` and ``bounds`` properties accordingly.
  public init(frame: CoreGraphicsRectangle) {
    self.layer = Swift::type(of: self).layerClass.init()
    self.subviews = []

    super.init()

    self.layer.delegate = self

    //  self.contentMode = kUIViewContentModeScaleToFill;

    self.frame = frame
  }

  /// Adds a view to the end of the view's list of subviews.
  ///
  /// This method establishes a strong reference to view and sets its next responder to the view, which is its new superview.
  ///
  /// Views can have only one superview. If view already has a superview and that view is not the view, this method removes the previous superview before making the view its new superview.
  ///
  /// - Parameter view: The view to be added. After being added, this view appears on top of any other subviews.
  public func addSubview(_ view: UIView) {
    self.insertSubview(view, at: self.subviews.count)
  }

  /// Unlinks the view from its superview and its window, and removes it from the responder chain.
  ///
  /// If the view's superview is not nil, the superview releases the view.
  ///
  /// Calling this method removes any constraints that refer to the view you are removing, or that refer to any view in the subtree of the view you are removing.
  ///
  /// > Important: Never call this method from inside your view's ``draw(_:)`` method.
  public func removeFromSuperview() {
    guard self.superview != nil else {
      return
    }

    self.superview?.subviews.removeAll(where: { $0 === self })
    self.superview = nil

    self.layer.removeFromSuperlayer()

    // TODO: Auto Layout
  }

  /// Inserts a subview at the specified index.
  ///
  /// This method establishes a strong reference to view and sets its next responder to the view, which is its new superview.
  ///
  /// Views can have only one superview. If view already has a superview and that view is not the view, this method removes the previous superview before making the view its new superview.
  public func insertSubview(_ view: UIView, at index: CInteger) {
    if view.superview !== self {
      view.removeFromSuperview()
    }

    self.subviews.insert(view, at: index)

    self.layer.insertSublayer(view.layer, at: index)

    view.superview = self

    // TODO: Auto Layout
    //  view.setNeedsUpdateConstraints()
    //  self.setNeedsUpdateConstraints()
  }

  /// Lays out subviews.
  ///
  /// The default implementation uses any constraints you set to determine the size and position of any subviews.
  ///
  /// Subclasses can override this method as needed to perform more precise layout of their subviews. You should override this method only if the autoresizing and constraint-based behaviors of the
  /// subviews don't offer the behavior you want. You can use your implementation to set the frame rectangles of your subviews directly.
  ///
  /// Don't call this method directly. If you want to force a layout update, call the ``setNeedsLayout()`` method instead to do so prior to the next drawing update. If you want to update the layout of
  /// your views immediately, call the ``layoutIfNeeded()`` method.
  public func layoutSubviews() {
    // TODO: Start the constraint pass here.
  }

  /// Invalidates the current layout of the view and triggers a layout update during the next update cycle.
  ///
  /// Call this method on your application's main thread when you want to adjust the layout of a view's subviews. This method makes a note of the request and returns immediately. Because this method
  /// does not force an immediate update, but instead waits for the next update cycle, you can use it to invalidate the layout of multiple views before any of those views are updated. This behavior
  /// allows you to consolidate all of your layout updates to one update cycle, which is usually better for performance.
  public func setNeedsLayout() {
    self.layer.setNeedsLayout()
  }

  /// Marks the view's entire bounds rectangle as needing to be redrawn.
  ///
  /// You can use this method or the ``setNeedsDisplay(_:)`` to notify the system that your view's contents need to be redrawn. This method makes a note of the request and returns immediately. The
  /// view is not actually redrawn until the next drawing cycle, at which point all invalidated views are updated.
  ///
  /// You should use this method to request that a view be redrawn only when the content or appearance of the view change. If you simply change the geometry of the view, the view is typically not
  /// redrawn. Instead, its existing content is adjusted based on the value in the view's ``contentMode`` property. Redisplaying the existing content improves performance by avoiding the need to
  /// redraw content that has not changed.
  public func setNeedsDisplay() {
    self.layer.setNeedsDisplay()
  }
}

@MainActor
extension UIView: @MainActor CoreAnimationLayerDelegate {
  public func display(_ layer: CoreAnimationLayer) {
    //  if (self.contentMode != kUIViewContentModeScaleToFill) {
    //    let contentMode = (FoundationString*)nil;
    //    switch (self.contentMode) {
    //      case kUIViewContentModeScaleToFill: contentMode = @"fill"; break;
    //      case kUIViewContentModeScaleAspectFit: contentMode = @"contain"; break;
    //      case kUIViewContentModeScaleAspectFill: contentMode = @"cover"; break;
    //    }
    //
    //    [layer.contents setStyleValue:contentMode forProperty:@"object-fit"];
    //  }
  }

  public func layoutSublayers(of layer: CoreAnimationLayer) {
    self.layoutSubviews()
  }
}

//@implementation UIView
//
//- (nullable UIColor*)backgroundColor {
//  return self.layer.backgroundColor;
//}
//
//- (void)setBackgroundColor:(nullable UIColor*)backgroundColor {
//  self.layer.backgroundColor = backgroundColor;
//}
//
//@end

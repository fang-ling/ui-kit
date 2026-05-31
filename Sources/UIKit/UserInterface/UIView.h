/*
 *  UIView.h
 *  ui-kit
 *
 *  Created by Fang Ling on 2026/5/9.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

#import "../UserInteractions/UIResponder.h"

#import <CKit/CKit.h>
#import <CoreAnimationKit/CoreAnimationKit.h>

C_ASSUME_NONNULL_BEGIN

@interface UIView: UIResponder <CoreAnimationLayerDelegate>

/**
 * The view's Animation Framework layer to use for rendering.
 *
 * This property is never `nil`. The view is the layer's delegate.
 *
 * > Warning: Because the view is the layer's delegate, never make the view
 *   the delegate of another ``Layer`` object. Additionally, never change the
 *   delegate of this layer object.
 */
@property (nonatomic, readonly) CoreAnimationLayer* layer;

/**
 * The class used to create the layer for instances of this class.
 *
 * This property is the ``CoreAnimationDivisionLayer`` class object by default.
 * Subclasses can override this property and sets a different layer class as
 * needed.
 *
 * This property is used only once early in the creation of the view in order to
 * create the corresponding layer object.
 */
@property (nonatomic, readonly, class) Class layerClass;

/**
 * A Boolean value indicating whether the receiver's entire bounds rectangle
 * as needing to be redrawn.
 *
 * You can use set this value to `true` to notify the system that your view's
 * contents need to be redrawn. The view is not actually redrawn until the
 * next drawing cycle, at which point all invalidated views are updated.
 *
 * You should update this value to request that a view be redrawn only when
 * the content or appearance of the view change. If you simply change the
 * geometry of the view, the view is typically not redrawn. Instead, its
 * existing content is adjusted based on the value in the view's
 * ``contentMode`` property. Redisplaying the existing content improves
 * performance by avoiding the need to redraw content that has not changed.
 */
@property (nonatomic) CBoolean needsDisplay;

/**
 * A Boolean value indicating whether the current layout of the receiver as
 * needing a layout update during the next update cycle.
 *
 * Update this value to `true` on your application's main thread when you
 * want to adjust the layout of a view's subviews. Because updating this
 * value does not force an immediate update, but instead waits for the next
 * update cycle, you can use it to invalidate the layout of multiple views
 * before any of those views are updated. This behavior allows you to
 * consolidate all of your layout updates to one update cycle, which is
 * usually better for performance.
 */
@property (nonatomic) CBoolean needsLayout;

// /**
// * A Boolean value that determines whether the view's constraints need updating.
// *
// * The constraint-based layout system uses the return value of this method to
// * determine whether it needs to call ``updateConstraints`` on your view as part
// * of its normal layout pass.
// */
//  var needsUpdateConstraints = true {
//    didSet {
//      if needsUpdateConstraints {
//        superview?.needsUpdateConstraints = true
//      }
//    }
//  }

/**
 * The frame rectangle, which describes the view's location and size in its
 * superview's coordinate system.
 *
 * This rectangle defines the size and position of the view in its superview's
 * coordinate system. Use this rectangle during layout operations to set the
 * size and position the view. Setting this property changes the point specified
 * by the ``center`` property and changes the size in the bounds rectangle
 * accordingly. The coordinates of the frame rectangle are always specified in
 * pixels.
 *
 * > Warning: If the ``transform`` property is not the identity transform, the
 *   value of this property is undefined and therefore should be ignored.
 *
 * Changing the frame rectangle automatically redisplays the view without
 * calling its ``draw()`` method. If you want UIKit to call the ``draw()``
 * method when the frame rectangle changes, set the ``contentMode`` property to
 * ``View.ContentMode.redraw``.
 *
 * Changes to this property can be animated. However, if the ``transform``
 * property contains a non-identity transform, the value of the ``frame``
 * property is undefined and should not be modified. In that case, reposition
 * the view using the ``center`` property and adjust the size using the
 * ``bounds`` property instead.
 */
@property (nonatomic) CoreFoundationRectangle frame;

/**
 * The bounds rectangle, which describes the view's location and size in its
 * own coordinate system.
 *
 * The default bounds origin is `(0,0)` and the size is the same as the size
 * of the rectangle in the ``frame`` property. Changing the size portion of
 * this rectangle grows or shrinks the view relative to its center point.
 * Changing the size also changes the size of the rectangle in the ``frame``
 * property to match. The coordinates of the bounds rectangle are always
 * specified in pixels.
 *
 * Changing the bounds rectangle automatically redisplays the view without
 * calling its ``draw()`` method. If you want UIFramework to call the
 * ``draw()`` method, set the ``contentMode`` property to
 * ``View.ContentMode.redraw``.
 *
 * Changes to this property can be animated.
 */
@property (nonatomic) CoreFoundationRectangle bounds;

/**
 * A Boolean value that determines whether the view is hidden.
 *
 * Setting the value of this property to `true` hides the receiver and
 * setting it to `false` shows the receiver. The default value is `false`.
 *
 * A hidden view disappears from its window and does not receive input
 * events. It remains in its superview's list of subviews, however, and
 * participates in autoresizing as usual. Hiding a view with subviews has the
 * effect of hiding those subviews and any view descendants they might have.
 * This effect is implicit and does not alter the hidden state of the
 * receiver's descendants.
 *
 * Hiding the view that is the window's current first responder causes the
 * view's next valid key view to become the new first responder.
 *
 * The value of this property reflects the state of the receiver only and
 * does not account for the state of the receiver's ancestors in the view
 * hierarchy. Thus this property can be false but the receiver may still be
 * hidden if an ancestor is hidden.
 */
@property (nonatomic) CBoolean isHidden;

//  public var translatesAutoresizingMaskIntoConstraints = true

/**
 * The receiver's superview, or `nil` if it has none.
 */
@property (nonatomic, readonly) UIView* superview;

/**
 * The receiver's immediate subviews.
 *
 * You can use this property to retrieve the subviews associated with your
 * custom view hierarchies. The order of the subviews in the array reflects
 * their visible order on the screen, with the view at index `0` being the
 * back-most view.
 *
 * For complex views declared in UIKit and other system frameworks, any subviews
 * of the view are generally considered private and subject to change at any
 * time. Therefore, you should not attempt to retrieve or modify subviews for
 * these types of system-supplied views. If you do, your code may break during a
 * future system update.
 */
@property (nonatomic, readonly) FoundationMutableArray* subviews;

/**
 * Creates a view with the specified frame rectangle.
 *
 * - Parameter frame: The frame rectangle for the view, measured in pixels.
 *   The origin of the frame is relative to the superview in which you plan
 *   to add it. This method uses the frame rectangle to set the ``center``
 *   and ``bounds`` properties accordingly.
 */
- (instancetype)initWithFrame:(CoreFoundationRectangle)frame;

/**
 * Lays out subviews.
 *
 * The default implementation uses any constraints you set to determine the size
 * and position of any subviews.
 *
 * Subclasses can override this method as needed to perform more precise layout
 * of their subviews. You should override this method only if the autoresizing
 * and constraint-based behaviors of the subviews don't offer the behavior you
 * want. You can use your implementation to set the frame rectangles of your
 * subviews directly.
 *
 * Don't call this method directly. If you want to force a layout update, set
 * the ``needsLayout`` to `true` instead to do so prior to the next drawing
 * update. If you want to update the layout of your views immediately, call
 * the ``layoutIfNeeded()`` method.
 */
- (void)layoutSubviews;

/**
 * Adds a view to the end of the receiver's list of subviews.
 *
 * This method establishes a strong reference to view and sets its next
 * responder to the receiver, which is its new superview.
 *
 * Views can have only one superview. If view already has a superview and that
 * view is not the receiver, this method removes the previous superview before
 * making the receiver its new superview.
 *
 * - Parameter view: The view to be added. After being added, this view appears
 *   on top of any other subviews.
 */
- (void)addSubview:(UIView*)view;

/**
 * Unlinks the view from its superview and its window, and removes it from the
 * responder chain.
 *
 * If the view's superview is not `nil`, the superview releases the view.
 *
 * Calling this method removes any constraints that refer to the view you are
 * removing, or that refer to any view in the subtree of the view you are
 * removing.
 *
 * > Important: Never call this method from inside your view's ``draw()``
 *   method.
 */
- (void)removeFromSuperview;

@end

C_ASSUME_NONNULL_END

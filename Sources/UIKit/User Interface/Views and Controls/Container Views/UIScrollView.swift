//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIScrollView.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/7/11.
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

#if !os(iOS)

import CKit
import CoreAnimationKit
import CoreGraphicsKit

/// A view that allows the scrolling and zooming of its contained views.
///
/// ``UIScrollView`` is the superclass of several UIKit classes, including ``UITableView`` and ``UITextView``.
///
/// A scroll view is a view with an origin that's adjustable over the content view. It clips the content to its frame, which generally (but not necessarily) coincides with that of the app's main
/// window. A scroll view tracks the movements of fingers, and adjusts the origin accordingly. The view that shows its content through the scroll view draws that portion of itself according to the new
/// origin, which is pinned to an offset in the content view. The scroll view itself does no drawing except for displaying vertical and horizontal scroll indicators. The scroll view must know the size
/// of the content view so it knows when to stop scrolling. By default, it bounces back when scrolling exceeds the bounds of the content.
///
/// The object that manages the drawing of content that displays in a scroll view needs to tile the content's subviews so that no view exceeds the size of the screen. As users scroll in the scroll
/// view, this object adds and removes subviews as necessary.
///
/// Because a scroll view has no scroll bars, it must know whether a touch signals an intent to scroll versus an intent to track a subview in the content. To make this determination, it temporarily
/// intercepts a touch-down event by starting a timer and, before the timer fires, seeing if the touching finger makes any movement. If the timer fires without a significant change in position, the
/// scroll view sends tracking events to the touched subview of the content view. If the user then drags their finger far enough before the timer elapses, the scroll view cancels any tracking in the
/// subview and performs the scrolling itself. Subclasses can override the ``touchesShouldBegin(_:with:in:)``, ``isPagingEnabled``, and ``touchesShouldCancel(in:)`` methods (which the scroll view
/// calls) to affect how the scroll view handles scrolling gestures.
///
/// A scroll view also handles zooming and panning of content. As the user makes a pinch-in or pinch-out gesture, the scroll view adjusts the offset and the scale of the content. When the gesture
/// ends, the object managing the content view updates subviews of the content as necessary. (Note that the gesture can end and a finger might still be down.) While the gesture is in progress, the
/// scroll view doesn't send any tracking calls to the subview.
///
/// The ``UIScrollView`` class can have a delegate that must adopt the ``UIScrollViewDelegate`` protocol. For zooming and panning to work, the delegate must implement both ``viewForZooming(in:)`` and
/// ``scrollViewDidEndZooming(_:with:atScale:)``. In addition, the ``maximumZoomScale`` and ``minimumZoomScale`` zoom scales must be different.
///
/// ### State preservation
///
/// If you assign a value to this view's ``restorationIdentifier`` property, it attempts to preserve its scrolling-related information between app launches. Specifically, the values of the
/// ``zoomScale``, ``contentInset``, and ``contentOffset`` properties are preserved. During restoration, the scroll view restores these values so that the content appears scrolled to the same position
/// as before.
///
/// ## Topics
///
/// ### Responding to scroll view interactions
///
/// - ``delegate``
/// - ``UIScrollViewDelegate``
///
/// ### Managing the content size and offset
///
/// - ``contentSize``
/// - ``contentOffset``
/// - ``setContentOffset(_:animated:)``
@MainActor
open class UIScrollView: UIView {
  private let _contentView: UIView

  /// The delegate of the scroll view.
  ///
  /// The delegate must adopt the ``UIScrollViewDelegate`` protocol. The ``UIScrollView`` class, which doesn't retain the delegate, invokes each protocol method the delegate implements.
  public weak var delegate: (any UIScrollViewDelegate)?

  /// The size of the content view.
  ///
  /// The unit of size is pixels. The default size is ``CoreGraphicsKit/CoreGrahicsSize/zero``.
  public var contentSize: CoreGraphicsSize {
    didSet {
      self._contentView.frame = CoreGraphicsRectangle(x: 0, y: 0, width: self.contentSize.width, height: self.contentSize.height)

      self._contentView.setNeedsLayout()
    }
  }

  /// The point at which the origin of the content view is offset from the origin of the scroll view.
  ///
  /// The default value is ``CoreGraphicsKit/CoreGraphicsPoint/zero``.
  public var contentOffset: CoreGraphicsPoint {
    get {
      return self.bounds.origin
    }

    set {
      guard newValue != self.contentOffset else {
        return
      }

      self.setContentOffset(newValue, animated: false)

      // Unlike when the user scrolls, the browser doesn't know about the new offset yet. The scroll event that the browser sends back carries the same offset, so it's ignored.
      self.layer._viewElement._setScrollOffset(left: newValue.x, top: newValue.y)
    }
  }

  public override init(frame: CoreGraphicsRectangle) {
    // The browser derives the scrollable area from the extent of the subviews, so a content view that has the content size makes the scrollable area match it exactly.
    self._contentView = UIView(frame: CoreGraphicsRectangle(x: 0, y: 0, width: 0, height: 0))
    self.contentSize = CoreGraphicsSize(width: 0, height: 0)

    super.init(frame: frame)

    super.insertSubview(self._contentView, at: 0)
  }

  /// Sets the point at which the origin of the content view is offset from the origin of the scroll view.
  ///
  /// - Parameters:
  ///   - contentOffset: A point (expressed in pixels) that's offset from the content view's origin.
  ///   - animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
  public func setContentOffset(_ contentOffset: CoreGraphicsPoint, animated: CBoolean) {
    guard contentOffset != self.contentOffset else {
      return
    }

    self.bounds = CoreGraphicsRectangle(origin: contentOffset, size: self.bounds.size)

    self.delegate?.scrollViewDidScroll(self)
  }

  public override func addSubview(_ view: UIView) {
    self._contentView.addSubview(view)
  }

  public override func insertSubview(_ view: UIView, at index: CInteger) {
    self._contentView.insertSubview(view, at: index)
  }

  public override func display(_ layer: CoreAnimationLayer) {
    super.display(layer)

    self.layer._viewElement.style.overflow = "auto"
  }
}

#endif

//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIScrollViewDelegate.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/7/19.
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

import SwiftFramework

/// The interface for the delegate of a scroll view.
///
/// The methods that the ``UIScrollViewDelegate`` protocol declares allow the adopting delegate to respond to messages from the ``UIScrollView`` class. The delegate responds to and affects operations
/// like scrolling, zooming, deceleration of scrolled content, and scrolling animations.
///
/// ## Topics
///
/// ### Responding to scrolling and dragging
///
/// - ``scrollViewDidScroll(_:)``
@MainActor
public protocol UIScrollViewDelegate: SwiftAnyObject {
  /// Tells the delegate when the user scrolls the content view within the scroll view.
  ///
  /// The delegate typically implements this method to obtain the change in content offset from `scrollView` and draw the affected portion of the content view.
  ///
  /// - Parameter scrollView: The scroll-view object in which the scrolling occurred.
  func scrollViewDidScroll(_ scrollView: UIScrollView)
}

extension UIScrollViewDelegate {
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {}
}

#endif

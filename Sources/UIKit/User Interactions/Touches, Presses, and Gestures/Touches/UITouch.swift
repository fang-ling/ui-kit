//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UITouch.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/9/20.
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
import CoreGraphicsKit
import SwiftFramework

/// An object representing the location, size, movement, and force of a touch occurring on the screen.
///
/// You access touch objects through ``UIEvent`` objects passed into responder objects for event handling. A touch object includes accessors for:
///
///   - The view or window in which the touch occurred
///   - The location of the touch within the view or window
///   - The approximate radius of the touch
///   - The force of the touch (on devices that support 3D Touch or Apple Pencil)
///
/// A touch object also contains a timestamp indicating when the touch occurred, an integer representing the number of times the user tapped the screen, and the phase of the touch in the form of a
/// constant that describes whether the touch began, moved, or ended, or whether the system canceled the touch.
///
/// A touch object persists throughout a multi-touch sequence. You may store a reference to a touch while handling a multi-touch sequence, as long as you release that reference when the sequence ends.
/// If you need to store information about a touch outside of a multi-touch sequence, copy that information from the touch.
///
/// The ``gestureRecognizers`` property of a touch contains the gesture recognizers currently handling the touch. Each gesture recognizer is an instance of a concrete subclass of
/// ``UIGestureRecognizer``.
///
/// ## Topics
///
/// ### Getting the location of a touch
///
/// - ``view``
/// - ``window``
///
/// ### Getting touch attributes
///
/// - ``phase``
/// - ``UITouch/Phase``
@MainActor
public class UITouch: @MainActor SwiftEquatable, @MainActor SwiftHashable {
  internal var _location: CoreGraphicsPoint

  /// The view to which touches are being delivered, if any.
  ///
  /// The value of this property is the view object to which touches are being delivered, which is not necessarily the view the touch is currently in. For example, when a gesture recognizer recognizes
  /// the touch, this property is `nil` because no view is receiving the touch.
  public weak var view: UIView?

  /// The window in which the touch initially occurred.
  ///
  /// The value of the property is the window in which the touch originally occurred. This window might not be the same window that currently contains the touch.
  public weak var window: UIWindow?

  /// The phase of the touch.
  ///
  /// The property value is a constant that indicates whether the touch began, moved, ended, or was canceled. For descriptions of the possible values of this property, see ``UITouch/Phase``.
  public var phase: UITouch.Phase

  internal init(phase: UITouch.Phase, location: CoreGraphicsPoint) {
    self.phase = phase
    self._location = location
  }

  public static func == (lhs: UITouch, rhs: UITouch) -> CBoolean {
    return SwiftObjectIdentifier(lhs) == SwiftObjectIdentifier(rhs)
  }

  public func hash(into hasher: inout SwiftHasher) {
    return hasher.combine(SwiftObjectIdentifier(self))
  }
}

#endif

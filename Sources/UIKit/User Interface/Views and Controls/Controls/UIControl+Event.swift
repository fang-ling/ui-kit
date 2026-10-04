//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIControl+Event.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/9/25.
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
import SwiftFramework

extension UIControl {
  /// Constants describing the types of events possible for controls.
  ///
  /// You set up a control so that it sends an action message to a target object by associating action with one or more control events. To do this, send ``addAction(_:for:)`` to the control for each
  /// action you want to specify.
  ///
  /// ## Topics
  ///
  /// ### Constants
  ///
  /// - ``touchDown``
  /// - ``touchUpInside``
  /// - ``touchCancel``
  /// - ``primaryActionTriggered``
  public struct Event: SwiftOptionSet, SwiftSendable, SwiftRawRepresentable, SwiftHashable {
    /// The corresponding value of the raw type.
    public let rawValue: CInteger

    /// A touch-down event in the control.
    public static let touchDown = Event(rawValue: 1 << 0)

    /// A touch-up event in the control where the finger is inside the bounds of the control.
    public static let touchUpInside = Event(rawValue: 1 << 6)

    /// A system event canceling the current touches for the control.
    public static let touchCancel = Event(rawValue: 1 << 8)

    /// A semantic action triggered by buttons.
    public static let primaryActionTriggered = Event(rawValue: 1 << 11)

    /// Creates a control event with the specified raw value.
    ///
    /// - Parameter rawValue: The raw value of the control event to create.
    public init(rawValue: CInteger) {
      self.rawValue = rawValue
    }
  }
}

#endif

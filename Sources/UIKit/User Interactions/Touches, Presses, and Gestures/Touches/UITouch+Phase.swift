//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UITouch+Phase.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/10/4.
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

extension UITouch {
  /// The phase of a touch event.
  ///
  /// The phase of a ``UITouch`` instance changes as the system receives updates during the course of an event. Access this value through the ``UITouch/phase`` property.
  ///
  /// ## Topics
  ///
  /// ### Constants
  ///
  /// - ``began``
  /// - ``moved``
  /// - ``ended``
  /// - ``cancelled``
  public enum Phase: CInteger {
    /// A touch for a given event has pressed down on the screen.
    case began = 0

    /// A touch for a given event has moved over the screen.
    case moved = 1

    /// A touch for a given event has lifted from the screen.
    case ended = 3

    /// The system canceled tracking for a touch, for example, when the user moves the device against their face.
    case cancelled = 4
  }
}

#endif

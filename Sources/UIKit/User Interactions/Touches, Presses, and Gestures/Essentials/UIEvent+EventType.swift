//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIEvent+EventType.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/9/27.
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

extension UIEvent {
  /// Constants that specify the general type of an event.
  ///
  /// You can obtain the type of an event from the ``UIEvent/type`` property. To further identify the event, you might also need to determine its subtype, which you obtain from the ``UIEvent/subtype``
  /// property.
  ///
  /// ## Topics
  ///
  /// ### Constants
  ///
  /// - ``touches``
  public enum EventType {
    /// The event relates to touches on the screen.
    case touches
  }
}

#endif

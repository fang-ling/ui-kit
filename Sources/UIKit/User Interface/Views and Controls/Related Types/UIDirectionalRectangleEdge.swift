//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIDirectionalRectangleEdge.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/6/7.
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

/// Constants that specify an edge or a set of edges, taking the user interface layout direction into account.
///
/// ## Topics
///
/// ### Constants
///
/// - ``top``
/// - ``leading``
/// - ``bottom``
/// - ``trailing``
/// - ``all``
public struct UIDirectionalRectangleEdge: SwiftSendable, SwiftOptionSet, SwiftRawRepresentable {
  public var rawValue: CUnsignedInteger

  /// The top edge.
  public static let top = UIDirectionalRectangleEdge(rawValue: 1 << 0)

  /// The leading edge.
  public static let leading = UIDirectionalRectangleEdge(rawValue: 1 << 1)

  /// The bottom edge.
  public static let bottom = UIDirectionalRectangleEdge(rawValue: 1 << 2)

  /// The trailing edge.
  public static let trailing = UIDirectionalRectangleEdge(rawValue: 1 << 3)

  /// All edges.
  public static let all: UIDirectionalRectangleEdge = [.top, .leading, .bottom, .trailing]

  /// Creates an edge with the specified raw value.
  ///
  /// - Parameter rawValue: The raw value.
  public init(rawValue: CUnsignedInteger) {
    self.rawValue = rawValue
  }
}

#else

import UIKit

/// Constants that specify an edge or a set of edges, taking the user interface layout direction into account.
public typealias UIDirectionalRectangleEdge = NSDirectionalRectEdge

#endif

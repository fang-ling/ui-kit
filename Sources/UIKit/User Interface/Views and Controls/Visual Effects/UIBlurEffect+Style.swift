//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIBlurEffect+Style.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/10/6.
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

extension UIBlurEffect {
  /// Blur styles available for blur effect objects.
  ///
  /// ## Topics
  ///
  /// ### Adaptable styles
  ///
  /// - ``systemChromeMaterial``
  public enum Style {
    /// An adaptable blur effect that creates the appearance of the system chrome.
    case systemChromeMaterial
  }
}

#endif

//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIBlurEffect.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/6/20.
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

/// An object that applies a blurring effect to the content layered behind a visual effect view.
///
/// Views that you add to the ``UIVisualEffectView/contentView`` of a visual effect view aren't affected by the blur effect.
///
/// ## Topics
///
/// ### Creating a blur effect
///
/// - ``init(style:)``
@MainActor
public class UIBlurEffect: UIVisualEffect {
  internal var _background: SwiftString

  internal var _backgroundBlendMode: SwiftString

  /// Creates a blur effect with the designated style.
  ///
  /// - Parameter style: The intensity of the blur effect. See ``UIBlurEffect/Style`` for valid options.
  public init(style: Style) {
    switch style {
    case .systemChromeMaterial:
      self._background = "SystemChromeMaterialBackground"
      self._backgroundBlendMode = "SystemChromeMaterialBackgroundBlendMode"
    }
  }
}

#endif

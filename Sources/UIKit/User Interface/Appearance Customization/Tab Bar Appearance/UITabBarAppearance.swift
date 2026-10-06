//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UITabBarAppearance.swift
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

/// An object for customizing the appearance of a tab bar.
///
/// After creating a ``UITabBarAppearance`` object, use the methods and properties of this class to specify the appearance of items in the tab bar. Use the inherited properties from
/// ``UIBarAppearance`` to configure the background and shadow attributes of the tab bar itself.
@MainActor
open class UITabBarAppearance: UIBarAppearance {
  public override init() {
    super.init()

    self.backgroundEffect = UIBlurEffect(style: .systemChromeMaterial)
    self.shadowColor = UIColor(named: "SystemChromeShadowColor")
  }
}

#endif

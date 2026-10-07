//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIButton+ConfigurationUpdateHandler.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/10/3.
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

extension UIButton {
  /// A closure to update the configuration of a button.
  ///
  /// - Parameter button: The button to update.
  public typealias ConfigurationUpdateHandler = (UIButton) -> SwiftVoid
}

#endif

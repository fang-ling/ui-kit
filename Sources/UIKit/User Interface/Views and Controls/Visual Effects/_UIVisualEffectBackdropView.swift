//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  _UIVisualEffectBackdropView.swift
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

import CoreAnimationKit

@MainActor
internal class _UIVisualEffectBackdropView: UIView {
  internal override func display(_ layer: CoreAnimationLayer) {
    super.display(layer)

    // Used for chrome, thick, regular, thin and ultraThin in both light and dark modes.
    layer._viewElement.style.backdropFilter = "blur(25px)"
  }
}

#endif

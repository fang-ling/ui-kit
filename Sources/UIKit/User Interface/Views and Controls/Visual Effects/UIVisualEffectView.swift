//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIVisualEffectView.swift
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
import CoreGraphicsKit

/// An object that implements some complex visual effects.
///
/// Depending on the desired effect, the effect may affect content layered behind the view or content added to the visual effect view's ``contentView``. Apply a visual effect view to an existing view
/// and then apply a ``UIBlurEffect`` or ``UIVibrancyEffect`` object to apply a blur or vibrancy effect to the existing view. After you add the visual effect view to the view hierarchy, add any
/// subviews to the ``contentView`` property of the visual effect view. Don't add subviews directly to the visual effect view itself.
///
/// ### Set the correct alpha value
///
/// When using the ``UIVisualEffectView`` class, avoid alpha values that are less than `1`. Creating views that are partially transparent causes the system to combine the view and all the associated
/// subviews during an offscreen render pass. ``UIVisualEffectView`` objects need to be combined as part of the content they're layered on top of in order to look correct. Setting the alpha to less
/// than `1` on the visual effect view or any of its superviews causes many effects to look incorrect or not show up at all.
///
/// ### Use masks with a visual effect view
///
/// Masks directly applied to a ``UIVisualEffectView`` are forwarded to the internal views that provide the visual effect, including the ``contentView`` itself. You can also apply masks directly to
/// the ``contentView``. Applying a mask to a superview of a ``UIVisualEffectView`` object causes the effect to fail, and an exception is thrown.
///
/// Any mask provided to ``UIVisualEffectView`` isn't the view that actually performs the mask. UIKit makes a copy of the view and applies it to each subview. To reflect a size change to the mask, you
/// must apply the change to the original mask and reset it on the effect view.
///
/// ### Capture a snapshot of a visual effect view
///
/// Many effects require support from the window that hosts the ``UIVisualEffectView``. Attempting to take a snapshot of only the ``UIVisualEffectView`` results in a snapshot that doesn't contain the
/// effect. To take a snapshot of a view hierarchy that contains a ``UIVisualEffectView``, you must take a snapshot of the entire ``UIWindow`` or ``UIScreen`` that contains it.
///
/// ## Topics
///
/// ### Creating a visual effect view
///
/// - ``init(effect:)``
///
/// ### Retrieving view information
///
/// - ``effect``
@MainActor
public class UIVisualEffectView: UIView {
  /// The visual effect provided by the view.
  ///
  /// The effect is either a ``UIBlurEffect`` or a ``UIVibrancyEffect``.
  public var effect: UIVisualEffect?

  /// Creates a new visual effect view with the designated visual effect.
  ///
  /// - Parameter effect: The ``UIVisualEffect`` you provide for the view. This can be a ``UIBlurEffect`` or a ``UIVibrancyEffect``.
  public init(effect: UIVisualEffect?) {
    super.init(frame: CoreGraphicsRectangle(x: 0, y: 0, width: 0, height: 0))

    self.effect = effect

    if effect is UIBlurEffect {
      self.addSubview(_UIVisualEffectBackdropView(frame: CoreGraphicsRectangle(x: 0, y: 0, width: 0, height: 0)))
    }
  }

  public override func layoutSubviews() {
    super.layoutSubviews()

    self.subviews.first?.frame = CoreGraphicsRectangle(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
  }

  public override func display(_ layer: CoreAnimationLayer) {
    super.display(layer)

    if let blurEffect = self.effect as? UIBlurEffect {
      self.layer._viewElement.style.background = "var(--\(blurEffect._background))"
      self.layer._viewElement.style.backgroundBlendMode = "var(--\(blurEffect._backgroundBlendMode))"
    }
  }
}

#endif

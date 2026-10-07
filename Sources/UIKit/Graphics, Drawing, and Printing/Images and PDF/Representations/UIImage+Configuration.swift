//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIImage+Configuration.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/6/6.
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

extension UIImage {
  /// A configuration object that contains the traits that the system uses when selecting the current image variant.
  ///
  /// Images may contain multiple variants to account for environmental factors, such as whether the interface is light or dark. The image configuration object lets you override the current
  /// environment and render an image with specific attributes. For example, you might want to render a specific version of your image to your interface.
  ///
  /// ``UIImage/Configuration`` objects are immutable and you don't create them directly. Instead, get an existing image configuration object from a ``UITraitCollection`` or ``UIImage`` object. To add
  /// attributes to your configuration object, use the ``applying(_:)`` method to create a new object that merges the existing object's values with new values you supply. Assign the new object to the
  /// ``UIImageView/preferredSymbolConfiguration`` property of the ``UIImageView`` object you use to display the image. If you draw the image directly, use the ``withConfiguration(_:)`` method to
  /// create a new image that contains the new attributes.
  public class Configuration {}
}

#endif

//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIButton+Configuration.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/5/31.
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

extension UIButton {
  /// A configuration that specifies the appearance and behavior of a button and its contents.
  ///
  /// You can configure and update a button with a ``UIButton/Configuration``. A button configuration contains all the customization options available with other methods, such as ``setTitle(_:for:)``,
  /// and can serve as a replacement for those methods. Alternatively, you can use a configuration in combination with these other methods and adopt new button behaviors and appearance without
  /// rewriting your customized ``UIButton`` code.
  ///
  /// ## Topics
  ///
  /// ### Creating configurations
  ///
  /// - ``plain()``
  ///
  /// ### Configuring titles
  ///
  /// - ``title``
  ///
  /// ### Configuring images
  ///
  /// - ``image``
  /// - ``imagePadding``
  /// - ``imagePlacement``
  /// - ``preferredSymbolConfigurationForImage``
  ///
  /// ### Configuring button colors
  ///
  /// - ``baseForegroundColor``
  public struct Configuration {
    /// The text of the title label the button displays.
    ///
    /// This property matches the string value of the ``attributedTitle`` property. To change the button title when the button state changes, use ``UIButton/configurationUpdateHandler`` or
    /// ``UIButton/updateConfiguration()``.
    public var title: SwiftString?

    /// The foreground image the button displays.
    ///
    /// A configuration contains one image. To change the image based on button state, use ``UIButton/configurationUpdateHandler`` or ``UIButton/updateConfiguration()``.
    public var image: UIImage?

    /// The distance between the button's image and text.
    ///
    /// Use this property to adjust the distance from the title and subtitle. This doesn't affect the distance to the button's edge.
    public var imagePadding: CFloatingPoint64

    /// The edge against which the button places the image.
    ///
    /// Use this property to place the image along the top, leading, trailing, or bottom edge of the button.
    public var imagePlacement: UIDirectionalRectangleEdge

    /// A requested configuration object for the button symbol image.
    ///
    /// A symbol configuration defines details such as the point size, scale, text style, weight, and font of symbol image. The button uses these details to determine which variant of the image to use
    /// and how to scale or style the image.
    public var preferredSymbolConfigurationForImage: UIImage.SymbolConfiguration?

    /// The untransformed color for foreground views.
    ///
    /// The button configuration may transform the base color before applying it to foreground views.
    public var baseForegroundColor: UIColor?

    /// Creates a configuration for a button with a transparent background.
    ///
    /// - Returns: A new configuration object.
    public static func plain() -> UIButton.Configuration {
      return Configuration(imagePadding: 0, imagePlacement: .all)
    }
  }
}

#endif

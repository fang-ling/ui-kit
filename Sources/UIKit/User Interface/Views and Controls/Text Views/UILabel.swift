//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UILabel.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/3/22.
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
import JavaScriptCoreKit
import SwiftFramework

/// A view that displays one or more lines of informational text.
///
/// You can configure the overall appearance of a label's text, and use attributed strings to customize the appearance of substrings within the text.
///
/// Follow these steps to add a label to your interface:
///
///   - Supply either a string or an attributed string that represents the content.
///   - If you're using a nonattributed string, configure the appearance of the label.
///   - Set up Auto Layout rules to govern the size and position of the label in your interface.
///   - Provide accessibility information and localized strings.
///
/// ### Customize the label's appearance
///
/// You provide the content for a label by assigning either a ``SwiftFramework/SwiftString`` object to the ``text`` property, or a ``FoundationKit/FoundationAttributedString`` object to the
/// ``attributedText`` property. The label displays the property set most recently.
///
/// The ``attributedText`` property allows you to control the appearance of individual characters and groups of characters, using the ``FoundationKit/FoundationAttributedString`` API.
///
/// If you want to format the label's text in a uniform fashion, set the ``text`` property to a ``SwiftFramework/SwiftString`` object containing the content, and configure the ``font``, ``textColor``,
/// ``textAlignment``, and ``lineBreakMode`` properties.
///
/// If you set these appearance properties on a label that displays the content of the ``attributedText`` property, the label overrides the appropriate attributes and displays the attributed string
/// with a uniform appearance.
///
/// Specify the maximum number of lines for the label to use when laying out the text with the ``numberOfLines`` property. Setting a value of `0` allows the label to use as many lines as necessary to
/// lay out the text within the label's width. Use the ``lineBreakMode`` property to control how the label splits the text into multiple lines, and the truncation behavior associated with the final
/// line.
///
/// Use Auto Layout to position and optionally size the label. The intrinsic content size for a label defaults to the size that displays the entirety of the content on a single line. If you provide
/// Auto Layout constraints that define the width of the label but not the height, the label's intrinsic content size adjusts the height to display the text completely.
///
/// When the label has its size completely defined externally, you can specify how it handles the situation when its content doesn't fit within the bounds. To reduce the font size, set the
/// ``adjustsFontSizeToFitWidth`` property to `true` and set the ``minimumScaleFactor`` property to a value between `0` and `1`. The latter of these properties represents how much smaller than the
/// requested font size the label scales the text. Setting the ``allowsDefaultTighteningForTruncation`` property to `true` instructs the label to reduce the spacing between characters before
/// truncating the string.
///
/// ### Design labels for a wide audience
///
/// Labels provide valuable information to your users. To make sure that information reaches a wide audience, internationalize text and support accessibility in your labels. Labels are accessible to
/// VoiceOver by default. The default accessibility traits for a label are Static Text and User Interaction Enabled.
///
/// ## Topics
///
/// ### Accessing the text attributes
///
/// - ``text``
/// - ``font``
/// - ``textColor``
@MainActor
public class UILabel: UIView {
  public override class var layerClass: CoreAnimationLayer.Type {
    return CoreAnimationTextLayer.self
  }

  private var _font: UIFont?

  private var _textColor: UIColor?

  /// The text that the label displays.
  ///
  /// This property is `nil` by default. Assigning a new value to this property also replaces the value of the ``attributedText`` property with the same text, although without any inherent style
  /// attributes. Instead the label styles the new string using ``shadowColor``, ``textAlignment``, and other style-related properties of the class.
  public var text: SwiftString? {
    didSet {
      if let layer = self.layer as? CoreAnimationTextLayer {
        layer.string = self.text
      }

      // TODO: self.invalidateIntrinsicContentSize()

      self.setNeedsLayout()
      self.setNeedsDisplay()
    }
  }

  /// The font of the text.
  ///
  /// If you're using styled text, assigning a new value to this property applies the font to the entirety of the string in the ``attributedText`` property. If you want to apply the font to only a
  /// portion of the text, create a new attributed string with the desired style information and associate it with the label. If you aren't using styled text, this property applies to the entire text
  /// string in the ``text`` property.
  ///
  /// The default value for this property is the system font at a size of 17 pixels (using the ``UIFont/systemFont(ofSize:)`` class method of ``UIFont``). Setting this property to `nil` causes it to
  /// be reset to the default value.
  public var font: UIFont! {
    get {
      return self._font ?? UIFont.systemFont(ofSize: 17)
    }

    set {
      self._font = newValue

      if let layer = self.layer as? CoreAnimationTextLayer {
        layer.fontSize = newValue.pixelSize
        layer._fontWeight = newValue.weight.rawValue
        layer._lineHeight = "\(newValue.lineHeight)px"
      }

      self.setNeedsLayout()
      self.setNeedsDisplay()
    }
  }

  /// The color of the text.
  ///
  /// If you're using styled text, assigning a new value to this property applies the color to the entirety of the string in the ``attributedText`` property. If you want to apply the color to only a
  /// portion of the text, create a new attributed string with the desired style information and associate it with the label. If you aren't using styled text, this property applies to the entire text
  /// string in the ``text`` property.
  ///
  /// The default value for this property is the system's label color, which adapts dynamically to Dark Mode changes. Setting this property to `nil` causes it to be reset to the default value.
  public var textColor: UIColor! {
    get {
      return self._textColor ?? UIColor.label
    }

    set {
      self._textColor = newValue

      self.setNeedsDisplay()
    }
  }

  public override func display(_ layer: CoreAnimationLayer) {
    super.display(layer)

    // Texts are vertically centered by default.
    self.layer._viewElement.style.display = "flex"
    self.layer._viewElement.style.alignItems = "center"

    // Do not draw text outside the frame.
    self.layer._viewElement.style.overflow = "hidden"
  }
}

#endif

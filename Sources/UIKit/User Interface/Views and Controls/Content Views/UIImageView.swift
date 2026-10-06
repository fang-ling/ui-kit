//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIImageView.swift
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

import CKit
import CoreAnimationKit
import CoreGraphicsKit

/// A view that displays a single image or a sequence of animated images in your interface.
///
/// Image views let you efficiently draw any image that can be specified using a ``UIImage`` object. For example, you can use the ``UIImageView`` class to display the contents of many standard image
/// files, such as JPEG and PNG files. You can configure image views programmatically and change the images they display at runtime. For animated images, you can also use the methods of this class to
/// start and stop the animation and specify other animation parameters.
///
/// ### Understand how images are scaled
///
/// An image view uses its ``UIView/contentMode`` property and the configuration of the image itself to determine how to display the image. It's best to specify images whose dimensions match the
/// dimensions of the image view exactly, but image views can scale your images to fit all or some of the available space. If the size of the image view itself changes, it automatically scales the
/// image as needed.
///
/// For an image without cap insets, the presentation of the image is determined solely by the image view's ``UIView/contentMode`` property. The ``UIView/ContentMode/scaleAspectFit`` and
/// ``UIView/ContentMode/scaleAspectFill`` modes scale the image to fit or fill the space while maintaining the image's original aspect ratio. The ``UIView/ContentMode/scaleToFill`` value scales the
/// image without regard to the original aspect ratio, which can cause the image to appear distorted. Other content modes place the image at the appropriate location in the image view's bounds without
/// scaling it.
///
/// For a resizable image with cap insets, those insets affect the final appearance of the image. Specifically, cap insets define which parts of the image may be scaled and in which directions. You
/// can create a resizable image that stretches using the ``resizableImage(withCapInsets:resizingMode:)`` method of ``UIImage``. When using an image of this type, you typically set the image view's
/// content mode to ``UIView/ContentMode/scaleToFill`` so that the image stretches in the appropriate places and fills the image view’s bounds.
///
/// ### Determine the final transparency of the image
///
/// Images are composited onto the image view's background and are then composited into the rest of the window. Any transparency in the image allows the image view's background to show through.
/// Similarly, any further transparency in the background of the image is dependent on the transparency of the image view and the transparency of the ``UIImage`` object it displays. When the image
/// view and its image both have transparency, the image view uses alpha blending to combine the two.
///
///   - The image is composited onto the image view's background.
///   - If the image view's ``isOpaque`` property is `true`, the image's pixels are composited on top of the image view's background color and the ``alpha`` property of the image view is ignored.
///   - If the image view's ``isOpaque`` property is `false`, the alpha value of each pixel is multiplied by the image view's ``alpha`` value, with the resulting value becoming the actual transparency
///     value for that pixel. If the image doesn't have an alpha channel, the alpha value of each pixel is assumed to be `1.0`.
///
/// > Important: It's computationally expensive to composite the alpha channel of an image with the alpha channel of a non-opaque image view. The performance impact is further magnified if you use
///   CoreAnimationFramework shadows, because the shape of the shadow is then based on the contents of the view and must be dynamically computed. If you aren't intentionally using the alpha channel of
///   the image or the alpha channel of the image view, set the ``isOpaque`` property to `true` to improve performance.
///
/// ### Animate a sequence of images
///
/// An image view can store an animated image sequence and play all or part of that sequence. You specify an image sequence as an array of ``UIImage`` objects and assign them to the
/// ``animationImages`` property. Once assigned, you can use the methods and properties of this class to configure the animation timing and to start and stop the animation.
///
/// > Note: You can also construct a single ``UIImage`` object from a sequence of individual images using the ``animatedImage(with:duration:)`` method. Doing so yields the same results as assigning
///   the individual images to the ``animationImages`` property.
///
/// Consider the following tips when displaying a sequence of animated images:
///
///   - **All images in the sequence should have the same size**. When scaling is required, the image view scales each image in the sequence separately. If the images are different sizes, scaling may
///     not yield the results you want.
///   - **All images in the sequence should use the same content scale factor**. Make sure the ``UIImage/scale`` property of each image contains the same value.
///
/// ### Respond to touch events
///
/// Image views ignore user events by default. Normally, you use image views only to present visual content in your interface. If you want an image view to handle user interactions as well, change the
/// value of its ``isUserInteractionEnabled`` property to `true`. After doing that, you can attach gesture recognizers or use any other event handling techniques to respond to touch events or other
/// user-initiated events.
///
/// ### Improve performance
///
/// Image scaling and alpha blending are two relatively expensive operations that can impact your app's performance. To maximize performance of your image view code, consider the following tips:
///
///   - **Cache scaled versions of frequently used images**. If you expect certain large images to be displayed frequently in a scaled-down thumbnail view, consider creating the scaled-down images in
///     advance and storing them in a thumbnail cache. Doing so alleviates the need for each image view to scale them separately.
///   - **Use images whose size is close to the size of the image view**. Rather than assigning a large image to an image view, created a scaled version that matches the current size of the image
///     view. You can also create a resizable image object using the ``UIImage/ResizingMode/tile`` option, which tiles the image instead of scaling it.
///   - **Make your image view opaque whenever possible**. Unless you're intentionally working with images that contain transparency (drawing UI elements, for example), make sure the ``isOpaque``
///     property of your image view is set to `true`.
///
/// ### Debug issues with your image view
///
/// If your image view isn't displaying what you expected, use the following tips to help diagnose the problem:
///
///   - **Load images using the correct method**. Use the ``init(named:in:compatibleWith:)`` method of UIImage to load images from asset catalogs or your app's bundle. For images outside of your app's
///     bundle, use the ``imageWithContentsOfFile:`` method.
///   - **Don't use image views for custom drawing**. The ``UIImageView`` class doesn't draw its content using the ``draw(_:)`` method. Use image views only to present images. To do custom drawing
///     involving images, subclass ``UIView`` directly and draw your image there.
///
/// ### Internationalization
///
/// Internationalization of image views is automatic if your view displays only static images loaded from your app bundle. If you're loading images programmatically, you're at least partially
/// responsible for loading the correct image.
///
///   - For resources in your app bundle, you do this by specifying the name in the attributes inspector or by calling the ``init(named:)`` class method on ``UIImage`` to obtain the localized version
///     of each image.
///   - For images that aren't in your app bundle, your code must do the following:
///     1. Determine which image to load in a manner specific to your app, such as providing a localized string that contains the URL.
///     2. Load that image by passing the URL or data for the correct image to an appropriate ``UIImage`` class method, such as ``imageWithData:`` or ``imageWithContentsOfFile:``.
///
/// > Note: Screen metrics and layout may also change depending on the language and locale, particularly if the internationalized versions of your images have different dimensions. Where possible, you
///   should try to make minimize dimension differences in internationalized versions of image resources.
///
/// ### Accessibility
///
/// Image views are accessible by default. The default accessibility traits for an image view are Image and User Interaction Enabled.
///
/// ### State preservation
///
/// When you assign a value to an image view's ``restorationIdentifier`` property, it attempts to preserve the frame of the displayed image. Specifically, the class preserves the values of the
/// ``bounds``, ``center``, and ``transform`` properties of the view and the ``anchorPoint`` property of the underlying layer. During restoration, the image view restores these values so that the
/// image appears exactly as before.
///
/// ## Topics
///
/// ### Creating an image view
///
/// - ``init(image:)``
///
/// ### Accessing the displayed images
///
/// - ``image``
///
/// ### Configuring the image view
///
/// - ``tintColor``
///
/// ### Configuring the appearance of symbol images
///
/// - ``preferredSymbolConfiguration``
@MainActor
public class UIImageView: UIView {
  /// The image displayed in the image view.
  ///
  /// This property contains the main image displayed by the image view. This image is displayed when the image view is in its natural state. When highlighted, the image view displays the image in its
  /// ``highlightedImage`` property instead. If that property is set to `nil`, the image view applies a default highlight to this image. If the ``animationImages`` property contains a valid set of
  /// images, those images are used instead.
  ///
  /// Changing the image in this property does not automatically change the size of the image view. After setting the image, call the ``sizeToFit()`` method to recompute the image view's size based on
  /// the new image and the active constraints.
  ///
  /// This property is set to the image you specified at initialization time. If you did not use the ``init(image:)`` or ``init(image:highlightedImage:)`` method to initialize your image view, the
  /// initial value of this property is `nil`.
  public var image: UIImage? {
    didSet {
      self.setNeedsDisplay()
    }
  }

  /// A color used to tint template images in the view hierarchy.
  ///
  /// The default is `nil`. If a non-`nil` value is specified, the color is applied to any template images attached to the image view.
  public var tintColor: UIColor! {
    didSet {
      self.setNeedsDisplay()
    }
  }

  /// The configuration values to use when rendering the image.
  ///
  /// Use this property to configure the point size, text style, weight, or scale of a symbol image. For example, you might configure the image to be the same weight as text in a neighboring label.
  public var preferredSymbolConfiguration: UIImage.SymbolConfiguration? {
    didSet {
      if let systemName = image?._systemName, let preferredSymbolConfiguration {
        self.image = UIImage(systemName: systemName, withConfiguration: preferredSymbolConfiguration)
      }
    }
  }

  /// Creates an image view with the specified image.
  ///
  /// The image you specified is used to configure the initial size of the image view itself. Use constraints and the image view's content mode to adjust the image view's final size onscreen. This
  /// method disables user interactions for the image view by setting the ``isUserInteractionEnabled`` property to `false`.
  ///
  /// If you specify an animated image whose duration is greater than `0`, the image view automatically starts playing the animation.
  ///
  /// - Parameter image: The initial image to display in the image view. You may specify an image object that contains an animated sequence of images.
  public convenience init(image: UIImage?) {
    if image?._symbolImageContent != nil {
      self.init(frame: CoreGraphicsRectangle(x: 0, y: 0, width: 0, height: 0), layerClass: CoreAnimationInlineTextLayer.self)
    } else {
      // TODO: Decide between using an <img> tag or a canvas.
      self.init(frame: CoreGraphicsRectangle(x: 0, y: 0, width: image?.size.width ?? 0, height: image?.size.height ?? 0), layerClass: CoreAnimationLayer.self)
    }

    self.image = image
  }

  public override func display(_ layer: CoreAnimationLayer) {
    super.display(layer)

    // Symbol images draw their glyph content as inline text.
    if let symbolImageContent = self.image?._symbolImageContent, let inlineTextLayer = layer as? CoreAnimationInlineTextLayer {
      inlineTextLayer.string = symbolImageContent

      if let configuration = self.preferredSymbolConfiguration ?? self.image?.symbolConfiguration {
        // Set the point size on the element directly; the layer's `fontSize` property emits `px` units.
        inlineTextLayer._viewElement.style.fontSize = "\(configuration.pointSize)pt"
        inlineTextLayer._fontWeight = CFloatingPoint64(configuration.weight.rawValue)
      }

      if let tintColor = self.tintColor {
        inlineTextLayer.foregroundColor = tintColor.cgColor
      }
    }
  }
}

#endif

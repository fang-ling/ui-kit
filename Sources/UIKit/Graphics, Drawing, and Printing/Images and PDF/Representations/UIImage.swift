//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIImage.swift
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
import CoreGraphicsKit
import JavaScriptCoreKit
import SwiftFramework

/// An object that manages image data in your app.
///
/// You use image objects to represent image data of all kinds, and the ``UIImage`` class is capable of managing data for all image formats supported by the underlying platform. Image objects are
/// immutable, so you always create them from existing image data, such as an image file on disk or programmatically created image data. An image object may contain a single image or a sequence of
/// images for use in an animation.
///
/// You can use image objects in several different ways:
///
///   - Assign an image to a ``UIImageView`` object to display the image in your interface.
///   - Use an image to customize system controls such as buttons, sliders, and segmented controls.
///   - Draw an image directly into a view or other graphics context.
///   - Pass an image to other APIs that might require image data.
///
/// Although image objects support all platform-native image formats, it's recommended that you use PNG or JPEG files for most images in your app. Image objects are optimized for reading and
/// displaying both formats, and those formats offer better performance than most other image formats. Because the PNG format is lossless, it's especially recommended for the images you use in your
/// app's interface.
///
/// ### Create image objects
///
/// When creating image objects using the methods of this class, you must have existing image data located in a file or data structure. You can't create an empty image and draw content into it. There
/// are many options for creating image objects, each of which is best for specific situations:
///
///   - Use the ``init(named:in:compatibleWith:)`` method (or the ``init(named:)`` method) to create an image from an image asset or image file located in your app's main bundle (or some other known
///     bundle). Because these methods cache the image data automatically, they're especially recommended for images that you use frequently.
///   - Use the ``init(contentsOfFile:)`` method to create an image object where the initial data isn't in a bundle. These methods load the image data from disk each time, so don't use them to load
///     the same image repeatedly.
///   - Use the ``animatedImage(with:duration:)`` and ``animatedImageNamed(_:duration:)`` methods to create a single ``UIImage`` object comprised of multiple sequential images. Install the resulting
///     image in a ``UIImageView`` object to create animations in your interface.
///
/// Other methods of the ``UIImage`` class let you create animations from specific types of data, such as CoreGraphicsFramework images or image data you create yourself. UIKit also provides the
/// ``UIGraphicsGetImageFromCurrentImageContext()`` function to create images from content you draw yourself. You use that function in conjunction with a bitmap-based graphics context, which you use
/// to capture your drawing commands.
///
/// > Note: Because image objects are immutable, you can't change their properties after creation. Most image properties are set automatically using metadata in the accompanying image file or image
///   data. The immutable nature of image objects also means they're safe to create and use from any thread.
///
/// Image assets are the easiest way to manage the images that ship with your app. Each new project contains an assets library, to which you can add multiple image sets. An image set contains the
/// variations of a single image that your app uses. A single image set can provide different versions of an image for different platforms, for different trait environments (compact or regular), and
/// for different scale factors.
///
/// ### Access the image data
///
/// Image objects don't provide direct access to their underlying image data. However, you can retrieve the image data in other formats for use in your app. Specifically, you can use the ``cgImage``
/// and ``ciImage`` properties to retrieve versions of the image that are compatible with CoreGraphicsFramework and CoreImageFramework, respectively. You can also use the ``pngData()`` and
/// ``jpegData(compressionQuality:)`` functions to generate an ``FoundationKit/FoundationData`` object containing the image data in either the PNG or JPEG format.
///
/// ## Topics
///
/// ### Loading and caching images
///
/// - ``init(systemName:)``
/// - ``init(systemName:withConfiguration:)``
/// - ``UIImage/Configuration``
/// - ``UIImage/SymbolConfiguration``
///
/// ### Getting the image size and scale
///
/// - ``scale``
/// - ``size``
///
/// ### Getting the image configuration
///
/// - ``configuration``
/// - ``symbolConfiguration``
public class UIImage {
  internal var _systemName: SwiftString?

  internal var _symbolImageContent: SwiftString?

  /// The scale factor of the image.
  ///
  /// If you load an image from a file whose name includes the `@2x` modifier, the scale is set to `2.0`. You can also specify an explicit scale factor when initializing an image from a
  /// CoreGraphicsFramework image. All other images are assumed to have a scale factor of `1.0`.
  ///
  /// If you multiply the logical size of the image (stored in the ``size`` property) by the value in this property, you get the dimensions of the image in pixels.
  public private(set) var scale: CFloatingPoint64

  /// The logical dimensions, in points, for the image.
  ///
  /// This value reflects the logical size of the image and takes the image's current orientation into account. Multiply the size values by the value in the ``scale`` property to get the pixel
  /// dimensions of the image.
  public private(set) var size: CoreGraphicsSize

  /// The configuration details for the image.
  ///
  /// Use this property to access the traits associated with the image. The system uses the specified traits to determine which variant of the image to load and draw, falling back on the current
  /// environment for any unspecified traits. The default value of this property is a configuration object with unspecified traits.
  ///
  /// You can't modify this property directly, but you can use the ``withConfiguration(_:)`` method to create a new image object with a specific set of traits. You might do so when you want to render
  /// the image yourself using a specific set of traits.
  ///
  /// If the image is a symbol image, this property always contains a ``UIImage/SymbolConfiguration`` object.
  public private(set) var configuration: Configuration?

  /// The configuration details for a symbol image.
  ///
  /// Use this property to access the traits and rendering attributes associated with the symbol image. The system uses the specified details to determine which variant of the image to load and draw
  /// and how to render it, falling back on the current environment as needed for any unspecified values. For symbol images, the default value of this property is a symbol image configuration object
  /// with unspecified values. For other image types, the default value of this property is `nil`.
  ///
  /// You can't modify this property directly, but you can use the ``withConfiguration(_:)`` when you want to create a new image object with a specific set of traits.
  ///
  /// If the image is a symbol image, this property always contains a ``UIImage/SymbolConfiguration`` object.
  public private(set) var symbolConfiguration: SymbolConfiguration?

  /// Creates an image object that contains a system symbol image.
  ///
  /// Use this method to retrieve system-defined symbol images. To retrieve a custom symbol image you store in an asset catalog, use the ``init(named:)`` method instead.
  ///
  /// This method checks the system caches for an image with the name you specify and returns the variant of that image that's best suited for the main screen.
  ///
  /// If a matching image object isn't in the cache, this method creates the image from the specified system symbol image. The system may purge cached image data at any time to free up memory. Purging
  /// occurs only for unused images that are in the cache.
  ///
  /// - Parameter name: The name of the system symbol image.
  public convenience init?(systemName name: SwiftString) {
    self.init(systemName: name, withConfiguration: nil)
  }

  /// Creates an image object that contains a system symbol image with the specified configuration.
  ///
  /// Use this method to retrieve system-defined symbol images. To retrieve a custom symbol image you store in an asset catalog, use the ``init(named:in:with:)`` method instead.
  ///
  /// This method checks the system caches for an image with the specified name and returns the variant of that image that's best suited for the configuration you specify. If a matching image object
  /// isn't in the cache, this method creates the image from the system symbol image.
  ///
  /// The system may purge cached image data at any time to free up memory. Purging occurs only for unused images that are in the cache.
  ///
  /// - Parameters:
  ///   - name: The name of the system symbol image.
  ///   - configuration: The image configuration the system applies to the image.
  public init?(systemName name: SwiftString, withConfiguration configuration: Configuration?) {
    let symbolImageContent: SwiftString
    if name == "photo.fill.on.rectangle.fill" {
      symbolImageContent = "􀏬"
    } else if name == "rectangle.stack.fill" {
      symbolImageContent = "􀏮"
    } else {
      return nil
    }

    self._systemName = name
    self._symbolImageContent = symbolImageContent
    self.configuration = configuration
    self.symbolConfiguration = configuration as? SymbolConfiguration
    self.scale = 1.0

    var styleAttributes = [SwiftString: Any]()

    if let symbolConfiguration = configuration as? SymbolConfiguration {
      styleAttributes["font-size"] = "\(symbolConfiguration.pointSize)pt"
      styleAttributes["font-weight"] = "\(symbolConfiguration.weight.rawValue)"
    }

    self.size = symbolImageContent.size(withAttributes: styleAttributes)
  }
}

#endif

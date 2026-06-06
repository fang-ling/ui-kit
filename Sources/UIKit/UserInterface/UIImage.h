/*
 *  UIImage.h
 *  ui-kit
 *
 *  Created by Fang Ling on 2026/6/6.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

#import "UIImageConfiguration.h"

#import <CKit/CKit.h>
#import <FoundationKit/FoundationKit.h>
#import <ObjectiveCKit/ObjectiveCKit.h>

C_ASSUME_NONNULL_BEGIN

/**
 * An object that manages image data in your app.
 *
 * You use image objects to represent image data of all kinds, and the
 * ``UIImage`` class is capable of managing data for all image formats
 * supported by the underlying platform. Image objects are immutable, so you
 * always create them from existing image data, such as an image file over the
 * the network or programmatically created image data. An image object may
 * contain a single image or a sequence of images for use in an animation.
 *
 * You can use image objects in several different ways:
 *
 *   - Assign an image to a ``UIImageView`` object to display the image in
 *     your interface.
 *   - Use an image to customize system controls such as buttons, sliders, and
 *     segmented controls.
 *   - Draw an image directly into a view or other graphics context.
 *   - Pass an image to other APIs that might require image data.
 *
 * Although image objects support all platform-native image formats, it's
 * recommended that you use PNG or JPEG files for most images in your app.
 * Image objects are optimized for reading and displaying both formats, and
 * those formats offer better performance than most other image formats.
 * Because the PNG format is lossless, it's especially recommended for the
 * images you use in your app's interface.
 *
 * ## Create image objects
 *
 * When creating image objects using the methods of this class, you must have
 * existing image data located in the server or data structure. You can't
 * create an empty image and draw content into it. There are many options for
 * creating image objects, each of which is best for specific situations:
 *
 *   - Use the ``makeImageWithName:`` method to create an image from an image
 *     asset in your app's main bundle (or some other known bundle). Because
 *     this method caches the image data automatically, it's especially
 *     recommended for images that you use frequently.
 *   - Use the ``makeImageWithURL:`` method to create an image object where
 *     the initial data isn't in a bundle. This method loads the image data
 *     over the network each time, so don't use them to load the same image
 *     repeatedly.
 *   - Use the ``makeImageWithSystemName:`` method to creates an image object
 *     that contains a system symbol image.
 *
 * > Note: Because image objects are immutable, you can't change their
 *   properties after creation. Most image properties are set automatically
 *   using metadata in the accompanying image file or image data. The
 *   immutable nature of image objects also means they're safe to create and
 *   use from any thread.
 *
 * Image assets are the easiest way to manage the images that ship with your
 * app. Each Xcode project can contain an assets library, to which you can add
 * multiple image sets. An image set contains the variations of a single image
 * that your app uses. A single image set can provide different versions of an
 * image for different platforms, for different trait environments (compact or
 * regular), and for different scale factors.
 *
 * ## Topics
 *
 * ### Loading and caching images
 *
 * - ``makeImageWithName:``
 * - ``makeImageWithURL:``
 * - ``makeImageWithSystemName:``
 * - ``makeImageWithSystemName:configuration``
 */
@interface UIImage: ObjectiveCObject

/**
 * The configuration details for the image.
 *
 * Use this property to access the traits associated with the image. The system
 * uses the specified traits to determine which variant of the image to load and
 * draw, falling back on the current environment for any unspecified traits. The
 * default value of this property is a configuration object with unspecified
 * traits.
 *
 * You can't modify this property directly, but you can use the
 * ``copyImageWithConfiguration:`` method to create a new image object with a
 * specific set of traits. You might do so when you want to render the image
 * yourself using a specific set of traits.
 *
 * If the image is a symbol image, this property always contains a
 * ``UIImageSymbolConfiguration`` object.
 */
@property (nonatomic, copy, readonly) UIImageConfiguration* configuration;

/**
 * Creates an image object that contains a system symbol image.
 *
 * Use this method to retrieve system-defined symbol images. To retrieve a
 * custom symbol image you store in an asset catalog, use the
 * ``makeImageWithName:`` method instead.
 *
 * This method searches for an image with the name you specify and returns the
 * variant of that image that's best suited for the main screen.
 *
 * To look up the names of system symbol images, download the SF Symbols app
 * from [Apple Design Resources](https://developer.apple.com/design/resources/).
 *
 * - Parameter systemName: The name of the system symbol image.
 *
 * - Returns: The object containing the specified symbol image, or `nil` if no
 *   suitable image was found.
 */
+ (instancetype)makeImageWithSystemName:(FoundationString*)systemName;

/**
 * Creates an image object that contains a system symbol image with the
 * specified configuration.
 *
 * Use this method to retrieve system-defined symbol images. To retrieve a
 * custom symbol image you store in an asset catalog, use the
 *  ``makeImageWithName:configuration:`` method instead.
 *
 * This method searches for an image with the specified name and returns the
 * variant of that image that's best suited for the configuration you specify.
 *
 * To look up the names of system symbol images, download the SF Symbols app
 * from [Apple Design Resources](https://developer.apple.com/design/resources/).
 *
 * - Parameters:
 *   - systemName: The name of the system symbol image.
 *   - configuration: The image configuration the system applies to the image.
 */
+ (instancetype)
  makeImageWithSystemName:(FoundationString*)systemName
            configuration:(nullable UIImageConfiguration*)configuration;

@end

C_ASSUME_NONNULL_END

/*
 *  UIButtonConfiguration.h
 *  ui-kit
 *
 *  Created by Fang Ling on 2026/5/31.
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

#import "UIGeometry.h"
#import "../Graphics/UIImage.h"
#import "../Graphics/UIImageSymbolConfiguration.h"

#import <CKit/CKit.h>
#import <FoundationKit/FoundationKit.h>
#import <ObjectiveCKit/ObjectiveCKit.h>

C_ASSUME_NONNULL_BEGIN

/**
 * A configuration that specifies the appearance and behavior of a button and
 * its contents.
 *
 * ## Topics
 *
 * ### Creating configurations
 *
 * - ``makePlainButtonConfiguration``
 *
 * ### Configuring titles
 *
 * - ``title``
 *
 * ### Configuring images
 *
 * - ``image``
 * - ``imagePadding``
 * - ``imagePlacement``
 * - ``preferredSymbolConfigurationForImage``
 */
@interface UIButtonConfiguration: ObjectiveCObject

/**
 * The text of the title label the button displays.
 */
@property (nullable, nonatomic, copy) FoundationString* title;

/**
 * The foreground image the button displays.
 *
 * A configuration contains one image. To change the image based on button
 * state, use ``configurationUpdateHandler`` or ``updateConfiguration``.
 */
@property (nullable, nonatomic) UIImage* image;

/**
 * The distance between the button's image and text.
 *
 * Use this property to adjust the distance from the title and subtitle. This
 * doesn't affect the distance to the button's edge.
 */
@property (nonatomic) CFloatingPoint imagePadding;

/**
 * The edge against which the button places the image.
 *
 * Use this property to place the image along the top, leading, trailing, or
 * bottom edge of the button.
 */
@property (nonatomic) UIDirectionalRectangleEdge imagePlacement;

/**
 * A requested configuration object for the button symbol image.
 *
 * A symbol configuration defines details such as the point size, scale, text
 * style, weight, and font of symbol image. The button uses these details to
 * determine which variant of the image to use and how to scale or style the
 * image.
 */
@property (nonatomic, copy)
  UIImageSymbolConfiguration* preferredSymbolConfigurationForImage;

/**
 * Creates a configuration for a button with a transparent background.
 *
 * - Returns: A new configuration object.
 */
+ (instancetype)makePlainButtonConfiguration;

@end

C_ASSUME_NONNULL_END

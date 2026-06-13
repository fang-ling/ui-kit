/*
 *  UIImageSymbolConfiguration.h
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

C_ASSUME_NONNULL_BEGIN

/**
 * An object that contains the specific font, size, style, and weight attributes
 * to apply to a symbol image.
 *
 * Symbol image configuration objects include details such as the point size,
 * scale, text style, weight, and font to apply to your symbol image. The system
 * uses these details to determine which variant of the image to use and how to
 * scale or style the image.
 *
 * ``UIImageSymbolConfiguration`` objects are immutable after you create them.
 *
 * ## Topics
 *
 * ### Creating a symbol configuration
 *
 * - ``configurationWithPointSize:``
 */
@interface UIImageSymbolConfiguration: UIImageConfiguration

/**
 * Creates a configuration object with the specified point-size information.
 *
 * - Parameter pointSize: The system font point size to use for the
 *   configuration.
 *
 * - Returns: A new symbol configuration object with the specified information.
 */
+ (instancetype)makeConfigurationWithPointSize:(CFloatingPoint)pointSize;

@end

C_ASSUME_NONNULL_END

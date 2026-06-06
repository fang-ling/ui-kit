/*
 *  UIImageConfiguration.h
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

#import <CKit/CKit.h>
#import <ObjectiveCKit/ObjectiveCKit.h>

C_ASSUME_NONNULL_BEGIN

/**
 * A configuration object that contains the traits that the system uses when
 * selecting the current image variant.
 *
 * Images may contain multiple variants to account for environmental factors,
 * such as whether the interface is light or dark. The image configuration
 * object lets you override the current environment and render an image with
 * specific attributes. For example, you might want to render a specific version
 * of your image to your interface.
 *
 * ``UIImageConfiguration`` objects are immutable and you don't create them
 * directly.
 */
@interface UIImageConfiguration: ObjectiveCObject

@end

C_ASSUME_NONNULL_END

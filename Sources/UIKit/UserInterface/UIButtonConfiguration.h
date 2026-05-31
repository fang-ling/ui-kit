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

#import <CKit/CKit.h>
#import <FoundationKit/FoundationKit.h>
#import <ObjectiveCKit/ObjectiveCKit.h>

C_ASSUME_NONNULL_BEGIN

/**
 * A configuration that specifies the appearance and behavior of a button and
 * its contents.
 */
@interface UIButtonConfiguration: ObjectiveCObject

/**
 * The text of the title label the button displays.
 */
@property (nullable, nonatomic, copy) FoundationString* title;

/**
 * Creates a configuration for a button with a transparent background.
 *
 * - Returns: A new configuration object.
 */
+ (instancetype)makePlainButtonConfiguration;

@end

C_ASSUME_NONNULL_END

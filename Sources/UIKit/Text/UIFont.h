/*
 *  UIFont.h
 *  ui-kit
 *
 *  Created by Fang Ling on 2026/6/19.
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
 * Constants that represent standard typeface styles.
 *
 * ## Topics
 *
 * ### Using system-defined font weights
 *
 * - ``kUIFontWeightRegular``
 * - ``kUIFontWeightMedium``
 */
typedef CFloatingPoint UIFontWeight;

/**
 * The regular font weight.
 */
extern const UIFontWeight kUIFontWeightRegular;

/**
 * The medium font weight.
 */
extern const UIFontWeight kUIFontWeightMedium;

C_ASSUME_NONNULL_END

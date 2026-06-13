/*
 *  UIButton.h
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

#import "UIControl.h"
#import "UIButtonConfiguration.h"

#import <CKit/CKit.h>

C_ASSUME_NONNULL_BEGIN

/**
 * A control that executes your custom code in response to user interactions.
 *
 * When you tap a button, or select a button that has focus, the button performs
 * any actions attached to it. You communicate the purpose of a button using a
 * text label, an image, or both. The appearance of buttons is configurable, so
 * you can tint buttons or format titles to match the design of your app.
 */
@interface UIButton: UIControl

/**
 * The configuration for the button's appearance.
 *
 * Setting a configuration opts the button into a configuration system based on
 * ``UIButtonConfiguration``.
 */
@property (nonatomic, copy) UIButtonConfiguration* configuration;

/**
 * Creates a new button with the specified configuration and registers the
 * primary action event.
 *
 * - Parameters:
 *   - configuration: The button configuration.
 *   - primaryAction: The action to perform for the
 *     ``kUIControlEventPrimaryActionTriggered`` control event.
 *
 * - Returns: A new button.
 */
+ (instancetype)
  makeButtonWithConfiguration:(UIButtonConfiguration*)configuration
                primaryAction:(UIAction*)primaryAction;

@end

C_ASSUME_NONNULL_END

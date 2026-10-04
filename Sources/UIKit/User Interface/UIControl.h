/*
 *  UIControl.h
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

#import "UIView.h"
#import "../User Interactions/UIAction.h"

#import <CKit/CKit.h>

C_ASSUME_NONNULL_BEGIN

/**
 * Constants describing the types of events possible for controls.
 *
 * You set up a control so that it sends an action message to a target object by
 * associating both target and action with one or more control events.
 */
typedef enum UIControlEvents: CUnsignedInteger32 {
  /**
   * A semantic action triggered by buttons.
   */
  kUIControlEventPrimaryActionTriggered = 1 << 0
} UIControlEvents;

C_ASSUME_NONNULL_END

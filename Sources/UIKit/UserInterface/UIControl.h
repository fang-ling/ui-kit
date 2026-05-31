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
#import "../UserInteractions/UIAction.h"

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

/**
 * The base class for controls, which are visual elements that convey a specific
 * action or intention in response to user interactions.
 */
@interface UIControl: UIView

/**
 * Adds the UIAction to a given event.
 *
 * `UIAction`s are uniqued based on their identifier, and subsequent actions
 * with the same identifier replace previously added actions. You may add
 * multiple `UIAction`s for corresponding `controlEvents`, and you may add the
 * same action to multiple `controlEvents`.
 *
 * - Parameters:
 *   - action: The action to associate with the control event.
 *   - controlEvents: The control events that trigger the action.
 */
- (void)addAction:(UIAction*)action
 forControlEvents:(UIControlEvents)controlEvents;

/**
 * Calls the action methods associated with the specified events.
 *
 * You call this method when you want the control to perform the actions
 * associated with the specified events. This method iterates over the control's
 * registered targets and action methods and calls the ``sendAction:`` method
 * for each one that is associated with an event in the `controlEvents`
 * parameter.
 *
 * - Parameter controlEvents: A bit-mask with flags that specify the control
 *   events for which the control sends action messages. See ``UIControlEvents``
 *   for bit-mask constants.
 */
- (void)sendActionsForControlEvents:(UIControlEvents)controlEvents;

/**
 * This method is called by ``sendActionsForControlEvents:``. You may override
 * this method to observe or modify behavior. If you override this method, you
 * should call super precisely once to dispatch the action, or not call super to
 * suppress sending that action.
 *
 * - Parameter action: The action to dispatch.
 */
- (void)sendAction:(UIAction*)action;

@end

C_ASSUME_NONNULL_END

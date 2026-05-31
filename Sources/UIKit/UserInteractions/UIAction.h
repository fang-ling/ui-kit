/*
 *  UIAction.h
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

@class UIAction;

/**
 * A type that defines the closure for an action handler.
 */
typedef void (^UIActionHandler)(UIAction*);

/**
 * An object representing an action that can be triggered by a control.
 */
@interface UIAction: ObjectiveCObject

/**
 * The unique identifier for the action.
 */
@property (nonatomic, readonly) FoundationString* identifier;

/**
 * Creates an action with the specified identifier and handler.
 *
 * - Parameters:
 *   - identifier: The unique identifier for the action. Specify `nil` to let
 *     this method create a unique identifier.
 *   - handler: The handler to invoke after a person selects the action. This
 *     handler has the following parameter:
 *       - action: The action that a person selects.
 */
+ (UIAction*)makeActionWithIdentifier:(nullable FoundationString*)identifier
                              handler:(UIActionHandler)handler;

@end

C_ASSUME_NONNULL_END

/*
 *  UIControl.m
 *  ui-kit
 *
 *  Created by Fang Ling on 2026/3/22.
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

#import <FoundationKit/FoundationKit.h>
#import <JavaScriptCoreKit/JavaScriptCoreKit.h>

C_ASSUME_NONNULL_BEGIN

@interface UIAction()

@property (nonatomic, readonly) UIActionHandler handler;

@end

@interface UIControl()

/* TODO: Switch to FoundationDictionary. */
@property (nonatomic) FoundationMutableArray* actions;

@end

@implementation UIControl

- (instancetype)initWithFrame:(CoreFoundationRectangle)frame {
  if (!(self = [super initWithFrame:frame])) {
    return nil;
  }

  self.actions = [FoundationMutableArray makeArray];

  return self;
}

- (void)addAction:(UIAction*)action
 forControlEvents:(UIControlEvents)controlEvents {
  /* Replace existing action with the same identifier. */
  for (let i = 0; i < self.actions.count; i += 1) {
    let existingAction = (UIAction*)[self.actions objectAtIndex:i];
    if ([existingAction.identifier isEqual:action.identifier]) {
      /* [self.actions replaceObjectAtIndex:i withObject:action]; */

      return;
    }
  }

  [self.actions appendObject:action];

  if (controlEvents & kUIControlEventPrimaryActionTriggered) {
    [JavaScriptCoreContext addClickEventListenerForNode:self.layer.contents];
  }
}

- (void)sendActionsForControlEvents:(UIControlEvents)controlEvents {
  /* TODO: Filter actions by controlEvents. */
  for (let i = 0; i < self.actions.count; i += 1) {
    [self sendAction:[self.actions objectAtIndex:i]];
  }
}

- (void)sendAction:(UIAction*)action {
  action.handler(action);
}

@end

C_ASSUME_NONNULL_END

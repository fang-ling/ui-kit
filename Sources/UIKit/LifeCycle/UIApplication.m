/*
 *  UIApplication.m
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

#import "UIApplication.h"

#import <CoreAnimationKit/CoreAnimationKit.h>

C_ASSUME_NONNULL_BEGIN

static UIControl* UIApplicationFindControlWithTarget(
  UIView* view,
  CUnsignedInteger32 target
) {
  if ([view isKindOfClass:UIControl.class]) {
    let control = (UIControl*)view;
    if (control.layer.contents == target) {
      return control;
    }
  }

  /* TODO: Use fast enumeration. */
  for (let i = 0; i < view.subviews.count; i += 1) {
    let found = UIApplicationFindControlWithTarget(
      [view.subviews objectAtIndex:i],
      target
    );
    if (found) {
      return found;
    }
  }

  return nil;
}

void UIKitDispatchControlEvent(
  CUnsignedInteger32 target,
  CUnsignedInteger32 eventType
) {
  [[UIApplication sharedApplication] sendEventToTarget:target
                                      forControlEvents:eventType];

  /*
   * TODO: Async jobs that mutate UI state after the event returns must trigger
   * their own flush to render the deferred updates.
   */
  let layer = [UIApplication sharedApplication].keyWindow.layer;
  [CoreAnimationTransaction flushWithLayer:layer];
}

@interface UIApplication()

@property (nonatomic, readwrite) FoundationMutableArray* windows;

@end

@implementation UIApplication

- (instancetype)init {
  self = [super init];

  self.windows = [FoundationMutableArray makeArray];

  return self;
}

- (UIWindow*)keyWindow {
  if (self.windows.count > 0) {
    return [self.windows objectAtIndex:self.windows.count - 1];
  }

  return nil;
}

- (void)sendEventToTarget:(CUnsignedInteger32)target
         forControlEvents:(UIControlEvents)controlEvents {
  /* TODO: Use fast enumeration. */
  for (let i = 0; i < self.windows.count; i += 1) {
    let window = (UIWindow*)[self.windows objectAtIndex:i];
    let control = UIApplicationFindControlWithTarget(window, target);
    if (control) {
      [control sendActionsForControlEvents:controlEvents];

      return;
    }
  }
}

+ (UIApplication*)sharedApplication {
  static let sharedApplication = (UIApplication*)nil;

  if (!sharedApplication) {
    sharedApplication = [[UIApplication alloc] init];
  }

  return sharedApplication;
}

@end

C_ASSUME_NONNULL_END

void UIApplicationMain(CString delegateClassName) {
  let delegateClass = ObjectiveCLookUpClass(delegateClassName);

  UIApplication.sharedApplication.delegate = [[delegateClass alloc] init];

  [UIApplication.sharedApplication.delegate applicationDidFinishLaunching];

  /* Initial rendering. */
  let layer = UIApplication.sharedApplication.keyWindow.layer;
  [CoreAnimationTransaction flushWithLayer:layer];
}

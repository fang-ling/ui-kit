/*
 *  UIButton.m
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

#import "UIButton.h"

#import <CoreAnimationKit/CoreAnimationKit.h>
#import <JavaScriptCoreKit/JavaScriptCoreKit.h>

C_ASSUME_NONNULL_BEGIN

@implementation UIButton

+ (Class)layerClass {
  return CoreAnimationButtonLayer.class;
}

+ (instancetype)
  makeButtonWithConfiguration:(UIButtonConfiguration*)configuration
                primaryAction:(UIAction*)primaryAction {
  let button = [[UIButton alloc] initWithFrame:CoreFoundationRectangleMake(0,
                                                                           0,
                                                                           0,
                                                                           0)];

  button.configuration = configuration;

  if (primaryAction) {
    [button addAction:primaryAction
     forControlEvents:kUIControlEventPrimaryActionTriggered];
  }

  return button;
}

- (void)setConfiguration:(UIButtonConfiguration*)configuration {
  self->_configuration = configuration;

  self.needsDisplay = yes;
}

- (void)displayLayer:(CoreAnimationLayer*)layer {
  [super displayLayer:layer];

  if (self.configuration.title) {
    [JavaScriptCoreContext updateNode:layer.contents
                          textContent:self.configuration.title];
  }
}

@end

C_ASSUME_NONNULL_END

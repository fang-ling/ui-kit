/*
 *  UILabel.m
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

#import "UILabel.h"

#import <CoreFoundationKit/CoreFoundationKit.h>
#import <JavaScriptCoreKit/JavaScriptCoreKit.h>

C_ASSUME_NONNULL_BEGIN

@implementation UILabel

+ (Class)layerClass {
  return CoreAnimationParagraphLayer.class;
}

- (void)setText:(FoundationString*)text {
  self->_text = text;

  self.needsLayout = yes;
  self.needsDisplay = yes;
}

- (void)displayLayer:(CoreAnimationLayer*)layer {
  [super displayLayer:layer];

  /* Texts are vertically centered by default. */
  [JavaScriptCoreContext updateNode:layer.contents
                      styleProperty:@"display"
                         styleValue:@"flex"];
  [JavaScriptCoreContext updateNode:layer.contents
                      styleProperty:@"align-items"
                         styleValue:@"center"];

  /* Do not draw text outside the frame. */
  [JavaScriptCoreContext updateNode:layer.contents
                      styleProperty:@"overflow"
                         styleValue:@"hidden"];

  if (self.text) {
    [JavaScriptCoreContext updateNode:layer.contents
                          textContent:self.text];
  }
}

@end

C_ASSUME_NONNULL_END

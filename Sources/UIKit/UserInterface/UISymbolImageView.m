/*
 *  UISymbolImageView.m
 *  ui-kit
 *
 *  Created by Fang Ling on 2026/6/6.
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

#import "UISymbolImageView.h"

#import "UIImage+Private.h"
#import "UIImageSymbolConfiguration+Private.h"

#import <CoreAnimationKit/CoreAnimationKit.h>
#import <JavaScriptCoreKit/JavaScriptCoreKit.h>

C_ASSUME_NONNULL_BEGIN

@implementation _UISymbolImageView

+ (Class)layerClass {
  return CoreAnimationSpanLayer.class;
}

- (instancetype)initWithImage:(UIImage*)image {
  if (!(self = [super initWithFrame:CoreFoundationRectangleMake(0, 0, 0, 0)])) {
    return nil;
  }

  self.image = image;

  return self;
}

/* MARK: - CoreAnimationLayerDelegate Implementation */
- (void)displayLayer:(CoreAnimationLayer*)layer {
  [super displayLayer:layer];

  [JavaScriptCoreContext updateNode:layer.contents
                        textContent:self.image.content];

  [JavaScriptCoreContext updateNode:layer.contents
                         className:@"view sfSymbol"];

  if (self.image.configuration) {
    let configuration = (UIImageSymbolConfiguration*)self.image.configuration;

    if ([configuration isKindOfClass:UIImageSymbolConfiguration.class]) {
      [JavaScriptCoreContext updateNode:layer.contents
                          styleProperty:@"font-size"
                             styleValue:$(@"%fpt", configuration.pointSize)];
    }
  }
}

@end

C_ASSUME_NONNULL_END

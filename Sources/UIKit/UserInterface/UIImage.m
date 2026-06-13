/*
 *  UIImage.m
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

#import "UIImage.h"

#import "UIImage+Private.h"
#import "UIImageSymbolConfiguration+Private.h"

#import <JavaScriptCoreKit/JavaScriptCoreKit.h>

C_ASSUME_NONNULL_BEGIN

@implementation UIImage

+ (instancetype)makeImageWithSystemName:(FoundationString*)systemName {
  return [self makeImageWithSystemName:systemName configuration:nil];
}

+ (instancetype)
  makeImageWithSystemName:(FoundationString*)systemName
            configuration:(nullable UIImageConfiguration*)configuration {
  let content = (FoundationString*)nil;

  if ([systemName isEqual:@"photo.fill.on.rectangle.fill"]) {
    content = @"􀏬";
  } else if ([systemName isEqual:@"rectangle.stack.fill"]) {
    content = @"􀏮";
  } else {
    return nil;
  }

  let image = [[UIImage alloc] init];

  image.type = kUIImageTypeSymbol;
  image.content = content;
  image.configuration = configuration;
  image.scale = 1.0;

  let styleText = (FoundationString*)@"font-family: 'UIKit SF Pro'";

  if (configuration &&
      [configuration isKindOfClass:UIImageSymbolConfiguration.class]) {
    let symbolConfig = (UIImageSymbolConfiguration*)configuration;

    styleText = $(@"%@; font-size: %fpt", styleText, symbolConfig.pointSize);
  }

  image.size = [JavaScriptCoreContext measureTextSize:content
                                            styleText:styleText];

  return image;
}

@end

C_ASSUME_NONNULL_END

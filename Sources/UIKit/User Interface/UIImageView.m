/*
 *  UIImageView.m
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

#import "UIImageView.h"

#import "UISymbolImageView.h"
#import "../Graphics/UIImage+Private.h"

C_ASSUME_NONNULL_BEGIN

@implementation UIImageView

+ (instancetype)makeImageViewWithImage:(UIImage*)image {
  if (image.type == kUIImageTypeSymbol) {
    return [[_UISymbolImageView alloc] initWithImage:image];
  }

  let imageView =
    [[UIImageView alloc] initWithFrame:CoreFoundationRectangleMake(0, 0, 0, 0)];

  imageView.image = image;

  return imageView;
}

@end

C_ASSUME_NONNULL_END

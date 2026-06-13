/*
 *  UIImage+Private.h
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

/**
 * Flags used by ``UIImage`` to indicate the type of an image.
 */
typedef enum UIImageType {
  /**
   * An image created from a symbol image.
   */
  kUIImageTypeSymbol,

  /**
   * An image loaded from an asset catalog image set.
   */
  kUIImageTypeImageSet,

  /**
   * An image whose content is loaded asynchronously.
   */
  kUIImageTypeAsynchronousImage
} UIImageType;

@interface UIImage()

@property (nonatomic) UIImageType type;

@property (nonatomic) FoundationString* content;

@property (nonatomic, copy, readwrite) UIImageConfiguration* configuration;

@property (nonatomic, readwrite) CFloatingPoint scale;

@property (nonatomic, readwrite) CoreFoundationSize size;

@end

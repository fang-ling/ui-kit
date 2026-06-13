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

#import "UIImageView.h"
#import "../Text/UILabel.h"

#import <CoreAnimationKit/CoreAnimationKit.h>

C_ASSUME_NONNULL_BEGIN

@interface UIButton()

@property (nullable, nonatomic) UILabel* titleLabel;

@property (nullable, nonatomic) UIImageView* imageView;

@end

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

  if (configuration.title) {
    if (!self.titleLabel) {
      self.titleLabel =
        [[UILabel alloc] initWithFrame:CoreFoundationRectangleMake(0, 0, 0, 0)];

      [self addSubview:self.titleLabel];
    }

    self.titleLabel.text = configuration.title;
  } else if (self.titleLabel) {
    [self.titleLabel removeFromSuperview];

    self.titleLabel = nil;
  }

  if (configuration.image) {
    if (!self.imageView) {
      self.imageView = [UIImageView makeImageViewWithImage:configuration.image];

      [self addSubview:self.imageView];
    }

    self.imageView.image = configuration.image;
  } else if (self.imageView) {
    [self.imageView removeFromSuperview];

    self.imageView = nil;
  }

  self.needsLayout = YES;
  self.needsDisplay = YES;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  let imagePadding = self.configuration.imagePadding;
  let imagePlacement = self.configuration.imagePlacement;

  let width = self.bounds.size.width;
  let height = self.bounds.size.height;

  switch (imagePlacement) {
    case kUIDirectionalRectangleEdgeTrailing: {
      if (self.titleLabel) {
        self.titleLabel.frame = CoreFoundationRectangleMake(
          0,
          0,
          width,
          height
        );
      }

      if (self.imageView) {
        let imageWidth = self.imageView.image.size.width *
                         self.imageView.image.scale;
        let imageHeight = self.imageView.image.size.height *
                          self.imageView.image.scale;
        let imageX = width - imageWidth;
        self.imageView.frame = CoreFoundationRectangleMake(
          imageX,
          (height - imageHeight) / 2,
          imageWidth,
          imageHeight
        );

        if (self.titleLabel) {
          let titleWidth = imageX - imagePadding;
          self.titleLabel.frame = CoreFoundationRectangleMake(
            0,
            0,
            titleWidth,
            height
          );
        }
      }

      break;
    }

    case kUIDirectionalRectangleEdgeTop: {
      if (self.imageView) {
        let imageWidth = self.imageView.image.size.width *
                         self.imageView.image.scale;
        let imageHeight = self.imageView.image.size.height *
                          self.imageView.image.scale;
        self.imageView.frame = CoreFoundationRectangleMake(
          (width - imageWidth) / 2,
          0,
          imageWidth,
          imageHeight
        );

        if (self.titleLabel) {
          let titleY = imageHeight + imagePadding;
          self.titleLabel.frame = CoreFoundationRectangleMake(
            0,
            titleY,
            width,
            height - titleY
          );
        }
      } else if (self.titleLabel) {
        self.titleLabel.frame = CoreFoundationRectangleMake(
          0,
          0,
          width,
          height
        );
      }

      break;
    }

    case kUIDirectionalRectangleEdgeBottom: {
      if (self.imageView) {
        let imageWidth = self.imageView.image.size.width *
                         self.imageView.image.scale;
        let imageHeight = self.imageView.image.size.height *
                          self.imageView.image.scale;
        let imageY = height - imageHeight;
        self.imageView.frame =
          CoreFoundationRectangleMake(
            (width - imageWidth) / 2,
            imageY,
            imageWidth,
            imageHeight
          );

        if (self.titleLabel) {
          self.titleLabel.frame = CoreFoundationRectangleMake(
            0,
            0,
            width,
            imageY - imagePadding
          );
        }
      } else if (self.titleLabel) {
        self.titleLabel.frame = CoreFoundationRectangleMake(
          0,
          0,
          width,
          height
        );
      }

      break;
    }

    case kUIDirectionalRectangleEdgeNone:
    case kUIDirectionalRectangleEdgeLeading:
    case kUIDirectionalRectangleEdgeAll: {
      if (self.imageView) {
        let imageWidth = self.imageView.image.size.width *
                         self.imageView.image.scale;
        let imageHeight = self.imageView.image.size.height *
                          self.imageView.image.scale;
        self.imageView.frame = CoreFoundationRectangleMake(
          0,
          (height - imageHeight) / 2,
          imageWidth,
          imageHeight
        );

        if (self.titleLabel) {
          let titleX = imageWidth + imagePadding;
          self.titleLabel.frame = CoreFoundationRectangleMake(
            titleX,
            0,
            width - titleX,
            height
          );
        }
      } else if (self.titleLabel) {
        self.titleLabel.frame = CoreFoundationRectangleMake(
          0,
          0,
          width,
          height
        );
      }

      break;
    }
  }
}

@end

C_ASSUME_NONNULL_END

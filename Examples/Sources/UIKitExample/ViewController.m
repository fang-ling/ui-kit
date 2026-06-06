/*
 *  ViewController.m
 *  ui-kit-examples
 *
 *  Created by Fang Ling on 2026/5/17.
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

#import "ViewController.h"

#import <CoreFoundationKit/CoreFoundationKit.h>

C_ASSUME_NONNULL_BEGIN

@interface ViewController()

@property (nonatomic) UIImageView* imageView;

@property (nonatomic) UILabel* label;

@property (nonatomic) UIButton* button;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self setupImageView];
  [self setupLabel];
  [self setupButton];
}

- (void)setupImageView {
  let configuration =
    [UIImageSymbolConfiguration makeConfigurationWithPointSize:24.0];
  let image = [UIImage makeImageWithSystemName:@"rectangle.stack.fill"
                                 configuration:configuration];

  self.imageView = [UIImageView makeImageViewWithImage:image];
  self.imageView.frame = CoreFoundationRectangleMake(36, 24, 360, 240);

  [self.view addSubview:self.imageView];
}

- (void)setupLabel {
  self.label = [[UILabel alloc] initWithFrame:CoreFoundationRectangleMake(36,
                                                                          48,
                                                                          360,
                                                                          480)];

  self.label.text = @"Hello, world! 🌍";

  [self.view addSubview:self.label];
}

- (void)setupButton {
  let configuration = [UIButtonConfiguration makePlainButtonConfiguration];
  configuration.title = @"Tap Me";

  @weakify(self)
  let action = [UIAction makeActionWithIdentifier:nil
                                          handler:^(UIAction* action) {
    @strongify(self)

    [self buttonDidTap];
  }];

  self.button = [UIButton makeButtonWithConfiguration:configuration
                                        primaryAction:action];
  self.button.frame = CoreFoundationRectangleMake(36, 58, 360, 580);

  [self.view addSubview:self.button];
}

- (void)buttonDidTap {
  self.label.text = @"Button was tapped! 🎉";
}

@end

C_ASSUME_NONNULL_END

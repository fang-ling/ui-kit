/*
 *  UIViewController.h
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

#import "UIViewController.h"

#import "UIScreen.h"

C_ASSUME_NONNULL_BEGIN

@interface UIViewController() {
  UIView* _view;
}

@end

@implementation UIViewController

- (UIView*)view {
  if (self->_view == nil) {
    [self loadView];
  }

  return self->_view;
}

- (void)setView:(UIView*)view {
  if (self->_view) {
    self->_view.nextResponder = nil;
  }
  self->_view = view;
  self->_view.nextResponder = self;
}

- (CBoolean)isViewLoaded {
  return self->_view != nil;
}

- (void)loadView {
  self.view = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
  [self viewDidLoad];
}

- (void)viewDidLoad { }

@end

C_ASSUME_NONNULL_END

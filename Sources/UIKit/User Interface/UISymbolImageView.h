/*
 *  UISymbolImageView.h
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

/**
 * A view that displays a symbol image.
 */
@interface _UISymbolImageView: UIImageView

/**
 * Creates an image view initialized with the specified symbol image.
 *
 * The image you specified is used to configure the initial size of the image
 * view itself. Use constraints and the image view's content mode to adjust the
 * image view's final size onscreen.
 *
 * - Parameter image: The initial image to display in the image view.
 *
 * - Returns: An initialized image view object.
 */
- (instancetype)initWithImage:(UIImage*)image;

@end

/*
 *  UIImageView.h
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

#import "UIView.h"
#import "../Graphics/UIImage.h"

C_ASSUME_NONNULL_BEGIN

/**
 * A view that displays a single image or a sequence of animated images in your
 * interface.
 *
 * Image views let you efficiently draw any image that can be specified using a
 * ``UIImage`` object. For example, you can use the ``UIImageView`` class to
 * display the contents of many standard image files, such as JPEG and PNG
 * files. You can configure image views programmatically and change the images
 * they display at runtime. For animated images, you can also use the methods of
 * this class to start and stop the animation and specify other animation
 * parameters.
 *
 * ## Topics
 *
 * ### Creating an image view
 *
 * - ``makeImageViewWithImage:``
 */
@interface UIImageView: UIView

/**
 * The image displayed in the image view.
 *
 * This property contains the main image displayed by the image view. This image
 * is displayed when the image view is in its natural state. When highlighted,
 * the image view displays the image in its ``highlightedImage`` property
 * instead. If that property is set to `nil`, the image view applies a default
 * highlight to this image. If the ``animationImages`` property contains a valid
 * set of images, those images are used instead.
 *
 * Changing the image in this property does not automatically change the size of
 * the image view. After setting the image, call the ``sizeToFit`` method to
 * recompute the image view's size based on the new image and the active
 * constraints.
 *
 * This property is set to the image you specified at initialization time. If
 * you did not use the ``makeImageViewWithImage:`` or
 * ``makeImageViewWithImage:highlightedImage:`` method to initialize your image
 * view, the initial value of this property is `nil`.
 */
@property (nonatomic) UIImage* image;

/**
 * Creates an image view initialized with the specified image.
 *
 * The image you specified is used to configure the initial size of the image
 * view itself. Use constraints and the image view's content mode to adjust the
 * image view's final size onscreen.
 *
 * If you specify an animated image whose duration is greater than 0, the image
 * view automatically starts playing the animation.
 *
 * - Parameter image: The initial image to display in the image view. You may
 *   specify an image object that contains an animated sequence of images.
 *
 * - Returns: An initialized image view object.
 */
+ (instancetype)makeImageViewWithImage:(UIImage*)image;

@end

C_ASSUME_NONNULL_END

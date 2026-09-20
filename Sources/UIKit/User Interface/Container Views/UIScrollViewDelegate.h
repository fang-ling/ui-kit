/*
 *  UIScrollViewDelegate.h
 *  ui-kit
 *
 *  Created by Fang Ling on 2026/7/19.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and limitations under the License.
 */

#import <CKit/CKit.h>
#import <ObjectiveCKit/ObjectiveCKit.h>

C_ASSUME_NONNULL_BEGIN

/**
 * The interface for the delegate of a scroll view.
 *
 * The methods that the ``UIScrollViewDelegate`` protocol declares allow the adopting delegate to respond to messages from the ``UIScrollView`` class.
 * The delegate responds to and affects operations like scrolling, zooming, deceleration of scrolled content, and scrolling animations.
 */
@protocol UIScrollViewDelegate <ObjectiveCObject>

@end

C_ASSUME_NONNULL_END

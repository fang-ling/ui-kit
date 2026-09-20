/*
 *  UIScrollView.h
 *  ui-kit
 *
 *  Created by Fang Ling on 2026/7/11.
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

#import "../UIView.h"
#import "UIScrollViewDelegate.h"

#import <CKit/CKit.h>
#import <CoreFoundationKit/CoreFoundationKit.h>
#import <ObjectiveCKit/ObjectiveCKit.h>

C_ASSUME_NONNULL_BEGIN

/**
 * A view that allows the scrolling and zooming of its contained views.
 *
 * ``UIScrollView`` is the superclass of several UIKit classes, including ``UITableView`` and ``UITextView``.
 *
 * A scroll view is a view with an origin that's adjustable over the content view.
 * It clips the content to its frame, which generally (but not necessarily) coincides with that of the app's main window.
 * A scroll view tracks the movements of fingers, and adjusts the origin accordingly.
 * The view that shows its content through the scroll view draws that portion of itself according to the new origin, which is pinned to an offset in the content view.
 * The scroll view itself does no drawing except for displaying vertical and horizontal scroll indicators.
 * The scroll view must know the size of the content view so it knows when to stop scrolling.
 *
 * The object that manages the drawing of content that displays in a scroll view needs to tile the content's subviews so that no view exceeds the size of the screen.
 * As users scroll in the scroll view, this object adds and removes subviews as necessary.
 *
 * A scroll view also handles zooming and panning of content.
 * As the user makes a pinch-in or pinch-out gesture, the scroll view adjusts the offset and the scale of the content.
 * When the gesture ends, the object managing the content view updates subviews of the content as necessary.
 * (Note that the gesture can end and a finger might still be down.)
 * While the gesture is in progress, the scroll view doesn't send any tracking calls to the subview.
 *
 * The ``UIScrollView`` class can have a delegate that must adopt the ``UIScrollViewDelegate`` protocol.
 * For zooming and panning to work, the delegate must implement both ``viewForZoomingInScrollView:`` and ``scrollViewDidEndZooming:withView:atScale:``.
 * In addition, the ``maximumZoomScale`` and ``minimumZoomScale`` zoom scales must be different.
 *
 * ## Topics
 *
 * ### Responding to scroll view interactions
 *
 * - ``delegate``
 * - ``UIScrollViewDelegate``
 *
 * ### Managing the content size and offset
 *
 * - ``contentSize``
 * - ``contentOffset``
 */
@interface UIScrollView: UIView

/**
 * The delegate of the scroll view.
 *
 * The delegate must adopt the ``UIScrollViewDelegate`` protocol.
 * The ``UIScrollView`` class, which doesn't retain the delegate, invokes each protocol method the delegate implements.
 */
@property (nullable, nonatomic, weak) ObjectiveCAnyObject<UIScrollViewDelegate> delegate;

/**
 * The size of the content view.
 *
 * The unit of size is pixels. The default size is ``CoreFoundationSizeZero``.
 */
@property (nonatomic) CoreFoundationSize contentSize;

/**
 * The point at which the origin of the content view is offset from the origin of the scroll view.
 *
 * The default value is ``CoreFoundationPointZero``.
 */
@property (nonatomic) CoreFoundationPoint contentOffset;

@end

C_ASSUME_NONNULL_END

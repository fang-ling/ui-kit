/*
 *  UITabBar.h
 *  ui-kit
 *
 *  Created by Fang Ling on 2026/6/20.
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

#import "UITab.h"
#import "UITabBarAppearance.h"
#import "UIView.h"

#import <CKit/CKit.h>

C_ASSUME_NONNULL_BEGIN

@class UITabBar;

/**
 * A protocol defines optional methods for a delegate of a UITabBar object.
 *
 * The ``UITabBar`` class provides the ability for the user to reorder, remove,
 * and add items to the tab bar; this process is referred to as customizing the
 * tab bar. The tab bar delegate receives messages when customizing occurs.
 *
 * ## Topics
 *
 * ### Customizing tab bars
 *
 * - ``tabBar:didSelectItem:``
 */
@protocol UITabBarDelegate

@optional

/**
 * Sent to the delegate when the user selects a tab bar item.
 *
 * - Parameters:
 *   - tabBar: The tab bar that is being customized.
 *   - item: The tab bar item that was selected.
 */
- (void)tabBar:(UITabBar*)tabBar didSelectItem:(UITab*)item;

@end

C_ASSUME_NONNULL_END

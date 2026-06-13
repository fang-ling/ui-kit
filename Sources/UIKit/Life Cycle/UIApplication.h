/*
 *  UIApplication.h
 *  ui-kit
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

#import "../User Interactions/UIResponder.h"
#import "../User Interface/UIControl.h"
#import "../User Interface/UIWindow.h"

#import "UIApplicationDelegate.h"

#import <CKit/CKit.h>
#import <FoundationKit/FoundationKit.h>

C_ASSUME_NONNULL_BEGIN

@interface UIApplication: UIResponder

/**
 * The singleton app instance.
 *
 * The ``UIApplicationMain`` function creates the shared app instance at launch
 * time.
 */
@property (class, nonatomic, readonly) UIApplication* sharedApplication;

/**
 * The delegate of the app object.
 *
 * Every app must have an app delegate object to respond to app-related
 * messages. For example, the app notifies its delegate when the app finishes
 * launching and when its foreground or background execution status changes.
 * Similarly, app-related messages coming from the system are often routed to
 * the app delegate for handling.
 *
 * The delegate must adopt the ``UIApplicationDelegate`` formal protocol.
 */
@property (nonatomic) ObjectiveCAnyObject<UIApplicationDelegate> delegate;

/**
 * The app's visible and hidden windows.
 *
 * This property contains the ``UIWindow`` objects currently associated with the
 * app. This list doesn't include windows created and managed by the system,
 * such as the window used to display the status bar.
 *
 * The array orders the windows from back to front by window level; thus, the
 * last window in the array is on top of all other app windows.
 */
@property (nonatomic, readonly) FoundationMutableArray* windows;

/**
 * The app's key window.
 *
 * This property holds the ``UIWindow`` object in the windows array that is most
 * recently sent the ``makeKeyAndVisible`` message.
 */
@property (nonatomic, readonly) UIWindow* keyWindow;

/**
 * Sends an action message to a specified target with the specified events.
 *
 * Normally, this method is invoked by a ``UIControl`` object that the user has
 * touched. The default implementation dispatches the action method to the given
 * target object. Subclasses may override this method to perform special
 * dispatching of action messages.
 *
 * - Parameters:
 *   - target: The object to receive the action message.
 *   - controlEvents: A bit-mask with flags that specify the control events for
 *     which the control sends action messages. See ``UIControlEvents`` for
 *     bit-mask constants.
 */
- (void)sendEventToTarget:(CUnsignedInteger32)target
         forControlEvents:(UIControlEvents)controlEvents;

@end

/**
 * Creates the application object and the application delegate and sets up the
 * event cycle.
 *
 * - Parameter delegateClassName: The name of the class from which the application
 *   delegate is instantiated.
 *
 * - Returns: This function never returns.
 */
void UIApplicationMain(CString delegateClassName);

C_ASSUME_NONNULL_END

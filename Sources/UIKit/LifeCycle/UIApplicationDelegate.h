/*
 *  UIApplicationDelegate.h
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

#import <CKit/CKit.h>

C_ASSUME_NONNULL_BEGIN

/**
 * A set of methods to manage shared behaviors for your app.
 *
 * Your app delegate object manages your app's shared behaviors. The app
 * delegate is effectively the root object of your app, and it works in
 * conjunction with ``UIApplication`` to manage some interactions with the
 * system. Like the ``UIApplication`` object, UIKit creates your app delegate
 * object early in your app's launch cycle so it's always present.
 *
 * Use your app delegate object to handle the following tasks:
 *
 *   - Initializing your app's central data structures
 *   - Responding to events that target the app itself, and aren't specific to
 *     your app's views or view controllers
 *   - Registering for any required services at launch time
 */
@protocol UIApplicationDelegate

@optional
/**
 * Tells the delegate that the launch process is almost done and the app is
 * almost ready to run.
 *
 * Use this method (and the corresponding ``applicationWillFinishLaunching``
 * method) to complete your app's initialization:
 *
 *   - The system performs state restoration before calling this method
 *   - The system calls this method when the process is done launching
 *   - The system presents your app's window and other UI
 *   - At some point after this method returns, the system calls another of your
 *     app delegate's methods to move the app to the active (foreground) state
 *     or the background state
 */
- (void)applicationDidFinishLaunching;

@end

C_ASSUME_NONNULL_END

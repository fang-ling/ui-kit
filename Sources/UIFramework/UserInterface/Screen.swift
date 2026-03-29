//
//  Screen.swift
//  ui-framework
//
//  Created by Fang Ling on 2026/3/29.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import FoundationFramework

/// An object that defines the properties associated with a hardware-based
/// display.
///
/// A ``Screen`` object provides information about the screens attached to a
/// device. A screen object for a device has information about the display.
///
/// Avoid using screen objects to make decisions about your app's interface.
/// Use a screen object only as needed to retrieve screen-related information,
/// such as the screen's bounds rectangle, brightness, and overscan settings.
/// Apps that rely on the screen dimensions can use the object in the
/// ``fixedCoordinateSpace`` property as a fixed point of reference for any
/// calculations they must make.
@available(macOS 13.3.0, *)
@MainActor public class Screen {
  /// The screen object representing the device's screen.
  public static let main = Screen()

  /// The bounding rectangle of the screen, measured in pixels.
  ///
  /// This rectangle is specified in the current coordinate space, which takes
  /// into account any interface rotations in effect for the device. Therefore,
  /// the value of this property may change when the device rotates between
  /// portrait and landscape orientations.
  public var bounds: Rectangle {
    Rectangle(
      x: 0,
      y: 0,
      width: JavaScriptBridge.getWindowWidth(),
      height: JavaScriptBridge.getWindowHeight()
    )
  }
}

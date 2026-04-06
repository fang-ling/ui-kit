//
//  Button.swift
//  ui-framework
//
//  Created by Fang Ling on 2026/3/22.
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

import AnimationFramework
import FoundationFramework
import JavaScriptBridgeFramework

/// A control that executes your custom code in response to user interactions.
///
/// When you tap a button, or select a button that has focus, the button
/// performs any actions attached to it. You communicate the purpose of a button
/// using a text label, an image, or both. The appearance of buttons is
/// configurable, so you can tint buttons or format titles to match the design
/// of your app. You can add buttons to your interface programmatically.
///
/// When adding a button to your interface, perform the following steps:
///   - Set the type of the button at creation time
///   - Supply a title string or image; size the button appropriately for your
///     content
///   - Connect one or more action methods to the button
///   - Set up Auto Layout rules to govern the size and position of the button
///     in your interface
///   - Provide accessibility information and localized strings
///
/// #### Respond to button taps
///
/// Buttons use the target-action design pattern to notify your app when the
/// user taps the button. Rather than handle touch events directly, you assign
/// action methods to the button and designate which events trigger calls to
/// your methods. At runtime, the button handles all incoming touch events and
/// calls your methods in response.
///
/// You connect a button to your action method using the ``addAction(_:for:)``
/// method.
///
/// #### Configure a button's appearance
///
/// A button's type defines its basic appearance and behavior. You specify the
/// type of a button at creation time using the ``init(type:)`` method. After
/// creating a button, you can't change its type. The most commonly used button
/// types are the `custom` and `system` types, but use the other types when
/// appropriate.
///
/// #### Configure button states
///
/// Buttons have five states that define their appearance: default, highlighted,
/// focused, selected, and disabled. When you add a button to your interface,
/// it's in the default state initially, which means the button is enabled and
/// the user isn't interacting with it. As the user interacts with the button,
/// its state changes to the other values. For example, when the user taps a
/// button with a title, the button moves to the highlighted state.
///
/// When configuring a button programmatically, you specify attributes for each
/// state separately. If you don't specify attributes for a particular state,
/// the ``Button`` class provides a reasonable default behavior. For example, a
/// disabled button is normally dimmed and doesn't display a highlight when
/// tapped. Other properties of this class, such as the
/// ``adjustsImageWhenHighlighted`` and ``adjustsImageWhenDisabled`` properties,
/// let you alter the default behavior in specific cases.
///
/// #### Provide content
///
/// The content of a button consists of a title string or image that you
/// specify. The content you specify is used to configure the ``Label`` and
/// ``ImageView`` object managed by the button itself. You can access these
/// objects using the ``titleLabel`` or ``imageView`` properties and modify
/// their values directly. The methods of this class also provide a convenient
/// shortcut for configuring the appearance of your string or image.
///
/// Normally, you configure a button using either a title or an image and size
/// the button accordingly. Buttons can also have a background image, which is
/// positioned behind the content you specify. It's possible to specify both an
/// image and a title for buttons.
///
/// When setting the content of a button, you must specify the title, image, and
/// appearance attributes for each state separately. If you don't customize the
/// content for a particular state, the button uses the values associated with
/// the default state and adds any appropriate customizations. For example, in
/// the highlighted state, an image-based button draws a highlight on top of the
/// default image if no custom image is provided.
///
/// #### Customize tint color
///
/// You can specify a custom button tint using the ``tintColor`` property. This
/// property sets the color of the button image and text. If you don't
/// explicitly set a tint color, the button uses its superview's tint color.
///
/// #### Specify edge insets
///
/// Use insets to add or remove space around the content in your custom or
/// system buttons. You can specify separate insets for your button's title
/// (``titleEdgeInsets``), image (``imageEdgeInsets``), and both the title and
/// image together (``contentEdgeInsets``). When applied, insets affect the
/// corresponding content rectangle of the button, which the Auto Layout engine
/// uses to determine the button's position.
///
/// There should be no reason for you to adjust the edge insets for info,
/// contact, or disclosure buttons.
///
/// #### Support localization
///
/// To internationalize a button, specify a localized string for the button's
/// title text. (You may also localize a button's image as appropriate.)
@available(macOS 13.3.0, *)
@MainActor public class Button: Control {
  /// A view that displays the value of the ``currentTitle`` property for a
  /// button.
  ///
  /// Although this property is read-only, its own properties are read/write.
  /// Use these properties primarily to configure the text of the button.
  ///
  /// Do not use the label object to set the text color or the shadow color.
  /// Instead, use the ``setTitleColor(_:for:)`` and
  /// ``setTitleShadowColor(_:for:)`` methods of this class to make those
  /// changes. To set the actual text of the label, use ``setTitle(_:for:)``
  /// (`button.titleLabel.text` does not let you set the text).
  public private(set) var titleLabel: Label?

  /// The button type.
  public private(set) var buttonType: ButtonType

  public override init(frame: Rectangle = .zero) {
    buttonType = .custom

    super.init(frame: frame)

    JavaScriptBridge.initializeElement(
      elementID: layer.contents,
      elementType: .button
    )
  }

  /// Creates and returns a new button of the specified type.
  ///
  /// This method is a convenience constructor for creating button objects with
  /// specific configurations.
  ///
  /// When creating a custom button — a button with the type
  /// ``Button.ButtonType.custom`` — the frame of the button is set to
  /// `(0, 0, 0, 0)` initially. Before adding the button to your interface, you
  /// should update the frame to a more appropriate value.
  public convenience init(type buttonType: Button.ButtonType) {
    self.init(frame: .zero)

    self.buttonType = buttonType
  }

  /// Sets the title to use for the specified state.
  ///
  /// Use this method to set the title for the button. The title you specify
  /// derives its formatting from the button's associated label object. If you
  /// set both a title and an attributed title for the button, the button
  /// prefers the use of the attributed title over this one.
  ///
  /// At a minimum, set the value for the normal state. If you don't specify a
  /// title for the other states, the button uses the title associated with the
  /// normal state. If you don't set the value for normal, then the property
  /// defaults to a system value.
  public func setTitle(_ title: String?, for state: Control.State) {
    if titleLabel == nil {
      let titleLabel = Label(frame: .zero)
      self.titleLabel = titleLabel
      addSubview(titleLabel)
    }

    titleLabel?.text = title

    needsLayout = true
  }

  public override func layoutSubviews() {
    if let titleLabel, let text = titleLabel.text {
      let textSize = JavaScriptBridge.measureTextSize(
        text: text,
        // TODO: Apply font css
        styleText: String("font-family: system-ui; font-size: 11px")
      )
      // TODO: Use findMinimum
      titleLabel.frame.size.width = min(frame.size.width, textSize.width)
      titleLabel.frame.size.height = min(frame.size.height, textSize.height)

      // By default, labels are centered
      titleLabel.frame.origin.x =
        (frame.size.width - titleLabel.frame.size.width) / 2
      titleLabel.frame.origin.y =
        (frame.size.height - titleLabel.frame.size.height) / 2
    }
  }
}

@available(macOS 13.3.0, *)
extension Button {
  /// Specifies the style of a button.
  public enum ButtonType {
    /// No button style.
    case custom

    /// A system style button, such as those shown in navigation bars and
    /// toolbars.
    case system
  }
}

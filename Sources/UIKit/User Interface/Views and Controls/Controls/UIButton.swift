//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIButton.swift
//  ui-kit
//
//  Created by Fang Ling on 2026/3/22.
//
//  This source file is part of the UIKit open source project
//
//  Copyright (c) 2025-2026 Fang Ling <fangling@fangl.ing>
//  Licensed under Apache License v2.0
//
//  See LICENSE for license information
//
//  SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//

#if !os(iOS)

import CoreGraphicsKit

/// A control that executes your custom code in response to user interactions.
///
/// When you tap a button, or select a button that has focus, the button performs any actions attached to it. You communicate the purpose of a button using a text label, an image, or both. The
/// appearance of buttons is configurable, so you can tint buttons or format titles to match the design of your app.
///
/// When adding a button to your interface, perform the following steps:
///
///   - Set the type of the button at creation time.
///   - Supply a title string or image; size the button appropriately for your content.
///   - Connect one or more action methods to the button.
///   - Set up Auto Layout rules to govern the size and position of the button in your interface.
///   - Provide accessibility information and localized strings.
///
/// ### Respond to button taps
///
/// Buttons use the target-action design pattern to notify your app when the user taps the button. Rather than handle touch events directly, you assign action methods to the button and designate which
/// events trigger calls to your methods. At runtime, the button handles all incoming touch events and calls your methods in response.
///
/// You connect a button to your action method using the ``addAction(_:for:)`` method.
///
/// ### Configure a button's appearance
///
/// A button's type defines its basic appearance and behavior. You specify the type of a button at creation time using the ``init(type:)`` method. After creating a button, you can't change its type.
/// The most commonly used button types are the ``Custom`` and ``System`` types, but use the other types when appropriate.
///
/// #### Configure button states
///
/// Buttons have five states that define their appearance: default, highlighted, focused, selected, and disabled. When you add a button to your interface, it's in the default state initially, which
/// means the button is enabled and the user isn't interacting with it. As the user interacts with the button, its state changes to the other values. For example, when the user taps a button with a
/// title, the button moves to the highlighted state.
///
/// When configuring a button, you specify attributes for each state separately. If you don't specify attributes for a particular state, the ``UIButton`` class provides a reasonable default behavior.
/// For example, a disabled button is normally dimmed and doesn't display a highlight when tapped. Other properties of this class, such as the ``adjustsImageWhenHighlighted`` and
/// ``adjustsImageWhenDisabled`` properties, let you alter the default behavior in specific cases.
///
/// #### Provide content
///
/// The content of a button consists of a title string or image that you specify. The content you specify is used to configure the ``UILabel`` and ``UIImageView`` object managed by the button itself.
/// You can access these objects using the ``titleLabel`` or ``imageView`` properties and modify their values directly. The methods of this class also provide a convenient shortcut for configuring the
/// appearance of your string or image.
///
/// Normally, you configure a button using either a title or an image and size the button accordingly. Buttons can also have a background image, which is positioned behind the content you specify.
/// It's possible to specify both an image and a title for buttons, which results in the appearance shown in the following image. You can access the current content of a button using the indicated
/// properties.
///
///    ```
///    ┌──────────────┐
///    │ ┌─┐         <────currentBackgroundImage
///    │ │ │ Button   │
///    │ └─┘ ↑        │
///    └──↑──│────────┘
///       │  │
///       │  │currentAttributedTitle
///       │   currentTitleColor
///       │
///       │currentImage
///    ```
///
/// When setting the content of a button, you must specify the title, image, and appearance attributes for each state separately. If you don't customize the content for a particular state, the button
/// uses the values associated with the Default state and adds any appropriate customizations. For example, in the highlighted state, an image-based button draws a highlight on top of the default
/// image if no custom image is provided.
///
/// #### Customize tint color
///
/// You can specify a custom button tint using the ``tintColor`` property. This property sets the color of the button image and text. If you don't explicitly set a tint color, the button uses its
/// superview's tint color.
///
/// #### Specify edge insets
///
/// Use insets to add or remove space around the content in your custom or system buttons. You can specify separate insets for your button's title (``titleEdgeInsets``), image (``imageEdgeInsets``),
/// and both the title and image together (``contentEdgeInsets``). When applied, insets affect the corresponding content rectangle of the button, which the Auto Layout engine uses to determine the
/// button's position.
///
/// There should be no reason for you to adjust the edge insets for info, contact, or disclosure buttons.
///
/// ### Support localization
///
/// To internationalize a button, specify a localized string for the button's title text. (You may also localize a button's image as appropriate.)
///
/// Use the system's built-in support for loading localized strings and resources.
///
/// ### Make buttons accessible
///
/// Buttons are accessible by default. The default accessibility traits for a button are Button and User Interaction Enabled.
///
/// The accessibility label, traits, and hint are spoken back to the user when VoiceOver is enabled on a device. The button's title overwrites its accessibility label; even if you set a custom value
/// for the label, VoiceOver speaks the value of the title. VoiceOver speaks this information when a user taps the button once. For example, when a user taps the Options button in Camera, VoiceOver
/// speaks the following:
///
///   - "Options. Button. Shows additional camera options."
///
/// For more information about making UIKit controls accessible, see the accessibility information in ``UIControl``.
///
/// ## Topics
///
/// ### Creating buttons from a configuration object
///
/// - ``init(configuration:primaryAction:)``
/// - ``UIButton/Configuration``
///
/// ### Managing the appearance with a configuration object
///
/// - ``configuration``
/// - ``setNeedsUpdateConfiguration()``
/// - ``updateConfiguration()``
/// - ``configurationUpdateHandler``
/// - ``UIButton/ConfigurationUpdateHandler``
///
/// ### Managing the title
///
/// - ``titleLabel``
@MainActor
public class UIButton: UIControl {
  internal var _imageView: UIImageView?

  /// The configuration for the button's appearance.
  ///
  /// Setting a configuration opts the button into a configuration system based on ``UIButton/Configuration``. This configuration supports several options and behaviors unavailable with other
  /// configuration methods. Features include subtitle labels, extended control over background appearance, and ways to transform the button configuration when the button changes state.
  ///
  /// When using a configuration, the button ignores deprecated methods and properties of ``UIButton``. You can combine most other methods and properties of ``UIButton`` with a configuration. If you
  /// have existing code to configure a button, you can set this property to take advantage of additional configuration features.
  ///
  /// If the configuration is `nil`, other supported properties and methods of ``UIButton``, such as ``setTitle(_:for:)``, control the appearance of the button.
  public var configuration: Configuration? {
    didSet {
      self._applyConfiguration()
    }
  }

  /// A closure that executes when the button state changes.
  ///
  /// Use this property as an alternative to overriding ``updateConfiguration()``. Set a closure to respond to button state changes by updating the button configuration.
  public var configurationUpdateHandler: ConfigurationUpdateHandler?

  /// A view that displays the value of the `currentTitle` property for a button.
  ///
  /// Although this property is read-only, its own properties are read/write. Use these properties primarily to configure the text of the button. For example:
  ///
  ///    ```swift
  ///    let button = UIButton(type: .system)
  ///    button.titleLabel.font = UIFont.systemFont(ofSize: 12)
  ///    ```
  ///
  /// Do not use the label object to set the text color or the shadow color. Instead, use the ``setTitleColor(_:for:)`` and ``setTitleShadowColor(_:for:)`` methods of this class to make those changes.
  /// To set the actual text of the label, use ``setTitle(_:for:)`` (`button.titleLabel.text` does not let you set the text).
  ///
  /// The ``titleLabel`` property returns a value even if the button has not been displayed yet. The value of the property is `nil` for system buttons.
  public private(set) var titleLabel: UILabel?

  /// Creates a new button with the specified configuration and registers the primary action event.
  ///
  /// - Parameters:
  ///   - configuration: The button configuration.
  ///   - primaryAction: The action to perform for the ``UIControl/Event/primaryActionTriggered`` control event.
  public convenience init(configuration: UIButton.Configuration, primaryAction: UIAction? = nil) {
    self.init(frame: CoreGraphicsRectangle(x: 0, y: 0, width: 0, height: 0))

    self.configuration = configuration
    self._applyConfiguration()

    if let primaryAction {
      self.addAction(primaryAction, for: .primaryActionTriggered)
    }
  }

  /// Requests the system update the button configuration.
  ///
  /// Call this method to make the system call ``updateConfiguration()``. The system calls this method automatically when the button's state changes. If you call this method multiple times before the
  /// system calls ``updateConfiguration()``, the system calls ``updateConfiguration()`` once.
  public func setNeedsUpdateConfiguration() {
    self.updateConfiguration()
  }

  /// Updates the button configuration in response to a button state change.
  ///
  /// Override this method in your subclass to respond changes to the button's state. Make any necessary changes and update the button's configuration.
  ///
  /// Don't call this method directly. Call ``setNeedsUpdateConfiguration()`` to request an update to your button.
  public func updateConfiguration() {
    self.configurationUpdateHandler?(self)
  }

  private func _applyConfiguration() {
    if let title = self.configuration?.title {
      if self.titleLabel == nil {
        let label = UILabel(frame: CoreGraphicsRectangle(x: 0, y: 0, width: 0, height: 0))
        self.titleLabel = label

        self.addSubview(label)
      }

      self.titleLabel?.text = title
      self.titleLabel?.textColor = self.configuration?.baseForegroundColor
    } else {
      self.titleLabel?.removeFromSuperview()
      self.titleLabel = nil
    }

    if let image = self.configuration?.image {
      if self._imageView == nil {
        let imageView = UIImageView(image: image)
        self._imageView = imageView
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 17, weight: .medium)

        self.addSubview(imageView)
      } else {
        self._imageView?.image = image
      }

      //self._imageView.tintColor = configuration?.baseForegroundColor
    } else {
      self._imageView?.removeFromSuperview()
      self._imageView = nil
    }

    self.setNeedsLayout()
    self.setNeedsDisplay()
  }

  public override func layoutSubviews() {
    super.layoutSubviews()

    guard let imagePlacement = self.configuration?.imagePlacement else {
      return
    }

    switch imagePlacement {
    case .trailing:
      if let imageView = self._imageView, let image = self._imageView?.image {
        imageView.frame = CoreGraphicsRectangle(
          x: self.bounds.size.width - image.size.width * image.scale,
          y: (self.bounds.size.height - image.size.height * image.scale) / 2,
          width: image.size.width * image.scale,
          height: image.size.height * image.scale
        )
        self.titleLabel?.frame = CoreGraphicsRectangle(x: 0, y: 0, width: self.bounds.size.width - image.size.width * image.scale, height: self.bounds.size.height)
      } else {
        self.titleLabel?.frame = CoreGraphicsRectangle(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
      }

    case .top:
      var titleLabelSize = CoreGraphicsSize(width: 0, height: 0)
      if let text = self.titleLabel?.text, let font = self.titleLabel?.font {
        titleLabelSize = text.size(withAttributes: ["font-size": "\(font.pixelSize)px", "font-weight": "\(font.weight.rawValue)", "line-height": "\(font.lineHeight)px"])
      }

      if let imageView = self._imageView, let image = self._imageView?.image {

        let imagePadding = self.configuration?.imagePadding ?? 0

        imageView.frame = CoreGraphicsRectangle(
          x: (self.bounds.size.width - image.size.width * image.scale) / 2,
          y: (self.bounds.size.height - image.size.height * image.scale - imagePadding - titleLabelSize.height) / 2,
          width: image.size.width * image.scale,
          height: image.size.height * image.scale
        )
        self.titleLabel?.frame = CoreGraphicsRectangle(
          x: (self.bounds.size.width - titleLabelSize.width) / 2,
          y: (self.bounds.size.height - image.size.height * image.scale - imagePadding - titleLabelSize.height) / 2 + image.size.height * image.scale + imagePadding,
          width: titleLabelSize.width,
          height: titleLabelSize.height
        )
      } else {
        self.titleLabel?.frame = CoreGraphicsRectangle(x: 0, y: 0, width: titleLabelSize.width, height: titleLabelSize.height)
      }

    case .bottom:
      if let image = self._imageView?.image {
        self._imageView?.frame = CoreGraphicsRectangle(
          x: (self.bounds.size.width - image.size.width * image.scale) / 2,
          y: self.bounds.size.height - image.size.height * image.scale,
          width: image.size.width * image.scale,
          height: image.size.height * image.scale
        )
        self.titleLabel?.frame = CoreGraphicsRectangle(
          x: 0,
          y: 0,
          width: self.bounds.size.width,
          height: self.bounds.size.height - image.size.height * image.scale - (self.configuration?.imagePadding ?? 0)
        )
      } else {
        self.titleLabel?.frame = CoreGraphicsRectangle(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
      }

    default:
      if let image = self._imageView?.image {
        self._imageView?.frame = CoreGraphicsRectangle(
          x: 0,
          y: (self.bounds.size.height - image.size.height * image.scale) / 2,
          width: image.size.width * image.scale,
          height: image.size.height * image.scale
        )
        self.titleLabel?.frame = CoreGraphicsRectangle(
          x: image.size.width + (self.configuration?.imagePadding ?? 0),
          y: 0,
          width: self.bounds.size.width - (image.size.width + (self.configuration?.imagePadding ?? 0)),
          height: self.bounds.size.height
        )
      } else {
        self.titleLabel?.frame = CoreGraphicsRectangle(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
      }
    }
  }
}

#endif

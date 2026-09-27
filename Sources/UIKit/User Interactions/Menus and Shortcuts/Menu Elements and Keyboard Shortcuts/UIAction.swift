//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIAction.swift
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

import FoundationKit
import SwiftFramework

/// A menu element that performs its action in a closure.
///
/// Create a ``UIAction`` object when you want a menu element that performs its action in a closure. The following example adds an action-based menu to the _File_ menu:
///
///    ```swift
///    // Create a closure-based action to use as a menu element.
///    let refreshAction = UIAction(title: "Refresh") { (action) in
///      print("Refresh the data.")
///    }
///
///    // Use the .displayInline option to avoid displaying the menu as a submenu,
///    // and to separate it from the other menu elements using a line separator.
///    let refreshMenuItem = UIMenu(title: "", options: .displayInline, children: [refreshAction])
///
///    // Insert the menu into the File menu before the Close menu.
///    builder.insertSibling(refreshMenuItem, beforeMenu: .close)
///    ```
///
/// ## Topics
///
/// ### Creating an action
///
/// - ``init(title:subtitle:image:identifier:discoverabilityTitle:attributes:state:handler:)``
/// - ``UIAction/Identifier``
/// - ``UIActionHandler``
///
/// ### Getting information about the action
///
/// - ``title``
/// - ``image``
/// - ``identifier``
/// - ``discoverabilityTitle``
/// - ``attributes``
/// - ``state``
/// - ``
@MainActor
public class UIAction: UIMenuElement {
  internal var _handler: UIActionHandler

  /// The unique identifier for the action.
  public private(set) var identifier: UIAction.Identifier

  /// An elaborated title that explains the purpose of the action.
  public var discoverabilityTitle: SwiftString?

  /// The attributes indicating the style of the action.
  public var attributes: /*UIMenuElement.Attributes*/Any?

  /// The state of the action.
  public var state: /*UIMenuElement.State*/Any?

  /// Creates an action with the specified title, subtitle, image, identifier, discoverability title, attributes, state, and handler.
  ///
  /// - Parameters:
  ///   - title: The title to display for the action.
  ///   - subtitle: The subtitle to display alongside the action's title.
  ///   - image: The image to display next to the action's title. Only the ``UIMenuSystem/context`` menu system supports the display of an image.
  ///   - identifier: The unique identifier for the action. Specify `nil` to let this method create a unique identifier for you.
  ///   - discoverabilityTitle: An elaborated title that explains the purpose of the action.
  ///   - attributes: The attributes indicating the style of the action.
  ///   - state: The initial state of the action.
  ///   - handler: The handler to invoke after a person selects the action. This handler has the following parameter:
  ///     - action: The action that a person selects.
  public init(
    title: SwiftString = "",
    subtitle: SwiftString? = nil,
    image: /*UIImage*/Any? = nil,
    identifier: UIAction.Identifier? = nil,
    discoverabilityTitle: SwiftString? = nil,
    attributes: /*UIMenuElement.Attributes*/Any? = [],
    state: /*UIMenuElement.State*/Any? = /*.off*/nil,
    handler: @escaping UIActionHandler
  ) {
    if let identifier {
      self.identifier = identifier
    } else {
      self.identifier = Identifier(rawValue: "dev.fangling.action-\(FoundationUUID().uuidString)")
    }

    self.discoverabilityTitle = discoverabilityTitle
    self.attributes = attributes
    self.state = state
    self._handler = handler

    super.init(title: title, subtitle: subtitle, image: image)
  }
}

extension UIAction: UIMenuLeaf {
  public func performWithSender(_ sender: Any?, target: Any?) {
    self._handler(self)
  }
}

/// A type that defines the closure for an action handler.
///
/// - Parameter action: The action selected by the user.
public typealias UIActionHandler = (UIAction) -> Void

#endif

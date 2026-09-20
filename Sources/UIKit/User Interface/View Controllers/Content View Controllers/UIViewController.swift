//===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===//
//
//  UIViewController.swift
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

import CKit
import FoundationKit

/// An object that manages a view hierarchy for your UIKit app.
///
/// The ``UIViewController`` class defines the shared behavior that's common to all view controllers. You rarely create instances of the ``UIViewController`` class directly. Instead, you subclass
/// ``UIViewController`` and add the methods and properties needed to manage the view controller's view hierarchy.
///
/// A view controller's main responsibilities include the following:
///
///   - Updating the contents of the views, usually in response to changes to the underlying data
///   - Responding to user interactions with views
///   - Resizing views and managing the layout of the overall interface
///   - Coordinating with other objects — including other view controllers — in your app
///
/// A view controller is tightly bound to the views it manages and takes part in handling events in its view hierarchy. Specifically, view controllers are ``UIResponder`` objects and are inserted into
/// the responder chain between the view controller's root view and that view's superview, which typically belongs to a different view controller. If none of the view controller's views handle an
/// event, the view controller has the option of handling the event or passing it along to the superview.
///
/// View controllers are rarely used in isolation. Instead, you often use multiple view controllers, each of which owns a portion of your app's user interface. For example, one view controller might
/// display a table of items while a different view controller displays the selected item from that table. Usually, only the views from one view controller are visible at a time. A view controller may
/// present a different view controller to display a new set of views, or it may act as a container for other view controllers' content and animate views however it wants.
///
/// ### Subclassing notes
///
/// Every app contains at least one custom subclass of ``UIViewController``. More often, apps contain many custom view controllers. Custom view controllers define the overall behaviors of your app,
/// including the app's appearance and how it responds to user interactions. The following sections provide a brief overview of some of the tasks your custom subclass performs.
///
/// #### Manage views
///
/// Each view controller manages a view hierarchy, the root view of which is stored in the ``view`` property of this class. The root view acts primarily as a container for the rest of the view
/// hierarchy. The size and position of the root view is determined by the object that owns it, which is either a parent view controller or the app's window. The view controller that's owned by the
/// window is the app's root view controller and its view is sized to fill the window.
///
/// View controllers load their views lazily. Accessing the ``view`` property for the first time loads or creates the view controller's views. You can specify the views for a view controller using the
/// ``loadView()`` method. In that method, create your view hierarchy programmatically and assign the root view of that hierarchy to the view controller's ``view`` property.
///
/// > Important: A view controller is the sole owner of its view and any subviews it creates. It's responsible for creating those views and for relinquishing ownership of them at the appropriate
///   times such as when the view controller itself is released. Each view controller must have its own unique set of views. You can't share views between view controllers.
///
/// A view controller's root view is always sized to fit its assigned space. For other views in your view hierarchy, use the Auto Layout constraints that govern how each view is positioned and sized
/// within its superview's bounds. You can create constraints programmatically and add them to your views at appropriate times.
///
/// #### Handle view-related notifications
///
/// When the visibility of its views changes, a view controller automatically calls its own methods so that subclasses can respond to the change. Use a method like ``viewIsAppearing(_:)`` to prepare
/// your views to appear onscreen, and use ``viewWillDisappear(_:)`` to save changes or other state information. Use other methods to make appropriate changes.
///
/// The following figure shows the possible visible states for a view controller's views and the state transitions that can occur. Not all will callback methods are paired with only a did callback
/// method. You need to ensure that if you start a process in a will callback method, you end the process in both the corresponding did and the opposite will callback method.
///
///    ```
///                                                    ┌─ viewWillAppear
///                                                    │  ┌ View added
///                 ViewDidDisappear   ┌─────────────┐ ↓  ↓
///             ┌──────────█──────────>│ Disappeared ├─█──█──────────────────┐
///             │                      └─────────────┘                       │
///             █ View removed                               ViewIsAppearing █
///             │                                                            ↓
///      ┌──────┴───────┐                                              ┌───────────┐
///      │ Disappearing │                                              │ Appearing │
///      └──────────────┘                                              └─────┬─────┘
///             ↑                                                            │
///             │                                                            │
///             │   viewWillDisappear   ┌──────────┐       viewDidAppear     │
///             └──────────█────────────┤ Appeared │<────────────█───────────┘
///                                     └──────────┘
///
///    ```
///
/// #### Handle view rotations
///
/// Rotations are treated as a change in the size of the view controller's view and are therefore reported using the ``viewWillTransition(to:with:)`` method. When the interface orientation changes,
/// UIKit calls this method on the window's root view controller. That view controller then notifies its child view controllers, propagating the message throughout the view controller hierarchy.
///
/// #### Implement a container view controller
///
/// A custom ``UIViewController`` subclass can also act as a container view controller. A container view controller manages the presentation of content of other view controllers it owns, also known as
/// its child view controllers. A child's view can be presented as-is or in conjunction with views owned by the container view controller.
///
/// Your container view controller subclass should declare a public interface to associate its children. The nature of these methods is up to you and depends on the semantics of the container you're
/// creating. You need to decide how many children can be displayed by your view controller at once, when those children are displayed, and where they appear in your view controller's view hierarchy.
/// Your view controller class defines what relationships, if any, are shared by the children. By establishing a clean public interface for your container, you ensure that children use its
/// capabilities logically, without accessing too many private details about how your container implements the behavior.
///
/// Your container view controller must associate a child view controller with itself before adding the child's root view to the view hierarchy. This allows UIKit to properly route events to child
/// view controllers and the views those controllers manage. Likewise, after it removes a child's root view from its view hierarchy, it should disconnect that child view controller from itself. To
/// make or break these associations, your container calls specific methods defined by the base class. These methods aren't intended to be called by clients of your container class; they are to be
/// used only by your container's implementation to provide the expected containment behavior.
///
/// Here are the essential methods you might need to call:
///
///   - ``addChild(_:)``
///   - ``removeFromParent()``
///   - ``willMove(toParent:)``
///   - ``didMove(toParent:)``
///
/// > Note: You're not required to override any methods when creating a container view controller.
///
/// #### Support state preservation and restoration
///
/// If you assign a value to the view controller's ``restorationIdentifier`` property, the system may ask the view controller to encode itself when the app transitions to the background. When
/// preserved, a view controller preserves the state of any views in its view hierarchy that also have restoration identifiers. View controllers don't automatically save any other state. If you're
/// implementing a custom container view controller, you must encode any child view controllers yourself. Each child you encode must have a unique restoration identifier.
///
/// ## Topics
///
/// ### Managing the view
///
/// - ``view``
/// - ``isViewLoaded``
/// - ``loadView()``
/// - ``viewDidLoad()``
/// - ``loadViewIfNeeded()``
///
/// ### Managing child view controllers in a custom container
///
/// - ``children``
/// - ``addChild(_:)``
/// - ``removeFromParent()``
///
/// ### Getting other related view controllers
///
/// - ``parent``
@MainActor
open class UIViewController: UIResponder {  // TODO: Add next.
  private var _view: UIView?

  /// The view that the controller manages.
  ///
  /// This property represents the root view of the view controller's view hierarchy. The default value of this property is `nil`.
  ///
  /// If you access this property when its value is `nil`, the view controller automatically calls the ``loadView()`` method and returns the resulting view.
  ///
  /// Each view controller is the sole owner of its view object. Don't associate the same view object with multiple view controllers. The only exception is that a container view controller
  /// implementation may add another view controller's view object to its own view hierarchy. Before adding the subview, the container must first call its ``addChild(_:)`` method to create a
  /// parent-child relationship between the two view controller objects.
  ///
  /// Because accessing this property can cause the view to be loaded automatically, you can use ``isViewLoaded`` to determine if the view is currently in memory. Unlike this property,
  /// ``isViewLoaded`` doesn't force the loading of the view if it's not currently in memory.
  public var view: UIView! {
    get {
      self.loadViewIfNeeded()

      return self._view
    }

    set {
      // self._view?.next = nil
      self._view = newValue
      // self->_view.nextResponder = self;
    }
  }

  /// A Boolean value indicating whether the view is currently loaded into memory.
  ///
  /// The value of this property is `true` when the view is in memory or `false` when it is not. Accessing this property does not attempt to load the view if it is not currently in memory.
  public var isViewLoaded: CBoolean {
    return self._view != nil
  }

  /// An array of view controllers that are children of the current view controller.
  ///
  /// This property does not include any presented view controllers. This property is only intended to be read by an implementation of a custom container view controller.
  public private(set) var children: FoundationArray<UIViewController> = []

  /// The parent view controller of the view controller.
  ///
  /// If the view controller is a child of a container view controller, this property holds the view controller it is contained in. If the view controller has no parent, the value in this property is
  /// `nil`.
  public private(set) weak var parent: UIViewController?

  /// Creates the view that the controller manages.
  ///
  /// You should never call this method directly. The view controller calls this method when its ``view`` property is requested but is currently `nil`. This method loads or creates a view and assigns
  /// it to the ``view`` property.
  ///
  /// You can override this method in order to create your views manually. If you choose to do so, assign the root view of your view hierarchy to the ``view`` property. The views you create should be
  /// unique instances and should not be shared with any other view controller object. Your custom implementation of this method should not call `super`.
  ///
  /// If you want to perform any additional initialization of your views, do so in the ``viewDidLoad()`` method.
  public func loadView() {
    self.view = UIView(frame: UIScreen.main.bounds)
    self.viewDidLoad()
  }

  /// Called after the controller's view is loaded into memory.
  ///
  /// This method is called after the view controller has loaded its view hierarchy into memory. You usually override this method to perform additional initialization on views.
  public func viewDidLoad() {}

  /// Loads the view controller's view if it's not loaded yet.
  public func loadViewIfNeeded() {
    if !self.isViewLoaded {
      self.loadView()
    }
  }

  /// Adds the specified view controller as a child of the current view controller.
  ///
  /// This method creates a parent-child relationship between the current view controller and the object in the `childController` parameter. This relationship is necessary when embedding the child
  /// view controller's view into the current view controller's content. If the new child view controller is already the child of a container view controller, it is removed from that container before
  /// being added.
  ///
  /// This method is only intended to be called by an implementation of a custom container view controller. If you override this method, you must call `super` in your implementation.
  ///
  /// - Parameter childController: The view controller to be added as a child.
  public func addChild(_ childController: UIViewController) {
    if childController.parent != nil {
      childController.removeFromParent()
    }

    self.children.append(childController)
    childController.parent = self
  }

  /// Removes the view controller from its parent.
  ///
  /// This method is only intended to be called by an implementation of a custom container view controller. If you override this method, you must call `super` in your implementation.
  public func removeFromParent() {
    guard self.parent != nil else {
      return
    }

    self.parent?.children.removeAll(where: { $0 === self })
    self.parent = nil
  }
}

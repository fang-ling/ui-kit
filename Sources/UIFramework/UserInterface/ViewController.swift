//
//  ViewController.swift
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

import FoundationFramework

/// An object that manages a view hierarchy for your app.
///
/// The ``ViewController`` class defines the shared behavior that's common to
/// all view controllers. You rarely create instances of the ``ViewController``
/// class directly. Instead, you subclass ``ViewController`` and add the methods
/// and properties needed to manage the view controller's view hierarchy.
///
/// A view controller's main responsibilities include the following:
///   - Updating the contents of the views, usually in response to changes to
///     the underlying data
///   - Responding to user interactions with views
///   - Resizing views and managing the layout of the overall interface
///   - Coordinating with other objects — including other view controllers — in
///     your app
///
/// A view controller is tightly bound to the views it manages and takes part in
/// handling events in its view hierarchy. Specifically, view controllers are
/// ``Responder`` objects and are inserted into the responder chain between the
/// view controller's root view and that view's superview, which typically
/// belongs to a different view controller. If none of the view controller's
/// views handle an event, the view controller has the option of handling the
/// event or passing it along to the superview.
///
/// View controllers are rarely used in isolation. Instead, you often use
/// multiple view controllers, each of which owns a portion of your app's user
/// interface. For example, one view controller might display a table of items
/// while a different view controller displays the selected item from that
/// table. Usually, only the views from one view controller are visible at a
/// time. A view controller may present a different view controller to display a
/// new set of views, or it may act as a container for other view controllers'
/// content and animate views however it wants.
///
/// ### Subclassing notes
///
/// Every app contains at least one custom subclass of ``ViewController``. More
/// often, apps contain many custom view controllers. Custom view controllers
/// define the overall behaviors of your app, including the app's appearance and
/// how it responds to user interactions. The following sections provide a brief
/// overview of some of the tasks your custom subclass performs.
///
/// #### Manage views
///
/// Each view controller manages a view hierarchy, the root view of which is
/// stored in the view property of this class. The root view acts primarily as a
/// container for the rest of the view hierarchy. The size and position of the
/// root view is determined by the object that owns it, which is either a parent
/// view controller or the app's window. The view controller that's owned by the
/// window is the app's root view controller and its view is sized to fill the
/// window.
///
/// View controllers load their views lazily. Accessing the view property for
/// the first time loads or creates the view controller's views. You can specify
/// the views for a view controller using the ``loadView()`` method. In this
/// method, create your view hierarchy programmatically and assign the root view
/// of that hierarchy to the view controller's view property.
///
/// > Important: A view controller is the sole owner of its view and any
///   subviews it creates. It's responsible for creating those views and for
///   relinquishing ownership of them at the appropriate times such as when the
///   view controller itself is released. Each view controller must have its own
///   unique set of views. You can't share views between view controllers.
///
/// A view controller's root view is always sized to fit its assigned space. For
/// other views in your view hierarchy, create constraints programmatically and
/// add them to your views at appropriate times.
///
/// #### Handle view-related notifications
///
/// When the visibility of its views changes, a view controller automatically
/// calls its own methods so that subclasses can respond to the change. Use a
/// method like ``viewIsAppearing(_:)`` to prepare your views to appear
/// onscreen, and use ``viewWillDisappear(_:)`` to save changes or other state
/// information. Use other methods to make appropriate changes.
///
/// The following figure shows the possible visible states for a view
/// controller's views and the state transitions that can occur. Not all `will`
/// callback methods are paired with only a `did` callback method. You need to
/// ensure that if you start a process in a `will` callback method, you end the
/// process in both the corresponding `did` and the opposite `will` callback
/// method.
///
/// ```
///                                               ┌─ viewWillAppear
///                                               │  ┌ View added
///            ViewDidDisappear   ┌─────────────┐ ↓  ↓
///        ┌──────────█──────────>│ Disappeared ├─█──█──────────────────┐
///        │                      └─────────────┘                       │
///        █ View removed                               ViewIsAppearing █
///        │                                                            ↓
/// ┌──────┴───────┐                                              ┌───────────┐
/// │ Disappearing │                                              │ Appearing │
/// └──────────────┘                                              └─────┬─────┘
///        ↑                                                            │
///        │                                                            │
///        │   viewWillDisappear   ┌──────────┐       viewDidAppear     │
///        └──────────█────────────┤ Appeared │<────────────█───────────┘
///                                └──────────┘
///
/// ```
///
/// #### Handle view rotations
///
/// View rotations are treated as a change in the size of the view controller's
/// view and are therefore reported using the ``viewWillTransition(to:with:)``
/// method. When the interface orientation changes, system calls this method on
/// the window's root view controller. That view controller then notifies its
/// child view controllers, propagating the message throughout the view
/// controller hierarchy.
///
/// #### Implement a container view controller
///
/// A custom ``ViewController`` subclass can also act as a container view
/// controller. A container view controller manages the presentation of content
/// of other view controllers it owns, also known as its child view controllers.
/// A child's view can be presented as-is or in conjunction with views owned by
/// the container view controller.
///
/// Your container view controller subclass should declare a public interface to
/// associate its children. The nature of these methods is up to you and depends
/// on the semantics of the container you're creating. You need to decide how
/// many children can be displayed by your view controller at once, when those
/// children are displayed, and where they appear in your view controller's view
/// hierarchy. Your view controller class defines what relationships, if any,
/// are shared by the children. By establishing a clean public interface for
/// your container, you ensure that children use its capabilities logically,
/// without accessing too many private details about how your container
/// implements the behavior.
///
/// Your container view controller must associate a child view controller with
/// itself before adding the child's root view to the view hierarchy. This
/// allows system to properly route events to child view controllers and the
/// views those controllers manage. Likewise, after it removes a child's root
/// view from its view hierarchy, it should disconnect that child view
/// controller from itself. To make or break these associations, your container
/// calls specific methods defined by the base class. These methods aren't
/// intended to be called by clients of your container class; they are to be
/// used only by your container's implementation to provide the expected
/// containment behavior.
///
/// Here are the essential methods you might need to call:
///   - ``addChild(_:)``
///   - ``removeFromParent()``
///   - ``willMove(toParent:)``
///   - ``didMove(toParent:)``
@available(macOS 13.3.0, *)
@MainActor open class ViewController: Responder {
  private var _view: View?

  /// The view that the controller manages.
  ///
  /// This property represents the root view of the view controller's view
  /// hierarchy. The default value of this property is `nil`.
  ///
  /// If you access this property when its value is nil, the view controller
  /// automatically calls the ``loadView()`` method and returns the resulting
  /// view.
  ///
  /// Each view controller is the sole owner of its view object. Don't associate
  /// the same view object with multiple view controllers. The only exception is
  /// that a container view controller implementation may add another view
  /// controller's view object to its own view hierarchy. Before adding the
  /// subview, the container must first call its ``addChild(_:)`` method to
  /// create a parent-child relationship between the two view controller
  /// objects.
  ///
  /// Because accessing this property can cause the view to be loaded
  /// automatically, you can use ``isViewLoaded`` to determine if the view is
  /// currently in memory. Unlike this property, ``isViewLoaded`` doesn't force
  /// the loading of the view if it's not currently in memory.
  var view: View! {
    get {
      if _view == nil {
        loadView()
      }

      return _view
    }
    set {
      _view?.next = _view?.superview
      _view = newValue
      _view?.next = self
      next = _view?.superview
    }
  }

  /// A Boolean value indicating whether the view is currently loaded into
  /// memory.
  var isViewLoaded: BinaryLogic {
    return _view != nil
  }

  public override init() { }

  /// Creates the view that the controller manages.
  ///
  /// You should never call this method directly. The view controller calls this
  /// method when its view property is requested but is currently `nil`. This
  /// method loads or creates a view and assigns it to the view property.
  ///
  /// This method creates and loads a plain ``View`` object.
  ///
  /// You can override this method in order to create your views manually. If
  /// you choose to do so, assign the root view of your view hierarchy to the
  /// view property. The views you create should be unique instances and should
  /// not be shared with any other view controller object. Your custom
  /// implementation of this method should not call super.
  ///
  /// If you want to perform any additional initialization of your views, do so
  /// in the ``viewDidLoad()`` method.
  func loadView() {
    view = View(frame: Screen.main.bounds)
    viewDidLoad()
  }

  /// Called after the controller's view is loaded into memory.
  ///
  /// This method is called after the view controller has loaded its view
  /// hierarchy into memory. You usually override this method to perform
  /// additional initialization on views.
  open func viewDidLoad() { }
}

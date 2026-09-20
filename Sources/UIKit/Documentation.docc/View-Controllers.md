# View Controllers

Manage your interface using view controllers and facilitate navigation around your app's content.

## Overview

You use view controllers to manage your UIKit app's interface. A view controller manages a single root view, which may itself contain any number of subviews. User interactions with that view hierarchy
are handled by your view controller, which coordinates with other objects of your app as needed. Every app has at least one view controller whose content fills the main window. If your app has more
content than can fit on-screen at once, use multiple view controllers to manage different parts of that content.

A _container view controller_ embeds the content of other view controllers into its own root view. A container view controller may mix custom views with the contents of its contained view controllers
to facilitate navigation or to create unique interfaces. For example, a ``UIKit/UINavigationController`` object manages a navigation bar and a stack of view controllers (only one of which is visible
at a time), and provides an API to add and remove view controllers from the stack.

UIKit provides several standard view controllers for navigation and managing specific types of content. You define the view controllers containing your app's custom content. You may also define custom
container view controllers to implement new navigation schemes.

## Topics

### Content View Controllers

- ``UIKit/UIViewController``

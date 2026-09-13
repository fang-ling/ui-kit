# Views and Controls

Present your content onscreen and define the interactions allowed with that content.

## Overview

Views and controls are the visual building blocks of your app's user interface. Use them to draw and organize your app's content onscreen.

Views can host other views. Embedding one view inside another creates a containment relationship between the host view (known as the _superview_) and the embedded view (known as the _subview_). View
hierarchies make it easier to manage views.

You can also use views to do any of the following:

  - Respond to touches and other events (either directly or in coordination with gesture recognizers).
  - Draw custom content using CoreGraphicsKit or UIKit classes.
  - Support drag and drop interactions.
  - Respond to focus changes.
  - Animate the size, position, and appearance attributes of the view.

``UIKit/UIView`` is the root class for all views and defines their common behavior. ``UIKit/UIControl`` defines additional behaviors that are specific to buttons, switches, and other views designed
for user interactions.

## Topics

### View Fundamentals

- ``UIKit/UIView``

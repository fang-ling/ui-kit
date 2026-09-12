# ``UIKit``

Construct and manage a graphical, event-driven user interface for your WebAssembly app.

## Overview

`UIKit` provides a variety of features for building apps, including components you can use to construct the core infrastructure of your WebAssembly apps. The framework provides the window and view
architecture for implementing your UI, the event-handling infrastructure for delivering Multi-Touch and other types of input to your app, and the main run loop for managing interactions between the
user, the system, and your app.

`UIKit` also includes support for animations, documents, drawing and printing, text management and display, search, app extensions, resource management, and getting information about the current
device. You can also customize accessibility support, and localize your app's interface for different languages, countries, or cultural regions.

> Importang: Use UIKit classes only from your app's main thread or main dispatch queue, unless otherwise indicated in the documentation for those classes. This restriction particularly applies to
  classes that derive from ``UIResponder`` or that involve manipulating your app's user interface in any way.

## Topics

### User Interface

- <doc:Windows-and-Screens>

### User Interactions

- <doc:Touches-Presses-and-Gestures>

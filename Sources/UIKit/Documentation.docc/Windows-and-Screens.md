# Windows and Screens

Provide a container for your view hierarchies and other content.

## Overview

Window objects act as containers for your app's onscreen content, and screens report the characteristics of the underlying display to your app. Use ``Scenes`` to configure and manage your user
interface, and review ``UIKit/UIScreen`` objects to understand the device's main screen or connected displays.

A ``UIKit/UIWindow`` object provides no visible content of its own. All of the window's visible content is provided by its root view controller, which you configure in your app's storyboards. The
window's role is to receive events from UIKit and to forward any relevant events to the root view controller and associated views. UIKit provides an initial window for you to use, and you can create
additional windows as needed.

## Topics

### Windows

- ``UIKit/UIWindow``

### Screens

- ``UIKit/UIScreen``

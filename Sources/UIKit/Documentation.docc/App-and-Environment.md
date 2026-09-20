# App and Environment

Manage life-cycle events and your app's UI scenes, and get information about traits and the environment in which your app runs.

## Overview

From the moment a person opens your app, a number of things can happen that your app may need to handle or adjust to, such as switching to another app, receiving a call, switching Dark Mode on or off, 
or rotating the device. UIKit communicates some changes as life cycle events, and others as trait changes.

Your app displays its interface in one or more scenes. A person can create and manage multiple instances of your app's user interface simultaneously, in different windows or side by side. Each
instance of your UI displays different content, or displays the same content in a different way. For example, a person can display one instance of the Calendar app showing a specific day, and another 
showing an entire month.

UIKit communicates details about the current environment using trait collections, which reflect a combination of device settings, interface settings, and user preferences. For example, you use traits 
to detect whether Dark Mode is active for the current view or view controller.

## Topics

### Life Cycle

- ``UIKit/UIApplication``
- ``UIKit/UIApplicationDelegate``

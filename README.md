SDJSBridge
==========

Native/Hybrid Javascript Bridge

## JSBridgeAPI.platform

### JSBridgeAPI.platform.navigation

API for working with the navigation object.

**Methods**

- `pushUrl(url, title)` - Push a new web view on to the navigation stack.
- `popUrl()` - Pop the current web view off of the navigation stack.
- `presentModalUrl(url, title)` - Present modal web view.
- `dismissModalUrl()` - Dismiss the currently displayed modal web view.

**Examples**

Pushing a web view on to the navigation stack

```
var navigation = JSBridgeAPI.platform.navigation;
navigation.pushUrl("http://www.google.com/", "Google");
```

Popping a web view off of the navigation stack

```
var navigation = JSBridgeAPI.platform.navigation;
navigation.popUrl();
```

Presenting a modal web view.

```
var navigation = JSBridgeAPI.platform.navigation;
navigation.presentModalUrl("http://www.google.com/", "Google");
```

Dismissing a modal web view.

```
var navigation = JSBridgeAPI.platform.navigation;
navigation.dismissModalUrl();
```

### JSBridgeAPI.platform.navigation.NavigationItem

API for creating navigation items to add to the navigation bar.

**Methods**

- `NavigationItem(title, imageName, callback)` - Returns a new instance of a navigation item object. 

**Properties**

- `title` - Text to use for bar button item
- `imageName` - Name of image to be loaded from app bundle to be used as button image.
- `callback` - Function to call when nav item is tapped.

**Examples**

Creating a navigation item button with a title.

```
var navigation = JSBridgeAPI.platform.navigation;

var cancelButton = navigation.NavigationItem("Cancel", null, function () {
  navigation.dismissModalUrl();
});

```

Creating a navigation item button with an image.

```
var navigation = JSBridgeAPI.platform.navigation;

var infoButton = navigation.NavigationItem(null, "info-icon", function () {
  navigation.presentModalUrl("/info", "Info");
});

```

### JSBridgeAPI.platform.navigation.navigationBar

Returns the instance of the web view's navigation bar.

**Properties**

- `leftItems` - Get/set left navigation bar items.
- `rightItems` - Get/set right navigation bar items.

**Examples**

Adding navigation items to the navigation bar.

```
var navigation = JSBridgeAPI.platform.navigation;

var cancelButton = navigation.NavigationItem("Cancel", null, function () {
  navigation.dismissModalUrl();
});

navigation.navigationBar.leftItems = [cancelButton];
```

Removing items from the navigation bar.

```
var navigation = JSBridgeAPI.platform.navigation;

// remove item at the first index
var leftItems = navigation.navigationBar.leftItems.splice(0, 1);
navigation.navigationBar.letItems = leftItems;
```

### JSBridgeAPI.platform.alert

API for displaying alerts.

**Methods**

- `alert(title, message, actions)` - Displays an alert.

**Examples**

Displaying an alert.

```
var platform = JSBridgeAPI.platform;

// null actions default to OK action
platform.alert("Error", "An error occured while logging in", null);
```

### JSBridgeAPI.platform.AlertAction

API for creating alert actions.

**Methods**

- `AlertAction(title, callback)` - Returns a new instance of an alert action object.

**Properties**

- `title` - Title text for alert action.
- `callback` - Function to call when alert action is tapped.

**Examples**

Adding buttons with actions to alerts.

```
var platform = JSBridgeAPI.platform;

var okAction = platform.AlertAction("OK", function () {
  // ok button was tapped
});

var cancelAction = platform.AlertAction("Cancel", function () {
  // cancel button was tapped
});

var alertActions = [okAction, cancelAction];

platform.alert("Receipt Not Found", "Are you sure you want to proceed?", alertActions);
```

### JSBridgeAPI.platform.progress

API for hiding and showing the progress HUD.

**Methods**

- `show(message)` - Show the progress HUD.
- `hide()` - Hide the current progress HUD.

**Properties**

- `message` - Message text displayed in the progress.

**Examples**

Showing a progress HUD.

```
JSBridgeAPI.platform.progress.show("One moment please...");
```

Hiding a progress HUD.

```
JSBridgeAPI.platform.progress.hide();
```

### JSBridgeAPI.platform.share

API for sharing a URL and message using the native share sheet.


**Methods**

- `share(url, message, callback)` - Present a share sheet with a URL and message.

**Examples**

```
var url = "http://www.walmart.com/";
var message = "Check out this great deal!"
JSBridgeAPI.platform.share(url, message, function () {
    // share complete
});
```

### JSBridgeAPI.platform.ShareService

API for configuring the share services shown when using the native share sheet. By default all available services are shown. API accepts array of share service constants to exclude.

**Services**

- `ShareService.Mail` - Share with mail app service type
- `ShareService.Message` - Share with messages app service type
- `ShareService.Facebook` - Share with Facebook service type
- `ShareService.Twitter` - Share with Twitter service type

**Examples**

Showing a share sheet that excludes the Facebook and Mail options.

```
var ShareService = JSBridgeAPI.platform.ShareService;
var excludedServices = [ShareService.Facebook, ShareService.Mail];
JSBridgeAPI.platform.share(url, message, excludedServices, function () {
    // share complete
});
```
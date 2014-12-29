SDJSBridge
==========

Native/Hybrid Javascript Bridge

## Documentation

See the [documentation](http://setdirection.github.io/SDJSBridge).

## JavaScript API

### alert

Displays an alert with optional ok, cancel and neutral buttons.

**Input**

- `title` (string) - Title of alert view.
- `message` (string) - Message of alert view.
- `okButton` (string) - Title text of OK button.
- `cancelButton` (string) - Title text of Cancel button.
- `neutralButton` (string) - Title text of neutral button.

**Output**

- `action` (string)  - Value indicates the button that was pressed: “ok”, “cancel”, “neutral”.

**Example**

```
var options = {
    title: "hey!",
    message: "listen!",
    okButton: "OKAY",
    cancelButton: "CANCEL",
    neutralButton: "hmm..."
};

JSBridgeAPI.alert(options, function (action) {

});
```

### showLoadingIndicator

Show progress HUD.

**Input**

- `message` (string) - Message of progress HUD.

**Output**

No Callback.

**Example**

```
var options = {
    message: 'Loading...'
};

JSBridgeAPI.showLoadingIndicator(options);
```

### hideLoadingIndicator

Hide progress HUD.

**Input**

Null.

**Output**

No Callback.

### pushState

Push a new stack on to the navigation stack.

**Input**

- `title` (string) - Title view of view controller.
- `url` (string) - URL to push.
- `backTitle` (string) - Title of back button.

**Output**

No Callback.

**Example**

```
var options = {
  title: 'title page',
  url: 'example1.html'
};

JSBridgeAPI.pushState(options);
```

### replaceState

Replace current state on top of navigation stack.

**Input**

- `title` (string) - Title view of view controller.
- `url` (string) - URL to load.
- `backTitle` (string) - Title of back button.

**Output**

No Callback.

**Example**

var options = {
  title: 'title page',
  url: 'example2.html'
};

JSBridgeAPI.replaceState(options);


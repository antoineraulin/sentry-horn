# Sentry Horn
Swift based getsentry/sentry ios client, now you can care about your server's error logging and aggregation over the mobile.

<img src="http://7xrnog.com1.z0.glb.clouddn.com/login.png" width="140" />
<img src="http://7xrnog.com1.z0.glb.clouddn.com/dash.png" width="140" />
<img src="http://7xrnog.com1.z0.glb.clouddn.com/project.png" width="140" />
<img src="http://7xrnog.com1.z0.glb.clouddn.com/event.png" width="140" />
<img src="http://7xrnog.com1.z0.glb.clouddn.com/stats.png" width="140" />
<img src="http://7xrnog.com1.z0.glb.clouddn.com/settings.png" width="140" />

## About Sentry
[Sentry](https://github.com/getsentry/sentry) is a modern error logging and aggregation platform.

## Feature List
* Configure your own sentry server host and organization.
* Login to your own sentry server.
* Never miss any Assigned and New issues with Dashboard.
* All projects and teams listed.
* Track issues in a project and see more detail.

## How to use
Simply replace the defaults with your own sentry server host and organization in Constants.swift
```swift
// Default Organization
static var CurrentOrganization = "YOUR_Organization"

// Default Host
static let Host = "YOUR_SENTRY_HOST"
```
## Sentry Version
As far as I know it worked well with Sentry 8.0+, but it may compatible with lower version, so if anyone find that please let me know, thank you! 

## Contribute
Is just the beginning of Horn, so anyone interested, feel free to fork it and pull requests to me. Let's make it more fun.

## Author
Thierry Xing thierry.xing@gmail.com


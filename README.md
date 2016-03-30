# Sentry Horn
Swift based getsentry/sentry ios client, now you can care about your server's error logging and aggregation over the mobile.

<img src="http://7xjlg5.com1.z0.glb.clouddn.com/1.png" width="140" />
<img src="http://7xjlg5.com1.z0.glb.clouddn.com/2.png" width="140" />
<img src="http://7xjlg5.com1.z0.glb.clouddn.com/3.png" width="140" />
<img src="http://7xjlg5.com1.z0.glb.clouddn.com/4.png" width="140" />
<img src="http://7xjlg5.com1.z0.glb.clouddn.com/8.png" width="140" />
<img src="http://7xjlg5.com1.z0.glb.clouddn.com/7.png" width="140" />

## About Sentry
[Sentry](https://github.com/getsentry/sentry) is a modern error logging and aggregation platform.

## About The Project
* Using Swift on MVVM without ReactiveCocoa.
* Using container and component rather than inheritation.

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
static var CurrentOrganization = "YOUR_ORGANIZATION"

// Default Host
static let Host = "YOUR_SENTRY_HOST"
```
## Sentry Version
As far as I know it worked well with Sentry 8.0+, but it may compatible with lower version, so if anyone find that please let me know, thank you! 

## Contribute
Is just the beginning of Horn, so anyone interested, feel free to fork it and pull requests to me. Let's make it more fun.

## Author
Thierry Xing thierry.xing@gmail.com


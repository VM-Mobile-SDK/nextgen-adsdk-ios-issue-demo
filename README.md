# Demo app for reproducing issues related to iOS Nextgen AdSDK

This repository includes a demo application that you can use as a starting point to reproduce your issues.

## Features

The application includes already implemented functionality:
* Displaying inline ads in the list.
* Displaying interstitial ad.
* User tagging request.
* Conversion tracking request.

If your issue occurs when using a different functionality, you can modify this project to make it suitable for your testing.

## Configuration

The project has a configuration file `Core/Configuration.swift` that you can modify to quickly check the functionality.

You can quickly configure the following values:
* `Configuration.networkID` – id of your network.
* `Configuration.cacheSize` – size in mb that you can set for max SDK's persistent cache size.
* `Configuration.isSDKLoggingEnabled` – enables or disables SDK logging. It can be useful if you want to check the communication between the app and the ad server.
* `Configuration.Ad.isPreloadingContent` – a boolean value that you can use to enable or disable ad preloading. If the value is `false`, the ad will be loaded and reloaded during the scroll, in case of inline ads. In the case of interstitial ads, you will need to load the ad before it is displayed.
* `Configuration.Ad.inlineRequests` – objects that describe requests for inline ads that will be displayed in the list.
* `Configuration.Ad.interstitialRequest` – object that describe request for the full screen interstitial ad.
* `Configuration.Ad.globalParameters` – global parameters that will be added to all ad requests.
* `Configuration.Tracking.tagRequest` – object that describe request for the user tagging.
* `Configuration.Tracking.trackingRequest` – object that describe request for the conversion tracking.
* `Configuration.Tracking.globalParameters` – global parameters that will be added to all tagging or tracking requests.

If your problem occurs when using other settings, you can modify this project to make it suitable for your testing.

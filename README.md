##AdGate Rewards iOS SDK by AdGate Media
### Introduction
Thank you for choosing AdGate Media to monitize your iOS app! We look forward to working with you and your users in a way that is beneficial to everyone involved. If you haven't done so already, please sign up for an affiliate account at http://www.adgatemedia.com.

Our SDK will allow you to easily present an offer wall in your native iOS app. To display it, please follow these 3 steps:

1. [Install the SDK](#1-install-sdk)
2. [Display the offer wall](#2-Display-the-offer-wall)
3. [Check our Demo app for an example](#3-demo-app)

###Requirements

- iOS version 6.0 onwards

###1. Install SDK

> Instructions are according to the lastest version of Xcode and iOS sdk

1. Download the zip file from [here](https://70a4f2c223ea18c6955a-f91ceedaff225bee61d94aff812c7b48.ssl.cf5.rackcdn.com/AdGateMediaiOSSDK.framework.tar.gz)
2. Drag the AdGateMediaiOSSDK.framework file into your project's Frameworks binder.
3. Select the "Build Phases" tab from your project settings and make sure Foundation.framework is included in the "Link Binary With Libraries" section.

In order to get started you are required to add the following header file to either your project's .pch file or at the location you are displaying the offer wall:

```java

#import <AdGateMediaiOSSDK/AdGateMediaiOSSDK.h>

```
###2. Display the offer wall

Add the following simple lines to the code from where you want to launch the offer wall:

```java

    AdGateMedia *media = [[AdGateMedia alloc] initWith:wallCode and:userName withParent:self];
    [media showOfferWall];

```

Set the wallCode and userName to the appropriate values. You may get the your wall code from the [Dashboard](https://panel.adgatemedia.com/affiliate/vc-walls).

###3. Demo app

This repository contains a demo iOS app that shows how to implement our SDK.
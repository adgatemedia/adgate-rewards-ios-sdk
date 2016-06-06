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

1. Download the zip file from the downloads directory
2. Go to Build Settings/Search Paths/Header Search Paths and add $SOURCE_ROOT/include; Build Settings/Linking/Other Linker Flags - add -ObjC.
3. Add libAdGateMedia.a and include folder to your project.
4. Add the library to “Link Binary With Libraries” and make sure AdGateMediaiOSSDK.bundle is added in “Copy Bundle Resources”.

In order to get started you are required to add the following header file to either your project's .pch file or at the location you are displaying the offer wall:

```java

#import <AdGateMediaiOSSDK/AdGateMediaiOSSDK.h>

```
###2. Display the offer wall

Add the following simple lines to the code from where you want to launch the offer wall:

```java
    	
    NSDictionary *parameter = @{
		@"s2" : @"Value s2",
	        @"s3" : @"Value s3",
	        @"s4" : @"Value s4",
	        @"s5" : @"Value s5",
    	};

    AdGateMedia *media = [[AdGateMedia alloc] initWith:wallCode and:userName withParent:self];
    [media showOfferWallWithParams:parameter];

```

Set the wallCode and userName to the appropriate values. You may get the your wall code from the [Dashboard](https://panel.adgatemedia.com/affiliate/vc-walls).

You can pass subids while loading the offer wall, specifically, s2, s3, s4 and s5.

###3. Demo app

This repository contains a demo iOS app that shows how to implement our SDK.

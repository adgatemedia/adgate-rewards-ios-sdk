
# AdGate Rewards iOS SDK by AdGate Media
### Introduction
Thank you for choosing AdGate Media to monetize your iOS app! We look forward to working with you and your users in a way that is beneficial to everyone involved. If you haven't done so already, please sign up for an affiliate account at http://www.adgatemedia.com.

Our SDK will allow you to easily present an offer wall in your native iOS app, as well as display native video ads.

1.    Install the SDK.
2.    Load & Display the Offer wall.
3.    Get a list of the latest offer wall conversions.
4.    Load and display video ads.
5.    Debug mode.
6.    Demo App.

Requirements:

•    iOS version 7.0 or higher

# 1. Install SDK
1.    Download the zip file from the [Releases](https://github.com/adgatemedia/adgate-rewards-ios-sdk/releases) page
2.    Go to Build Settings/Search Paths/Header Search Paths and add $SOURCE_ROOT/include; Build Settings/Linking/Other Linker Flags - add -ObjC.
3.    Add libAdGateMedia.a and include folder to your project.
4.    Add the library to “Link Binary With Libraries” and make sure AdGateMediaiOSSDK.bundle is added in “Copy Bundle Resources”.

In order to get started you are required to add the following header file to either your project's .pch file or at the location you are displaying the offer wall:

```obj-c
#import "AdGateMediaiOSSDK.h"
#import "ADMAdGateVideo.h"
#import "AdGateMedia.h"
```
# 2. Load & Display the Offer wall
Add the following lines of code where you want to launch the offer wall:

```obj-c
    AdGateMedia *media = [AdGateMedia alloc] initWithRewardCode:rewardCode userId:userName parentViewController:self];
    NSDictionary *parameter = @{
        @"s2" : @"Value s2",
        @"s3" : @"Value s3",
        @"s4" : @"Value s4",
        @"s5" : @"Value s5",
    };

    [media loadOfferWall: parameter onOfferWallLoadSuccess:^{
        [media showOfferWall:^{
        NSLog(@“Closed wall”);
    }];
    } onOfferWallLoadFailed:^(NSError *error){
        NSLog(@“Failed to load wall”);
    }];
```



To change the offer wall code and user name, use the following code:

```obj-c
    @property (nonatomic, strong) AdGateMedia *media;

    if (self.media == nil)
    {
        self.media = [[AdGateMedia alloc]initWithRewardCode:rewardCode userId:userName     parentViewController:self];
    } else{
        self.media.strRewardCode = rewardCode;
        self.media.strUserId = userName;
    }

    NSDictionary *parameter = @{
        @"s2" : @"Value s2",
        @"s3" : @"Value s3",
        @"s4" : @"Value s4",
        @"s5" : @"Value s5",
    };

    [media loadOfferWall: parameter onOfferWallLoadSuccess:^{
    [media showOfferWall:^{
        NSLog(@“Closed wall”);
    }];
    } onOfferWallLoadFailed:^(NSError *error){
        NSLog(@“Failed to load wall”);
    }];
```

Set the rewardCode and userName to the appropriate values. You may get the your wall code from [this page](https://panel.adgatemedia.com/affiliate/vc-walls) on the affiliate dashboard.

1. You can pass subids while loading the offer wall, specifically, s2, s3, s4 and s5.
2. Once the offer wall is loaded you can display it using the `showOfferWall` method. User can see it called in the above code after the wall is successful loaded.


```obj-c
    [media showOfferWall:^{
        NSLog(@“Closed wall”);
    }];
```


# 3. Get a list of the latest offer wall conversions
To get the list of the latest offer wall conversions, use the `getConversions` method. Add the following lines of code in your class (i.e ViewController)

```obj-c
    AdGateMedia *media = [AdGateMedia alloc]initWithRewardCode:rewardCode userId:userName     parentViewController:self];

    NSDictionary *parameter = @{
        @"s2" : @"Value s2",
        @"s3" : @"Value s3",
        @"s4" : @"Value s4",
        @"s5" : @"Value s5",
    };

    [media getConversions:parameter rewardCode:rewardCode userId:userName     completionHandler:^(NSArray *offers, NSError *error) {
    if (!error) {
            [[[UIAlertView alloc] initWithTitle:@"Conversions List" message:[NSString stringWithFormat:@"%@",offers] delegate:nil cancelButtonTitle:@"OK"                                     otherButtonTitles:nil, nil] show];
    }else{
        NSString *strMessage = @"";

        if ([error isKindOfClass:[NSDictionary class]]) {
            if ([error valueForKey:@"message"] != nil) {
                strMessage = [error valueForKey:@"message"];
            }
        }

        [[[UIAlertView alloc] initWithTitle:@"Conversions List" message:[NSString stringWithFormat:@"%@",strMessage] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];

    }
    NSLog(@"offers: %@",offers);
    }];
```

# 4. Load and display video ads.
The first step of showing a video is to load it in the background. To load a video ad use the following:

```obj-c
    NSDictionary * subids = @{
        @"s2" : @"Value s2",
        @"s3" : @"Value s3",
        @"s4" : @"Value s4",
        @"s5" : @"Value s5",
    };

    ADMAdGateVideo *video = [ [ADMAdGateVideo alloc] init];

    [video loadVideo: videoCode userId: userName subIds: subids onVideoLoadSuccess:^{
        NSLog(@"video downloaded");
        [video showVideo:self showCrossButtonAfterDelay:0 onVideoWatchedAndClosed:^{
            NSLog(@"Closed video");
            video.strVideoUDID = nil;
            video = nil;
            [self deleteVideosFromFolder];
    } onUserLeftApplication:^{
        NSLog(@"Here user leaves your app and goes to App Store Page");
        video = nil;
    } onUserClickCloseWithoutWatching:^{
        video = nil;
        [self deleteVideosFromFolder];
    }];
    } onVideoLoadFailed:^(NSError *error) {
        video.strVideoUDID = nil;
        video = nil;
        NSLog(@"failed to download");
    }];
```

- To load the videos, the parameters `userName`, `subids`, `onVideoLoadFailed` and `onVideoLoadSuccess` can be null. You may pass up to 4 sub IDs, s2-s5.
- You can get the `videoCode` value from the [Videos](https://panel.adgatemedia.com/affiliate/video) page.
The response contains video information, including Url’s for different quality videos.
- The `showVideo`  method on the ad instance can be called only when the video is ready.
- The `showCrossButtonAfterDelay` parameter is used to determine when to display the X close button in milliseconds. The video cannot be closed before this button displays. Use 0 to display it immediately. Use -1 to disable closing the video before it finishes playing.

When video finishes, a full screen end page opens that contains information about the app that was advertised. It contains a link to the App Store and a close button.

- If the video is closed early while the video is playing, the `onVideoClosed` callback won’t be called. Instead `onUserClickCloseWithoutWatching` will be called.
- When the end page is closed, the `onVideoClosed` callback is called, indicating the video was watched to the end.
- When the user leaves the app to go to the app store, the `onLeftApplication` callback is called.
- deleteVideosFromFolder method removes/deleted videos from :@"/AdGateVideo/" folder that stores videos downloaded ealier.


# 5. Debug mode:

Step 1: Select the Edit Scheme from XCode where you set your active scheme.


Step 2: Goto Run -> Info -> Build Configuration -> Debug option -> Close.


Note:  Use NSLog to print result after selecting the Debug build configuration. NSLog is used to print the value in the console for debug mode.

# 6. Demo App.

This repository contains a demo iOS app that shows how to implement our SDK.



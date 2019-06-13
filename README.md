
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

•    iOS version 8.0 or higher

# 1. Install SDK

## Installation with CocoaPods

1.    To install via CocoaPods, simply add the following line to your Podfile:

```ruby
    pod 'AdGateMedia'
```
2.    Run `pod install` to install AdGateMedia dependency.

## Installation with Framework (.framework) 

1.    Download the **AdGateMedia_UniversalFramework.zip** file from the [Releases](https://github.com/adgatemedia/adgate-rewards-ios-sdk/releases) page. Drag and drop `AdGateMedia.framework` and  `AdGateMedia.bundle` into your project. (Note that when you would like to upload your app to app store you must use device only version which is **AdGateMedia_DeviceFramework.zip** otherwise your app will be rejected [Radar](http://www.openradar.me/radar?id=6409498411401216))
2.    Go to **General/Linked Frameworks and Libraries** and add `AVFoundation.framework`, `AdSupport.framework` `CoreMedia.framework`, and `WebKit.framework`.
3.    Go to **Build Settings/Linking/Other Linker Flags** and add **-ObjC** flag.
4.    Make sure **Build Settings/Search Paths/Framework Search Paths** includes the path of our framework, Otherwise add framework path. For example if your framework exist in your project directory then you could add `$(PROJECT_DIR)` .
5.    Make sure **AdGateMedia.bundle** is added in **Build Phases/Copy Bundle Resources**.

## Installation with Library (.a)

1.    Download the **AdGateMediaLibrary.zip** file from the [Releases](https://github.com/adgatemedia/adgate-rewards-ios-sdk/releases) page. Drag and drop `libAdGateMedia.a`, `AdGateMedia.bundle` and `include` folder into your project. (Note that when you would like to upload your app to app store you must use device only version which is **AdGateMedia_DeviceLibrary.zip** otherwise your app will be rejected [Radar](http://www.openradar.me/radar?id=6409498411401216))
2.    Go to **General/Linked Frameworks and Libraries** and add `AVFoundation.framework`, `AdSupport.framework` `CoreMedia.framework`, and `WebKit.framework`.
4.    Go to **Build Settings/Linking/Other Linker Flags** and add **-ObjC** flag.
5.    Make sure **Build Settings/Search Paths/Library Search Paths** includes the path of our library, otherwise add library path. For example if library exist in project directory then you could add `$(PROJECT_DIR)`.
6.    Make sure **AdGateMedia.bundle** is added in **Build Phases/Copy Bundle Resources**.
7.    Go to **Build Settings/Search Paths/Header Search Paths** and add **$(PROJECT_DIR)/include** or actual directory path where library header file copied.


In order to get started you are required to add the following header file to either your project's .pch file or at the location you are displaying the offer wall:

```obj-c
#import "AdGateMedia.h" //#import <AdGateMedia/AdGateMedia.h> if using framework
```

## Installation in Swift project

Follow all bullet points of installation steps mentioned above and do these additional steps.

1.    Create Bridging header file (If not already created). It's name should be `${YOURPROJ}-Bridging-Header.h` while ${YOURPROJ} is your project name.
2.    If you created bridging header manually then Go to **Build Settings->Swift Compiler - General->Objective-C Bridging Header** and add bridging header manually by specifying `$(PROJECT_DIR)/$(PROJECT_NAME)/$(PROJECT_NAME)-Bridging-Header.h`
2.    In the Bridging header file, import your framework using the standard Objective C import syntax. In our case, it will be
```objc
#import <AdGateMedia/AdGateMedia.h>
```
### Note
- Please note that method names may be little bit shorter when you use this framework inside swift project.
- We have included a demo project written in swift for your convenience.

# 2. Load & Display the Offer wall
Add the following lines of code where you want to launch the offer wall:

```obj-c

@implementation ViewController

-(void)showOfferWall {

    NSString * rewardCode = @"YOUR_REWARD_CODE";
    NSString * userId = @"YOUR_USER_ID";

    AdGateMedia *media = [[AdGateMedia alloc] initWithRewardCode:rewardCode userId:userId parentViewController:self];

    NSDictionary *parameter = @{
        @"s2" : @"Value s2",
        @"s3" : @"Value s3",
        @"s4" : @"Value s4",
        @"s5" : @"Value s5",
        };

    //Below code will show offer wall immediately before loading
    BOOL success = [media loadOfferWall: parameter onOfferWallLoadSuccess:^{
    
        NSLog(@"Successfully loaded wall");

    } OnOfferWallLoadFailed:^(NSError *error){

        NSLog(@"Failed to load wall");

    }];

    if (success) {
    
        [self.adGateMedia showOfferWall:^{
        
            NSLog(@"Closed wall");
            
        }];
    }
}
    
@end
```

To change the offer wall code and user name, use the following code:

```obj-c

@interface ViewController : UIViewController

@property (nonatomic, strong) AdGateMedia *media;

@end


@implementation ViewController

-(void)showOfferWall {

    NSString * rewardCode = @"YOUR_REWARD_CODE";
    NSString * userId = @"YOUR_USER_ID";

    if (self.media == nil)
    {
        self.media = [[AdGateMedia alloc] initWithRewardCode:rewardCode userId:userId parentViewController:self];
    } else {
        self.media.rewardCode = rewardCode;
        self.media.userId = userId;
    }

    NSDictionary *parameter = @{
        @"s2" : @"Value s2",
        @"s3" : @"Value s3",
        @"s4" : @"Value s4",
        @"s5" : @"Value s5",
    };

    //Below code will show offer wall once it's loaded successfully
    [self.media loadOfferWall: parameter onOfferWallLoadSuccess:^{

        [media showOfferWall:^{
        
            NSLog(@"Closed wall");

        }];

    } OnOfferWallLoadFailed:^(NSError *error){
    
        NSLog(@"Failed to load wall");

    }];
}

@end
```

Set the rewardCode and userId to the appropriate values. You may get your wall code from [this page](https://panel.adgatemedia.com/affiliate/vc-walls) on the affiliate dashboard.

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
    
    NSString * rewardCode = @"YOUR_REWARD_CODE";
    NSString * userId = @"YOUR_USER_ID";

    AdGateMedia *media = [[AdGateMedia alloc] initWithRewardCode:rewardCode userId:userId parentViewController:self];

    NSDictionary *parameter = @{
        @"s2" : @"Value s2",
        @"s3" : @"Value s3",
        @"s4" : @"Value s4",
        @"s5" : @"Value s5",
    };

    [media getConversions:parameter rewardCode:rewardCode userId:userId completionHandler:^(NSArray * _Nullable offers, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@",error);
            //Show error
        }else {
            //Show offers
            NSLog(@"offers: %@",offers);
        }
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

    NSString * videoCode = @"YOUR_VIDEO_CODE";
    NSString * userId = @"YOUR_USER_ID";

    ADMAdGateVideo *video = [[ADMAdGateVideo alloc] init];

    [video loadVideo:videoCode userId:userId subIds:dictParameters onVideoLoadSuccess:^{
        NSLog(@"video downloaded");
        [video showVideo:self showCrossButtonAfterDelay:0 onVideoWatchedAndClosed:^{
            NSLog(@"Closed video");
        } onUserLeftApplication:^{
            NSLog(@"Here user leaves your app and goes to App Store Page");
        } onUserClickCloseWithoutWatching:^{
            NSLog(@"Closed Without Watching");
        }];
    } onVideoLoadFailed:^(NSError *error) {
        NSLog(@"failed to download: %@",error);
        //Show error
    }];
```

- To load the videos, the parameters `userId`, `subIds`, `onVideoLoadSuccess` and `onVideoLoadFailed` can be null. You may pass up to 4 sub IDs, s2-s5.
- You can get the `videoCode` value from the [Videos](https://panel.adgatemedia.com/affiliate/video) page.
The response contains video information, including Url’s for different quality videos.
- The `showVideo`  method on the ad instance can be called only when the video is ready.
- The `showCrossButtonAfterDelay` parameter is used to determine when to display the X close button in seconds. The video cannot be closed before this button displays. Use 0 to display it immediately. Use -1 to disable closing the video before it finishes playing.

When video finishes, a full screen end page opens that contains information about the app that was advertised. It contains a link to the App Store and a close button.

- If the video is closed early while the video is playing, the `onVideoWatchedAndClosed` callback won’t be called. Instead `onUserClickCloseWithoutWatching` will be called.
- When the end page is closed, the `onVideoWatchedAndClosed` callback is called, indicating the video was watched to the end.
- When the user leaves the app to go to the app store, the `onUserLeftApplication` callback is called.


# 5. Debug mode:

Step 1: Select the Edit Scheme from XCode where you set your active scheme.


Step 2: Goto Run -> Info -> Build Configuration -> Debug option -> Close.


Note:  Use NSLog to print result after selecting the Debug build configuration. NSLog is used to print the value in the console for debug mode.

# 6. Demo App.

This repository contains a demo iOS app that shows how to implement our SDK.



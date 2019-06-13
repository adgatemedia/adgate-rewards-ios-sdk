//
//  ADMAdGateVideo.h
//  AdGateMedia
//  https://github.com/adgatemedia/adgate-rewards-ios-sdk
//
//  Copyright © 2019 AdGateMedia. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 ADMAdGateVideo is used to load videos and show
 */
@interface ADMAdGateVideo : NSObject

/**
 Delay in seconds to show the close button. If it is 0 then close button will be visible from starting
 */
@property (nonatomic, assign) NSTimeInterval showCrossButtonAfterDelay;

/**
 Video UUID which is to be played.
 */
@property (nullable, nonatomic) NSString *strVideoUDID;

/**
 Load the video
 
 @param videoUDID Video UUID which is to load
 
 @param userId User Id parameter is optional
 
 @param parameter Only s2, s3, s4 and s5 parameters are supported, if you supply other parameters then they will be ignored

 @param successHandler success callback handler when video is loaded successfully
 
 @param failedHandler failure callback handler when video is unable to load due to some issue. an error object is passed with the reason.
 */
- (void)loadVideo:(nonnull NSString *)videoUDID userId:(nullable NSString *)userId subIds:(nonnull NSDictionary<NSString*,id> *)parameter onVideoLoadSuccess:(nullable void (^)(void))successHandler onVideoLoadFailed:(nullable void (^)(NSError * _Nonnull error))failedHandler;

/**
 Show the loaded video
 
 @param parentController ViewController which is to be used to present the internal Video Controller
 
 @param showCrossButtonAfterDelay Delay in seconds to show the close button
 
 @param onVideoWatchedAndClosedHandler callback handler when video is watched and user close
 
 @param leftApplicationHandler callback handler when user leaves the application and goes to App Store Page
 
 @param withoutWatchingHandler callback handler when user close the application without watching the video
 */
- (void)showVideo:(nonnull UIViewController *)parentController showCrossButtonAfterDelay:(NSTimeInterval)showCrossButtonAfterDelay onVideoWatchedAndClosed:(nullable void (^)(void))onVideoWatchedAndClosedHandler onUserLeftApplication:(nullable void (^)(void))leftApplicationHandler onUserClickCloseWithoutWatching:(nullable void (^) (void))withoutWatchingHandler;

- (void)postImpressionForWatchedTime:(NSTimeInterval)watchedTime percentWatched:(NSTimeInterval)percentWatched subIDs:(nonnull NSDictionary<NSString*,id> *)subID;

@end

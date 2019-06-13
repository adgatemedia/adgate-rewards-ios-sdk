//
//  AdGateMedia.h
//  AdGateMedia
//  https://github.com/adgatemedia/adgate-rewards-ios-sdk
//
//  Copyright © 2019 AdGateMedia. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ADMAdGateVideo.h"

/**
 AdGateMedia is used to load and show the offer wall and conversions
 */
@interface AdGateMedia : NSObject

/**
 Reward code object reference supplied on initializing the object of AdGateMedia.
 */
@property (nonnull, nonatomic, strong) NSString *strRewardCode;

/**
 user id object reference supplied on initializing the object of AdGateMedia.
 */
@property (nonnull, nonatomic, strong) NSString *strUserId;

/**
 Please use initWithRewardCode:userId:parentViewController method to create object of AdGateMedia.
 */
-(instancetype _Nonnull )init NS_UNAVAILABLE;

/**
 Please use initWithRewardCode:userId:parentViewController method to create object of AdGateMedia.
 */
-(instancetype _Nonnull )new NS_UNAVAILABLE;

/**
 Initialize object of AdGateMedia
 
 @param rewardCode to show offer wall & conversions

 @param userId User Id parameter is optional
 */
- (instancetype _Nonnull )initWithRewardCode:(nonnull NSString*)rewardCode userId:(nonnull NSString*)userId parentViewController:(nonnull UIViewController*)parentViewController;

/**
 This will load the offer wall but to show you have to manually call showOfferWall:
 
 @param parameter Only s2, s3, s4 and s5 parameters are supported, if you supply other parameters then they will be ignored
 
 @param successHandler success callback handler when wall is loaded successfully
 
 @param failedHandler failure callback handler when wall is unable to load due to some issue. an error object is passed with the reason.
 */
- (BOOL)loadOfferWall:(nonnull NSDictionary<NSString*,id> *)parameter onOfferWallLoadSuccess:(nullable void (^)(void))successHandler OnOfferWallLoadFailed:(nullable void (^)(NSError * _Nonnull error))failedHandler;

/**
 This will show the offer wall:
 
 @param closeHandler callback handler when user closes the offer wall
 */
- (void)showOfferWall:(nullable void (^)(void))closeHandler;

/**
 Get conversions offers list
 
 @param parameters Only s2, s3, s4 and s5 parameters are supported, if you supply other parameters then they will be ignored
 
 @param rewardCode to load conversions
 
 @param userId User Id parameter is optional
 
 @param completionHandler return offers if load successfully or error object if any.
 */
- (void)getConversions:(nonnull NSDictionary<NSString*,id> *)parameters rewardCode:(nonnull NSString*)rewardCode userId:(nonnull NSString*)userId completionHandler:(nullable void (^)(NSArray * _Nullable offers, NSError * _Nullable error))completionHandler;
    
@end

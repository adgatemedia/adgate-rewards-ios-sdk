//
//  AdGateMedia.h
//  AdGateMedia
//
//  Created by Igor Rotaru on 5/11/16.
//  Copyright © 2016 Igor Rotaru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ADMOffer;

@interface AdGateMedia : NSObject

@property (nonatomic, strong) NSString *strRewardCode;
@property (nonatomic, strong) NSString *strUserId;


- (id)initWithRewardCode:(NSString*)rewardCode userId:(NSString*)userId parentViewController:(UIViewController*)parentViewController;

- (void)loadOfferWall:(NSDictionary *)parameter onOfferWallLoadSuccess:(void (^)(void))successHandler OnOfferWallLoadFailed:(void (^)(NSError *error))failedHandler;

- (void)showOfferWall:(void (^)(void))closedHandler;

- (void)getConversions:(NSDictionary *)parameters rewardCode:(NSString*)rewardCode userId:(NSString*)userId completionHandler:(void (^)(NSArray *offers, NSError *error))completionNadler;

@end

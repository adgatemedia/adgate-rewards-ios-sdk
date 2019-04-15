//
//  ADMAdGateVideo.h
//  AdGateMedia
//
//  Copyright © 2018 AdGate Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ADMAdGateVideo : NSObject

@property (nonatomic, assign) NSTimeInterval showCrossButtonAfterDelay;
@property (nonatomic, copy) NSString *strVideoUDID;


+ (id)sharedIntance;

- (void)loadVideo:(NSString *)videoUDID userId:(NSString *)userId subIds:(NSDictionary *)parameter onVideoLoadSuccess:(void (^)(void))completionHandler onVideoLoadFailed:(void (^)(NSError *error))failedHandler;


- (void)showVideo:(UIViewController *)parentController showCrossButtonAfterDelay:(NSTimeInterval)seconds
                        onVideoWatchedAndClosed:(void (^)(void))closedHandler
                    onUserLeftApplication:(void (^)(void))leftApplicationHandler
                    onUserClickCloseWithoutWatching:(void (^) (void)) withoutWatchingHandler;

- (void)postImpressionForWatchedTime:(NSTimeInterval)watchedTime
                      percentWatched:(NSTimeInterval)percentWatched
                              subIDs:(NSDictionary *)subIDs;

@end

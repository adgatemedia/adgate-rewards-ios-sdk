//
//  AdGateMedia.h
//  AdGateMediaiOSSDK
//
//  Created by vishal dharnkar on 05/07/15.
//  Copyright (c) 2015 vishal dharnkar. All rights reserved.
//
/* this class is just a faced to the SDK 
 method showOfferWall is to be called by creating instance of this class
 showOfferWall will lift the load and do all necessary to launch 
 view controller responsible to show offerwall
*/

#import <Foundation/Foundation.h>
#import <UIKit/UIViewController.h>
#import <UIKit/UIWebView.h>

@interface AdGateMedia : NSObject
{
    UIViewController *parentView;
    NSString *strVcCode;
    NSString *strUserId;
    
}

/*
 this is the method which needs to be called to show offerwall
 it will take care of pushing the view controller required to show
 offerwall in a webview
 @param: extra parameter can be passed in as NSDictionary object.
         Only allowed extra input keys are s2, s3, s4 and s5,
         other than mentioned key, key and data will be neglected.
 */
-(void)showOfferWallWithParams:(NSDictionary *)parametar;

-(id)initWith:(NSString*)vcCode and:(NSString*)userId withParent:(UIViewController*)view;

@end

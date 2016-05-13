//
//  AdGateMedia.h
//  AdGateMedia
//
//  Created by Igor Rotaru on 5/11/16.
//  Copyright © 2016 Igor Rotaru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AdGateMedia : NSObject{
	UIViewController *parentView;
	NSString *strVcCode;
	NSString *strUserId;
}

-(void)showOfferWallWithParams:(NSDictionary *)parametar;

-(id)initWith:(NSString*)vcCode and:(NSString*)userId withParent:(UIViewController*)view;

@end

//
//  NSString+NSStringAdditions.m
//  Liker
//
//  Created by Igor on 22.03.15.
//  Copyright (c) 2015 Igor. All rights reserved.
//

#import "NSBundle+mybundle.h"


@implementation NSBundle (mybundle)

static NSBundle * _myBundle;

+ (NSBundle *)myBundle {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		
		NSBundle *mainBundle = [NSBundle mainBundle];
		NSString *pathToMyBundle = [mainBundle pathForResource:@"AdGateMediaiOSSDK" ofType:@"bundle"];
		//NSBundle* bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle]URLForResource:@"ResourceBundle" withExtension:@"bundle"]];
		NSAssert(pathToMyBundle, @"bundle not found", nil);
		
		_myBundle = [NSBundle bundleWithPath:pathToMyBundle];
	});
	
	return _myBundle;
}


@end

//
//  ViewController.m
//  SDKTest
//
//  Created by Adgate on 23/08/17.
//  Copyright © 2017 Adgate. All rights reserved.
//

#import "ViewController.h"

#import "AdGateMediaiOSSDK.h"
#import "ADMAdGateVideo.h"
#import "AdGateMedia.h"

@interface ViewController ()
@property (nonatomic, strong) AdGateMedia *obj_AdGateMedia;
@property (nonatomic, strong) ADMAdGateVideo *obj_ADMAdGateVideo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self clkResetValue:nil];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clkResetValue:(id)sender {
    
    tf_subids_s2.text = @"";
    tf_subids_s3.text = @"";
    tf_subids_s4.text = @"";
    tf_subids_s5.text = @"";
    
    tf_reward_code.text = @"naecqA";
    tf_user_id.text = @"user@adgate.com";
    tf_video_code.text = @"8c630eb2-ce13-43c8-8e25-3928998d4adb"; 
}


- (IBAction)clkOfferWall:(id)sender {
    NSLog(@"val %@ %@ ",tf_reward_code.text,tf_user_id.text);
    if (self.obj_AdGateMedia == nil)
    {
        self.obj_AdGateMedia = [[AdGateMedia alloc] initWithRewardCode:tf_reward_code.text userId:tf_user_id.text parentViewController:self];
    }else{
        self.obj_AdGateMedia.strRewardCode = tf_reward_code.text;
        self.obj_AdGateMedia.strUserId = tf_user_id.text;
    }
    
    NSDictionary *dictParameters = @{
                                @"s2" : tf_subids_s2.text,
                                @"s3" : tf_subids_s3.text,
                                @"s4" : tf_subids_s4.text,
                                @"s5" : tf_subids_s5.text,
                                };
    /*
     * Only allowed extra input keys are s2, s3, s4 and s5, other than mentioned key, key and data will be neglected
     * by [AdGateMedia showOfferWallWithParams: ] method.
     */
    
    [self.obj_AdGateMedia loadOfferWall:dictParameters onOfferWallLoadSuccess:^{
        [self.obj_AdGateMedia showOfferWall:^{
            NSLog(@"Closed wall");
        }];
    } OnOfferWallLoadFailed:^(NSError *error) {
        NSLog(@"failed to load wall %@",error.localizedDescription);
        [[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }];
    
}



- (IBAction)clkVideo:(id)sender {
    
    // do stuff...
    NSDictionary *dictParameters = @{
                                     @"s2" : tf_subids_s2.text,
                                     @"s3" : tf_subids_s3.text,
                                     @"s4" : tf_subids_s4.text,
                                     @"s5" : tf_subids_s5.text,
                                     };


    if (!self.obj_ADMAdGateVideo) {
        self.obj_ADMAdGateVideo = [[ADMAdGateVideo alloc] init];
    }
    
    
    [self.obj_ADMAdGateVideo loadVideo:tf_video_code.text userId:tf_user_id.text subIds:dictParameters onVideoLoadSuccess:^{
        NSLog(@"video downloaded");
        [self.obj_ADMAdGateVideo showVideo:self showCrossButtonAfterDelay:0 onVideoWatchedAndClosed:^{
            NSLog(@"Closed video");
            self.obj_ADMAdGateVideo.strVideoUDID = nil;
            self.obj_ADMAdGateVideo = nil;
        } onUserLeftApplication:^{
            NSLog(@"Here user leaves your app and goes to App Store Page");
            self.obj_ADMAdGateVideo = nil;
        } onUserClickCloseWithoutWatching:^{
            self.obj_ADMAdGateVideo = nil;
        }];

    } onVideoLoadFailed:^(NSError *error) {
        self.obj_ADMAdGateVideo.strVideoUDID = nil;
        self.obj_ADMAdGateVideo = nil;
        NSLog(@"failed to download: %@",error);
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a valid video code/tool Id." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];        
        
    }];
    
}



- (IBAction)clkLatestConversions:(id)sender {
    if (self.obj_AdGateMedia == nil) {
        self.obj_AdGateMedia = [[AdGateMedia alloc] initWithRewardCode:tf_reward_code.text userId:tf_user_id.text parentViewController:self];

    }
       NSDictionary *dictParameters = @{
                                @"s2" : tf_subids_s2.text,
                                @"s3" : tf_subids_s3.text,
                                @"s4" : tf_subids_s4.text,
                                @"s5" : tf_subids_s5.text,
                                };
    /*
     * Only allowed extra input keys are s2, s3, s4 and s5, other than mentioned key, key and data will be neglected
     * by [AdGateMedia showOfferWallWithParams: ] method.
     */
    
    [self.obj_AdGateMedia getConversions:dictParameters rewardCode:tf_reward_code.text userId:tf_user_id.text completionHandler:^(NSArray *offers, NSError *error) {
        if (!error) {
            [[[UIAlertView alloc] initWithTitle:@"Conversions List" message:[NSString stringWithFormat:@"%@",offers] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        }else {
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
}

#pragma mark - UITextField Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}




@end





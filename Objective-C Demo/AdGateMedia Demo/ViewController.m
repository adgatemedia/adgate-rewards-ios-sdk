//
//  ViewController.m
//  AdGateMedia Demo
//
//  Copyright © 2019 AdGateMedia. All rights reserved.
//

#import "ViewController.h"

#import <AdGateMedia/AdGateMedia.h>

@interface ViewController ()
{
    IBOutlet UITextField *textFieldUserID;
    IBOutlet UITextField *textFieldRewardCode;
    IBOutlet UITextField *textFieldVideoCode;
    IBOutlet UITextField *textFieldSubIDs_s2;
    IBOutlet UITextField *textFieldSubIDs_s3;
    IBOutlet UITextField *textFieldSubIDs_s4;
    IBOutlet UITextField *textFieldSubIDs_s5;
    
    IBOutlet UIButton *buttonResetValue;
    IBOutlet UIButton *buttonShowOfferWall;
    IBOutlet UIButton *buttonLoadAndShowOfferWall;
    IBOutlet UIButton *buttonLoadAndShowVideo;
    IBOutlet UIButton *buttonSeeLatestConversions;
}

@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic, strong) AdGateMedia *adgateMedia;
@property (nonatomic, strong) ADMAdGateVideo *adgateVideo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetDefaultAction:nil];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

-(void)startAnimating
{
    [self.activityIndicatorView startAnimating];

    buttonResetValue.enabled = NO;
    buttonShowOfferWall.enabled = NO;
    buttonLoadAndShowOfferWall.enabled = NO;
    buttonLoadAndShowVideo.enabled = NO;
    buttonSeeLatestConversions.enabled = NO;
}

-(void)stopAnimating
{
    [self.activityIndicatorView stopAnimating];

    buttonResetValue.enabled = YES;
    buttonShowOfferWall.enabled = YES;
    buttonLoadAndShowOfferWall.enabled = YES;
    buttonLoadAndShowVideo.enabled = YES;
    buttonSeeLatestConversions.enabled = YES;
}

- (IBAction)resetDefaultAction:(UIButton*)sender
{
    textFieldSubIDs_s2.text = @"";
    textFieldSubIDs_s3.text = @"";
    textFieldSubIDs_s4.text = @"";
    textFieldSubIDs_s5.text = @"";
    
    textFieldRewardCode.text = @"nqeX";
    textFieldUserID.text =    @"USERIDHERE";
    textFieldVideoCode.text = @"23dedb56-35c6-438b-be63-dbc386ccfc29";
}

- (IBAction)loadAndShowOfferWallAction:(UIButton*)sender {
    if (self.adgateMedia == nil)
    {
        self.adgateMedia = [[AdGateMedia alloc] initWithRewardCode:textFieldRewardCode.text userId:textFieldUserID.text parentViewController:self];
    }else{
        self.adgateMedia.strRewardCode = textFieldRewardCode.text;
        self.adgateMedia.strUserId = textFieldUserID.text;
    }
    
    NSDictionary *dictParameters = @{
                                     @"s2" : textFieldSubIDs_s2.text,
                                     @"s3" : textFieldSubIDs_s3.text,
                                     @"s4" : textFieldSubIDs_s4.text,
                                     @"s5" : textFieldSubIDs_s5.text,
                                     };
    
    [self startAnimating];
    
    [self.adgateMedia loadOfferWall:dictParameters onOfferWallLoadSuccess:^{
        [self stopAnimating];

        [self.adgateMedia showOfferWall:^{
            NSLog(@"Closed wall");
            [self stopAnimating];
        }];

    } OnOfferWallLoadFailed:^(NSError * _Nonnull error) {
        [self stopAnimating];

        NSLog(@"failed to load wall %@",error.localizedDescription);
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:error.localizedDescription
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

- (IBAction)showOfferWallAction:(UIButton*)sender {
    NSLog(@"val %@ %@ ",textFieldRewardCode.text,textFieldUserID.text);
    if (self.adgateMedia == nil)
    {
        self.adgateMedia = [[AdGateMedia alloc] initWithRewardCode:textFieldRewardCode.text userId:textFieldUserID.text parentViewController:self];
    }else{
        self.adgateMedia.strRewardCode = textFieldRewardCode.text;
        self.adgateMedia.strUserId = textFieldUserID.text;
    }

    NSDictionary *dictParameters = @{
                                     @"s2" : textFieldSubIDs_s2.text,
                                     @"s3" : textFieldSubIDs_s3.text,
                                     @"s4" : textFieldSubIDs_s4.text,
                                     @"s5" : textFieldSubIDs_s5.text,
                                     };
    /*
     * Only s2, s3, s4 and s5 parameters can be provided when showing a wall. Other parameters will be discarded.
     */
    [self startAnimating];
    BOOL success = [self.adgateMedia loadOfferWall:dictParameters onOfferWallLoadSuccess:^{
        [self stopAnimating];
        NSLog(@"Load Success");
        
    } OnOfferWallLoadFailed:^(NSError *error) {
        [self stopAnimating];
        NSLog(@"failed to load wall %@",error.localizedDescription);
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:error.localizedDescription
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
    if (success)
    {
        [self.adgateMedia showOfferWall:^{
            NSLog(@"Closed wall");
            [self stopAnimating];
        }];
    }
}

- (IBAction)loadAndShowVideoAction:(id)sender {
    
    NSDictionary *dictParameters = @{
                                     @"s2" : textFieldSubIDs_s2.text,
                                     @"s3" : textFieldSubIDs_s3.text,
                                     @"s4" : textFieldSubIDs_s4.text,
                                     @"s5" : textFieldSubIDs_s5.text,
                                     };
    
    
    if (!self.adgateVideo) {
        self.adgateVideo = [[ADMAdGateVideo alloc] init];
    }
    
    [self startAnimating];
    [self.adgateVideo loadVideo:textFieldVideoCode.text userId:textFieldUserID.text subIds:dictParameters onVideoLoadSuccess:^{
        [self stopAnimating];
        NSLog(@"video downloaded");
        [self.adgateVideo showVideo:self showCrossButtonAfterDelay:0 onVideoWatchedAndClosed:^{
            NSLog(@"Closed video");
            self.adgateVideo.strVideoUDID = nil;
            self.adgateVideo = nil;
        } onUserLeftApplication:^{
            NSLog(@"Here user leaves your app and goes to App Store Page");
            self.adgateVideo = nil;
        } onUserClickCloseWithoutWatching:^{
            NSLog(@"Closed Without Watching");
            self.adgateVideo = nil;
        }];
        
    } onVideoLoadFailed:^(NSError *error) {
        [self stopAnimating];
        self.adgateVideo.strVideoUDID = nil;
        self.adgateVideo = nil;
        NSLog(@"failed to download: %@",error);
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:error.localizedDescription
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

- (IBAction)showLatestConversionsAction:(UIButton*)sender {
    if (self.adgateMedia == nil) {
        self.adgateMedia = [[AdGateMedia alloc] initWithRewardCode:textFieldRewardCode.text userId:textFieldUserID.text parentViewController:self];
        
    }
    NSDictionary *dictParameters = @{
                                     @"s2" : textFieldSubIDs_s2.text,
                                     @"s3" : textFieldSubIDs_s3.text,
                                     @"s4" : textFieldSubIDs_s4.text,
                                     @"s5" : textFieldSubIDs_s5.text,
                                     };
    /*
     * Only s2, s3, s4 and s5 parameters can be provided when showing a wall. Other parameters will be discarded.
     */
    [self startAnimating];
    [self.adgateMedia getConversions:dictParameters rewardCode:textFieldRewardCode.text userId:textFieldUserID.text completionHandler:^(NSArray *offers, NSError *error) {
        
        [self stopAnimating];

        if (error) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Conversions List" message:[NSString stringWithFormat:@"%@",error.localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];

        }else {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Conversions List" message:[NSString stringWithFormat:@"%@",offers] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
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

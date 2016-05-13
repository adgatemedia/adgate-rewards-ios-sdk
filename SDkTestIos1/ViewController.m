//
//  ViewController.m
//  SDkTestIos1
//
//  Created by vishal dharnkar on 05/07/15.
//  Copyright (c) 2015 vishal dharnkar. All rights reserved.
//


#import "ViewController.h"
#import "AdGateMediaiOSSDK.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)actionTest:(id)sender{
    
    AdGateMedia *media = [[AdGateMedia alloc] initWith:@"nac" and:@"user1234" withParent:self];
                          
    NSDictionary *parameter = @{
                  @"s2" : @"Value s2",
                  @"s3" : @"Value s3",
                  @"s4" : @"Value s4",
                  @"s5" : @"Value s5",
                  };
    
    /*
     * Only allowed extra input keys are s2, s3, s4 and s5, other than mentioned key, key and data will be neglected
     * by [AdGateMedia showOfferWallWithParams: ] method.
     */
    [media showOfferWallWithParams:parameter];
}
@end

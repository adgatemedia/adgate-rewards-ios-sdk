//
//  ViewController.m
//  SDkTestIos1
//
//  Created by vishal dharnkar on 05/07/15.
//  Copyright (c) 2015 vishal dharnkar. All rights reserved.
//


#import "ViewController.h"
#import <AdGateMediaiOSSDK/AdGateMediaiOSSDK.h>

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
                          
    [media showOfferWall];
}
@end

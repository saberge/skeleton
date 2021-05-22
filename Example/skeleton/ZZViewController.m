//
//  ZZViewController.m
//  skeleton
//
//  Created by laixian on 05/22/2021.
//  Copyright (c) 2021 laixian. All rights reserved.
//

#import "ZZViewController.h"
#import <skeleton/ZZSkeletonPlayer.h>

@interface ZZViewController ()

@end

@implementation ZZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)onBtnClicked:(id)sender
{
    [ZZSkeletonPlayer playerSkeletonInContainer:self.view completedBlock:^{
            
    }];
}

@end

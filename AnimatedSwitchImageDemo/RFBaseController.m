//
//  RFBaseController.m
//  AnimatedSwitchImageDemo
//
//  Created by 王若风 on 11/26/16.
//  Copyright © 2016 王若风. All rights reserved.
//

#import "RFBaseController.h"

@interface RFBaseController ()

@end

@implementation RFBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Private

- (UIImage *)getRadomImage {
    return [UIImage imageNamed:[NSString stringWithFormat:@"%d",arc4random()%11]];
}



@end

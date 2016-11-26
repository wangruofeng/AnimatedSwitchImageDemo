//
//  RFFlipTransitionController.m
//  AnimatedSwitchImageDemo
//
//  Created by 王若风 on 11/26/16.
//  Copyright © 2016 王若风. All rights reserved.
//

#import "RFFlipTransitionController.h"

@interface RFFlipTransitionController ()

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViews;

@end

@implementation RFFlipTransitionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(animatedTransition) userInfo:nil repeats:YES];

}

- (void)animatedTransition {
    
    UIImage *toImage = [self getRadomImage];
    NSArray *filpTypes = @[
                          @(UIViewAnimationOptionTransitionFlipFromRight),
                          @(UIViewAnimationOptionTransitionFlipFromLeft),
                          @(UIViewAnimationOptionTransitionFlipFromTop),
                          @(UIViewAnimationOptionTransitionFlipFromBottom)
                          ];
    
    
    [self.imageViews enumerateObjectsUsingBlock:^(UIImageView *  _Nonnull imageView, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIViewAnimationOptions filpType = [filpTypes[idx] integerValue];
        [UIView transitionWithView:imageView
                          duration:0.5f
                           options:filpType | UIViewAnimationOptionCurveEaseInOut
                        animations:^{
                            imageView.image = toImage;
                        } completion:^(BOOL finished) {
                            
                        }];
    }];
    
}

@end

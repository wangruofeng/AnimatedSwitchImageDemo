//
//  ViewController.m
//  AnimatedSwitchImageDemo
//
//  Created by 王若风 on 11/26/16.
//  Copyright © 2016 王若风. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewThree;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(animatedSwich) userInfo:nil repeats:YES];
    [self animatedSwichImageMethodTwo];
}

- (void)animatedSwich {
    
    [self animatedSwichImageMethodOne];
   // [self animatedSwichImageMethodTwo];
    [self animatedSwichImageMethodThree];
}

- (void)animatedSwichImageMethodOne {

    UIImage *toImage = [self getRadomImage];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromTop;
    
    [self.imageViewOne.layer addAnimation:transition forKey:nil];
    [self.imageViewOne setImage:toImage];
}

- (void)animatedSwichImageMethodTwo {
    
    UIImage *toImage = [self getRadomImage];
    
    [UIView transitionWithView:self.imageViewTwo
                      duration:0.3f
                       options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionCurveEaseInOut
                    animations:^{
                        self.imageViewTwo.image = toImage;
                    } completion:^(BOOL finished) {
                        [self animatedSwichImageMethodTwo];
                    }];
}

- (void)animatedSwichImageMethodThree {
    
    UIImage *toImage = [self getRadomImage];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"contents"];
    animation.toValue = toImage;
    animation.duration = 0.3f;
    
    [self.imageViewThree.layer addAnimation:animation forKey:@"contentsAnimationKey"];
    [self.imageViewThree setImage:toImage];
}

@end

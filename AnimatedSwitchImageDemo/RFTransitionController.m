//
//  RFTransitionController.m
//  AnimatedSwitchImageDemo
//
//  Created by 王若风 on 11/26/16.
//  Copyright © 2016 王若风. All rights reserved.
//

#import "RFTransitionController.h"

@interface RFTransitionController ()

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViews;

@property (nonatomic, copy) NSString *transitiontype;

@end

@implementation RFTransitionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setup];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(animatedTransition) userInfo:nil repeats:YES];
}

- (void)setup {
    
    UIBarButtonItem *changeSubtypeItem = [[UIBarButtonItem alloc] initWithTitle:@"ChangeTransitionType" style:UIBarButtonItemStylePlain target:self action:@selector(changeTransitionType)];
    self.navigationItem.rightBarButtonItem = changeSubtypeItem;
    
    NSArray *transitionTypes = @[
                                 kCATransitionFade,
                                 kCATransitionMoveIn,
                                 kCATransitionPush,
                                 kCATransitionReveal
                                 ];
    self.transitiontype = transitionTypes[arc4random_uniform(4)];
}

- (void)animatedTransition {
    
    __block UIImage *toImage = [self getRadomImage];
    NSArray *transitionSubtypes = @[
                                    kCATransitionFromLeft,
                                    kCATransitionFromBottom,
                                    kCATransitionFromTop,
                                    kCATransitionFromRight
                                    ];
    
     [self.imageViews enumerateObjectsUsingBlock:^(UIImageView *  _Nonnull imageView, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CATransition *transition = [CATransition animation];
         
        transition.duration       = 0.3f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type           = self.transitiontype;
        transition.subtype        = transitionSubtypes[idx];
        
        [imageView.layer addAnimation:transition forKey:nil];
        [imageView setImage:toImage];
     }];
}

- (void)changeTransitionType {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Change Transition Type" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"kCATransitionFade" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.transitiontype = kCATransitionFade;
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"kCATransitionMoveIn" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.transitiontype = kCATransitionMoveIn;
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"kCATransitionPush" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.transitiontype = kCATransitionPush;
    }];
    
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"kCATransitionReveal" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.transitiontype = kCATransitionReveal;
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:nil];
    
    [controller addAction:action1];
    [controller addAction:action2];
    [controller addAction:action3];
    [controller addAction:action4];
    [controller addAction:cancelAction];
    
    [self.navigationController presentViewController:controller animated:YES completion:nil];
}

@end

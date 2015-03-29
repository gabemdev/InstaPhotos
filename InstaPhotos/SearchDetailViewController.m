//
//  SearchDetailViewController.m
//  InstaPhotos
//
//  Created by Rockstar. on 3/28/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "SearchDetailViewController.h"
#import "GMPhotoController.h"
#import "SearchViewController.h"
#import "PhotoModel.h"
#import "SharingView.h"

@interface SearchDetailViewController ()
@property UIImageView *imageView;
@property UIDynamicAnimator *animator;
@property SharingView *sharingView;

@end

@implementation SearchDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.95];
    self.view.clipsToBounds = YES;

    self.sharingView = [[SharingView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
    self.sharingView.alpha = 0.0;
    [self.view addSubview: self.sharingView];

    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, -320.0, 320.0, 320.0f)];
    self.imageView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
    self.imageView.image = self.photo;
    
    [self.view addSubview:self.imageView];

    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    [self.view addGestureRecognizer:swipe];

    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    CGPoint point = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.imageView snapToPoint:point];
    [self.animator addBehavior:snap];

    self.sharingView.center = point;
    [UIView animateWithDuration:0.5 delay:0.7 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:kNilOptions animations:^{
        self.sharingView.alpha = 1.0;
    } completion:nil];
}

- (void)close {
    [self.animator removeAllBehaviors];

    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.imageView snapToPoint:CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.view.bounds) + 180.0f)];
    [self.animator addBehavior:snap];

    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

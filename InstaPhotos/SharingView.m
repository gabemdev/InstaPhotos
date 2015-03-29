//
//  SharingView.m
//  InstaPhotos
//
//  Created by Rockstar. on 3/29/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "SharingView.h"

@interface SharingView ()
@property (nonatomic) UIImageView *avatarImageView;
@property (nonatomic) UIButton *usernameButton;
@property (nonatomic) UIButton *timeButton;
@property (nonatomic) UIButton *likesButton;
@property (nonatomic) UIButton *commentsButton;

@end

@implementation SharingView

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self addSubview:self.usernameButton];
        [self addSubview:self.avatarImageView];
        [self addSubview:self.timeButton];
        [self addSubview:self.likesButton];
        [self addSubview:self.commentsButton];
        
    }
    return self;
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(320.0f, 400.0f);
}


#pragma mark - UIControls

- (UIButton *)likesButton {
    if (!_likesButton) {
        _likesButton = [[UIButton alloc] initWithFrame:CGRectMake(10.0f, 360.0f, 50.0f, 40.0f)];
        _likesButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [_likesButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        _likesButton.adjustsImageWhenHighlighted = NO;
        _likesButton.imageEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 6.0f);
    }
    return _likesButton;
}


- (UIButton *)commentsButton {
    if (!_commentsButton) {
        _commentsButton = [[UIButton alloc] initWithFrame:CGRectMake(260.0f, 360.0f, 50.0f, 40.0f)];
        _commentsButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [_commentsButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        _commentsButton.adjustsImageWhenHighlighted = NO;
        _commentsButton.imageEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 6.0f);
        _commentsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _commentsButton;
}


#pragma mark - Private

+ (UIColor *)darkTextColor {
    return [UIColor colorWithRed:0.949f green:0.510f blue:0.380f alpha:1.0f];
}


+ (UIColor *)lightTextColor {
    return [UIColor colorWithRed:0.973f green:0.753f blue:0.686f alpha:1.0f];
}

@end

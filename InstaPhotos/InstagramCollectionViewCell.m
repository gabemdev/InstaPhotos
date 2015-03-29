//
//  InstagramCollectionViewCell.m
//  InstaPhotos
//
//  Created by Rockstar. on 3/26/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "InstagramCollectionViewCell.h"

@implementation InstagramCollectionViewCell

- (void)layoutSubviews {
    [super layoutSubviews];

    self.feedImage.frame = self.contentView.bounds;
}



@end

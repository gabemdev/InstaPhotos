//
//  Instagram.h
//  InstaPhotos
//
//  Created by Rockstar. on 3/26/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol InstagramDelegate <NSObject>

- (void)didGetResultsWithMutableArray:(NSMutableArray *)resultArray;

@end

@interface Instagram : NSObject
@property NSMutableArray *results;
@property NSMutableArray *favorites;
@property (nonatomic, assign) id <InstagramDelegate> delegate;

- (void)getInstagramPhotosWithString:(NSMutableString *)string;




@end

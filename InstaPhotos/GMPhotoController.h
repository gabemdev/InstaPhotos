//
//  GMPhotoController.h
//  InstaPhotos
//
//  Created by Rockstar. on 3/28/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GMPhotoController : NSObject

- (void)savePhotoTo:(NSMutableArray *)savedArray;
- (NSMutableArray *)getSavedArray;

@end

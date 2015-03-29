//
//  PhotoModel.h
//  InstaPhotos
//
//  Created by Rockstar. on 3/26/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

@interface PhotoModel : NSObject <NSCoding>

@property NSString *photosID;
@property BOOL isFavorite;
@property UIImage *image;
@property CLLocationCoordinate2D coordinate;
@property NSURL *imageURL;
@property NSNumber *latitude;
@property NSNumber *longitude;
@property NSData *imageData;
@property NSString *user;

- (void)encodeWithCoder:(NSCoder *)aCoder;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (UIImage *)favoriteIndicator;


@end

//
//  ImageAnnotation.h
//  InstaPhotos
//
//  Created by Rockstar. on 3/29/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "PhotoModel.h"

@interface ImageAnnotation : MKPointAnnotation

@property PhotoModel *photo;
@property UIImage *image;

@end

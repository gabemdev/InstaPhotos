//
//  PhotoModel.m
//  InstaPhotos
//
//  Created by Rockstar. on 3/26/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
//        if ([dictionary objectForKey:@"location"] != [NSNull null]) {
//            CLLocationDegrees lat = [(NSNumber *)[[dictionary objectForKey:@"location"] objectForKey:@"latitude"] doubleValue];
//            CLLocationDegrees lon = [(NSNumber *)[[dictionary objectForKey:@"location"] objectForKey:@"longitude"] doubleValue];
//            self.coordinate = CLLocationCoordinate2DMake(lat, lon);
//        }

        self.photosID = dictionary[@"id"];
        self.imageURL = [NSURL URLWithString:[[[dictionary objectForKey:@"images"] objectForKey:@"standard_resolution"] objectForKey:@"url"]];
        self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];
        self.user = dictionary[@"user"][@"username"];
        self.isFavorite = NO;

//        NSString *value = [dictionary objectForKey:@"location"];
//        if (![value isKindOfClass:[NSNull class]]) {
//            NSDictionary *locationDict = dictionary[@"location"];
//            self.latitude = locationDict[@"latitude"];
//            self.longitude = locationDict[@"longitude"];
//            self.coordinate = CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
//        }
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init]))
    {
        CLLocationDegrees lat = [decoder decodeDoubleForKey:@"kLat"];
        CLLocationDegrees lon = [decoder decodeDoubleForKey:@"kLon"];
        self.coordinate = CLLocationCoordinate2DMake(lat, lon);
        self.photosID = [decoder decodeObjectForKey:@"kPostID"];
        self.imageURL = [decoder decodeObjectForKey:@"kImageURL"];
        self.image = [decoder decodeObjectForKey:@"kImage"];
        self.latitude = [decoder decodeObjectForKey:@"latitude"];
        self.longitude = [decoder decodeObjectForKey:@"longitude"];
        self.imageData = [decoder decodeObjectForKey:@"photoData"];
        self.user = [decoder decodeObjectForKey:@"userName"];

        self.isFavorite = YES;

        return self;
    }

    return nil;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeDouble:self.coordinate.latitude forKey:@"kLat"];
    [encoder encodeDouble:self.coordinate.longitude forKey:@"kLon"];
    [encoder encodeObject:self.photosID forKey:@"kPostID"];
    [encoder encodeObject:self.imageURL forKey:@"kImageURL"];
    [encoder encodeObject:self.image forKey:@"kImage"];
    [encoder encodeObject:self.latitude forKey:@"latitude"];
    [encoder encodeObject:self.longitude forKey:@"longitude"];
    [encoder encodeObject:self.imageData forKey:@"photoData"];
    [encoder encodeObject:self.user forKey:@"userName"];
}

- (UIImage *)favoriteIndicator {
    if (self.isFavorite) {
        return [UIImage imageNamed:@"like"];
    }
    else {
        return [UIImage imageNamed:@"star"];
    }

}
@end

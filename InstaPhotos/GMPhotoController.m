//
//  GMPhotoController.m
//  InstaPhotos
//
//  Created by Rockstar. on 3/28/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "GMPhotoController.h"

#define kDateSavedKey @"dateSaved"

@implementation GMPhotoController

- (NSURL *)documentDirectory {
    return [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
}

- (NSURL *)plist {
    NSURL *path = [[self documentDirectory] URLByAppendingPathComponent:@"Images.plist"];
    return path;
}

- (void)savePhotoTo:(NSMutableArray *)savedArray {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:savedArray];
    [data writeToURL:[self plist] atomically:YES];
    [userDefaults setObject:[NSDate date] forKey:kDateSavedKey];
    [userDefaults synchronize];
}

- (NSMutableArray *)getSavedArray {
    NSData *data = [NSData dataWithContentsOfURL:[self plist]];

    if (![NSData dataWithContentsOfURL:[self plist]]) {
        return [NSMutableArray new];
    } else {
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
}

@end

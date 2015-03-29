//
//  Instagram.m
//  InstaPhotos
//
//  Created by Rockstar. on 3/26/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "Instagram.h"
#import "PhotoModel.h"
#define InstAPI @"039d27358e934075bcfe604bbcc66029"


@implementation Instagram

- (void)getInstagramPhotosWithString:(NSMutableString *)string {
    if ([string characterAtIndex:0] == '#') {
        [string deleteCharactersInRange:NSMakeRange(0, 1)];

        [self searchWithHashTah:[NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=%@", string, InstAPI]];
    }
    else {
        [self searchWithUser:[NSString stringWithFormat:@"https://api.instagram.com/v1/users/search?q=%@&count=1&client_id=%@", string, InstAPI]];
    }
}


- (void)searchWithUser:(NSString *)user {

    NSURL *url = [NSURL URLWithString:user];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            NSDictionary *fetchedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
            NSString *userID = [[fetchedData[@"data"] firstObject] objectForKey:@"id"];
            [self searchWithHashTah:[NSString stringWithFormat:@"https://api.instagram.com/v1/users/%@/media/recent/?client_id=%@", userID, InstAPI]];
        }
    }];

}

- (void)searchWithHashTah:(NSString *)hashtag {

    NSURL *url = [NSURL URLWithString:hashtag];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            NSDictionary *fetchedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
            NSArray *dataArray = fetchedData[@"data"];
            NSMutableArray *searchResult = [NSMutableArray new];
            for (NSDictionary *post in dataArray) {
                if ([post[@"type"] isEqualToString:@"image"]) {
                    PhotoModel *new = [[PhotoModel alloc] initWithDictionary:post];
                    [searchResult addObject:new];
                }
            }
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate didGetResultsWithMutableArray:searchResult];
                });
            });
        }
    }];
}
@end

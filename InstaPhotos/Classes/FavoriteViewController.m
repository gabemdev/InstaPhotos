//
//  FavoriteViewController.m
//  InstaPhotos
//
//  Created by Rockstar. on 3/26/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "FavoriteViewController.h"
#import "PhotoModel.h"
#import "InstagramCollectionViewCell.h"
#import "GMPhotoController.h"
#import "SearchDetailViewController.h"

@interface FavoriteViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *tabArrow;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *helloLabel;

@property NSMutableArray *favoritesArray;
@property GMPhotoController *photoController;

@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"arches"]]];
    self.photoController = [GMPhotoController new];
    self.favoritesArray = [self.photoController getSavedArray];
    [self.collectionView reloadData];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDeleteFavorite:)];
    tap.numberOfTapsRequired = 2;
    tap.delaysTouchesBegan = YES;
    tap.delegate = self;
    [self.collectionView addGestureRecognizer:tap];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.favoritesArray) {
        self.favoritesArray = [NSMutableArray new];
    }

    [self.collectionView reloadData];
}


#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (self.favoritesArray.count > 0) {
        self.helloLabel.hidden = YES;
        self.tabArrow.hidden = YES;
        self.introLabel.hidden = YES;
        self.collectionView.hidden = NO;
    } else {
        self.helloLabel.hidden = NO;
        self.tabArrow.hidden = NO;
        self.introLabel.hidden = NO;
        self.collectionView.hidden = YES;
    }
    return self.favoritesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    InstagramCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCell" forIndexPath:indexPath];
    if ([[self.favoritesArray objectAtIndex:indexPath.row] isFavorite]) {
        cell.feedImage.image = [[self.favoritesArray objectAtIndex:indexPath.row] image];
        cell.favoriteImage.image = [[self.favoritesArray objectAtIndex:indexPath.row] favoriteIndicator];
        return cell;
    } else {
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *selected = [self.favoritesArray[indexPath.row] image];
    SearchDetailViewController *vc = [[SearchDetailViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    vc.photo = selected;
    vc.favoriteArray = self.favoritesArray;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)didDeleteFavorite:(UITapGestureRecognizer *)tap {
    UIActionSheet *actionSheet = nil;
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Delete From Favorites", @"Share", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.navigationController.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        CGPoint point = [tap locationInView:self.collectionView];
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
        PhotoModel *photo = [self.favoritesArray objectAtIndex:indexPath.row];
        for (PhotoModel *model in self.favoritesArray) {
            if ([photo.photosID isEqualToString:model.photosID]) {
                [self.favoritesArray removeObject:photo];
                [self showLikeCompletion];
                [self.collectionView reloadData];
                [self.photoController savePhotoTo:self.favoritesArray];
                break;
            }
        }

    } else if (buttonIndex == 1) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        CGPoint point = [tap locationInView:self.collectionView];
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
        PhotoModel *modedl = [self.favoritesArray objectAtIndex:indexPath.row];
        NSArray *items = @[modedl.image, modedl];
        UIActivityViewController *share = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
        share.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint, UIActivityTypePostToWeibo, UIActivityTypePostToTencentWeibo, UIActivityTypeAddToReadingList];
        [self presentViewController:share animated:YES completion:nil];
    }
}

- (void)showLikeCompletion {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Removed from Faves! =(" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];

    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    });
}




@end

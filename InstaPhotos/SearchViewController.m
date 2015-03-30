//
//  SearchViewController.m
//  InstaPhotos
//
//  Created by Rockstar. on 3/26/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "SearchViewController.h"
#import "InstagramCollectionViewCell.h"
#import "Instagram.h"
#import "PhotoModel.h"
#import "GMPhotoController.h"

@interface SearchViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, InstagramDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *networkActivityIndicator;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UILabel *beginSearchLabel;
@property (weak, nonatomic) IBOutlet UISearchBar *searchField;
@property (weak, nonatomic) IBOutlet UILabel *helloLabel;

@property NSMutableArray *resultArray;
@property NSMutableArray *savedArray;
@property Instagram *instagramModel;
@property CGFloat currentCellWidth;
@property GMPhotoController *photoController;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"arches"]]];
    self.photoController = [GMPhotoController new];
    self.instagramModel = [Instagram new];
    self.instagramModel.delegate = self;
    self.resultArray = [NSMutableArray new];
    self.savedArray = [self.photoController getSavedArray];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(382, 495)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];

    [self.collectionView setCollectionViewLayout:flowLayout];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.savedArray = [self.photoController getSavedArray];
    [self checkResultsArray:self.resultArray withFavorites:self.savedArray];
    [self.collectionView reloadData];
}


#pragma mark - UICollectionView 
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (self.resultArray.count > 0) {
        self.helloLabel.hidden = YES;
        self.beginSearchLabel.hidden = YES;
        self.arrowImageView.hidden = YES;
    } 
    if (self.resultArray.count < 10) {
        return self.resultArray.count;
    } else {
        return 10;
    }
}

- (InstagramCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    InstagramCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCell" forIndexPath:indexPath];
    PhotoModel *model = self.resultArray[indexPath.item];
    cell.feedImage.image = model.image;
    cell.feedImage.layer.cornerRadius = 3;
    cell.favoriteImage.image = [model favoriteIndicator];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoModel *model = [self.resultArray objectAtIndex:indexPath.row];
    self.savedArray = [self setFavorite:model fromSavedArray:[self.photoController getSavedArray]];
    [self.collectionView reloadData];
    [self.photoController savePhotoTo:self.savedArray];
    [self showLikeCompletion];
}

#pragma mark - Search Field
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
   NSMutableString *searchString = [[NSMutableString alloc] initWithString:searchBar.text];
    [self.instagramModel getInstagramPhotosWithString:searchString];
     [self.networkActivityIndicator startAnimating];
    [self.searchField resignFirstResponder];
}

- (void)didGetResultsWithMutableArray:(NSMutableArray *)resultArray {
    [self.networkActivityIndicator stopAnimating];
    self.resultArray = resultArray;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}


#pragma mark - Actions

- (void)showLikeCompletion {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Added to Faves!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];

    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    });
}


#pragma mark - Helper Methods
- (NSMutableArray *)setFavorite:(PhotoModel *)fave fromSavedArray:(NSMutableArray *)saved {
    for (PhotoModel *favorite in saved) {
        if ([favorite.photosID isEqualToString:fave.photosID]) {
            fave.isFavorite = NO;
            [saved removeObject:favorite];
            return saved;
        }
    }
    fave.isFavorite = YES;
    [saved addObject:fave];
    return saved;
}


- (void)checkResultsArray:(NSMutableArray *)results withFavorites:(NSMutableArray *)favorites {
    for (PhotoModel *model in results) {
        model.isFavorite = NO;
        for (PhotoModel *favorite in favorites) {
            if ([favorite.photosID isEqualToString:model.photosID]) {
                model.isFavorite = YES;
                break;
            }
        }
    }
}


@end

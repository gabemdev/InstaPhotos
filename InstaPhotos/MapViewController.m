//
//  MapViewController.m
//  InstaPhotos
//
//  Created by Rockstar. on 3/26/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "PhotoModel.h"
#import "ImageAnnotation.h"
#import "GMPhotoController.h"

@interface MapViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property PhotoModel *currentPhoto;
@property GMPhotoController *photoController;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    self.photoController = [GMPhotoController new];
    self.favoritesArray = [self.photoController getSavedArray];
    for (PhotoModel *photo in self.favoritesArray)
    {
        [self addPinOnMapWithPhoto:photo];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mapView showAnnotations:self.mapView.annotations animated:true];
}


- (void) addPinOnMapWithPhoto:(PhotoModel *)photo
{
    ImageAnnotation *point = [ImageAnnotation new];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([photo.latitude floatValue],[photo.longitude floatValue]);
    point.coordinate = coordinate;
    point.title = photo.user;
    point.photo = photo;

    [self.mapView addAnnotation:point];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    ImageAnnotation *newAnnotation = annotation;
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:newAnnotation reuseIdentifier:nil];
    pin.canShowCallout = YES;
//    pin.pinColor = MKPinAnnotationColorRed;
    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];

    return pin;
}

-(UIImage*)resizeImage:(UIImage *)image imageSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    return newImage;

}

@end

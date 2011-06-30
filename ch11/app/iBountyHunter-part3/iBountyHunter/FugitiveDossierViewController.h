//
//  FugitiveDossierViewController.h
//  iBountyHunter
//
//  Created by Dan Pilone on 3/27/11.
//  Copyright 2011 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "Fugitive.h"

@interface FugitiveDossierViewController : UIViewController <UISplitViewControllerDelegate> {
@private
    Fugitive *fugitive_;
    MKMapView *mapView_;
    UIImageView *fugitiveImageView_;
    UIWebView *fugitiveDescription_;
    UIWebView *mapDescription_;
    UIImageView *mapOverlay_;
    UIPopoverController *popOver_;
}

@property (nonatomic, retain) Fugitive *fugitive;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UIImageView *fugitiveImageView;
@property (nonatomic, retain) IBOutlet UIWebView *fugitiveDescription;
@property (nonatomic, retain) IBOutlet UIWebView *mapDescription;
@property (nonatomic, retain) IBOutlet UIImageView *mapOverlay;
@property (nonatomic, retain) UIPopoverController *popOver;

- (void) showFugitiveDossier: (Fugitive *)someFugitive;

@end

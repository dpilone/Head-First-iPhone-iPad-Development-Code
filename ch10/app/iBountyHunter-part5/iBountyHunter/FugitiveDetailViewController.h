//
//  FugitiveDetailViewController.h
//  iBountyHunter
//
//  Created by Dan Pilone on 2/20/11.
//  Copyright 2011 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "Fugitive.h"

@interface FugitiveDetailViewController : UIViewController <CLLocationManagerDelegate> {
@private
    Fugitive *fugitive_;
    UILabel *nameLabel_;
    UILabel *idLabel_;
    UITextView *descriptionTextView_;
    UILabel *bountyLabel_;
    UISegmentedControl *capturedToggle_;
    UILabel *capturedDateLabel_;
    UILabel *capturedLatLon_;
    CLLocationManager *locationManager_;
}

@property (nonatomic, retain) Fugitive *fugitive;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *idLabel;
@property (nonatomic, retain) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, retain) IBOutlet UILabel *bountyLabel;
@property (nonatomic, retain) IBOutlet UISegmentedControl *capturedToggle;
@property (nonatomic, retain) IBOutlet UILabel *capturedDateLabel;
@property (nonatomic, retain) IBOutlet UILabel *capturedLatLon;
@property (nonatomic, readonly) CLLocationManager *locationManager;

- (IBAction) capturedToggleChanged: (id) sender;
- (IBAction) showInfoButtonPressed;

@end

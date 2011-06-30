//
//  FugitiveDetailViewController.m
//  iBountyHunter
//
//  Created by Dan Pilone on 2/20/11.
//  Copyright 2011 Element 84, LLC. All rights reserved.
//

#import "FugitiveDetailViewController.h"
#import "CapturedPhotoViewController.h"

@interface FugitiveDetailViewController (Private)
    - (void) refreshFugitiveInformation;
@end

@implementation FugitiveDetailViewController

@synthesize fugitive=fugitive_;
@synthesize nameLabel=nameLabel_;
@synthesize idLabel=idLabel_;
@synthesize descriptionTextView=descriptionTextView_;
@synthesize bountyLabel=bountyLabel_;
@synthesize capturedToggle=capturedToggle_;
@synthesize capturedDateLabel=capturedDateLabel_;
@synthesize capturedLatLon=capturedLatLon_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [fugitive_ release];
    [nameLabel_ release];
    [idLabel_ release];
    [descriptionTextView_ release];
    [bountyLabel_ release];
    [capturedToggle_ release];
    [capturedDateLabel_ release];
    [capturedLatLon_ release];
    [locationManager_ release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self refreshFugitiveInformation];
    
    // Disable the capture toggle button until we have a location fix
    self.capturedToggle.enabled = NO;
    [self.locationManager startUpdatingLocation];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    NSLog(@"%@", @"Shutting down core location."); 
    [self.locationManager stopUpdatingLocation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - CLLocationManager methods

- (CLLocationManager*) locationManager {
    if (locationManager_ == nil) {
        locationManager_ = [[CLLocationManager alloc] init];
        locationManager_.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        locationManager_.delegate = self;
    }
    
    return locationManager_;
}

- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"%@", @"Core location claims to have a position.");
    self.capturedToggle.enabled = YES;
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%@", @"Core location can't get a fix.  Disabling capture toggle.");
    self.capturedToggle.enabled = NO;
}

#pragma - Callbacks

- (IBAction) capturedToggleChanged: (id) sender {
    if (self.capturedToggle.selectedSegmentIndex == 0) {
        // The user just marked this fugitive as captured
        fugitive_.captdate = [NSDate date];
        fugitive_.captured = [NSNumber numberWithBool:YES];

        CLLocation *curPos = self.locationManager.location;
        fugitive_.capturedLat = [NSNumber numberWithDouble:curPos.coordinate.latitude];
        fugitive_.capturedLon = [NSNumber numberWithDouble:curPos.coordinate.longitude];
    }
    else {
        fugitive_.captdate = nil;
        fugitive_.captured = [NSNumber numberWithBool:NO];
        fugitive_.capturedLat = nil;
        fugitive_.capturedLon = nil;
    }
    
    [self refreshFugitiveInformation];
}

- (IBAction) showInfoButtonPressed {
    CapturedPhotoViewController *vc = [[CapturedPhotoViewController alloc] initWithNibName:@"CapturedPhotoViewController" bundle:nil];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    vc.fugitive = self.fugitive;
    [self presentModalViewController:vc animated:YES];
    [vc release];
}

#pragma mark - Helper methods

- (void) refreshFugitiveInformation {
    self.nameLabel.text = fugitive_.name;
    self.idLabel.text = [fugitive_.fugitiveID stringValue];
    self.descriptionTextView.text = fugitive_.desc;
    self.bountyLabel.text = [fugitive_.bounty stringValue];
    self.capturedDateLabel.text = [fugitive_.captdate description];
    self.capturedToggle.selectedSegmentIndex = [fugitive_.captured boolValue] ? 0 : 1;
    self.capturedDateLabel.text = [fugitive_.captdate description];
    if (fugitive_.capturedLat != nil) {
        self.capturedLatLon.text = [NSString stringWithFormat:@"%.3f, %.3f",
                                    [fugitive_.capturedLat doubleValue],
                                    [fugitive_.capturedLon doubleValue]];   
    }
    else {
        self.capturedLatLon.text = @"";
    }
}

@end

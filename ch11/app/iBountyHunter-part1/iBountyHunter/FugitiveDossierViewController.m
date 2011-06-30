//
//  FugitiveDossierViewController.m
//  iBountyHunter
//
//  Created by Dan Pilone on 3/27/11.
//  Copyright 2011 Element 84, LLC. All rights reserved.
//

#import "FugitiveDossierViewController.h"

@interface FugitiveDossierViewController ()
    - (void) updateDossier;
    - (NSString *) prepareFugitiveDescription;
@end

@implementation FugitiveDossierViewController

@synthesize fugitive=fugitive_;
@synthesize fugitiveImageView=fugitiveImageView_;
@synthesize fugitiveDescription=fugitiveDescription_;
@synthesize mapView=mapView_;
@synthesize mapDescription=mapDescription_;
@synthesize popOver=popOver_;

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
    [fugitiveImageView_ release];
    [fugitiveDescription_ release];
    [mapView_ release];
    [mapDescription_ release];
    [popOver_ release];
    
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Helper methods

- (NSString *) prepareFugitiveDescription {
    return [NSString stringWithFormat: @"Name: %@\r\nID: %@\r\nBounty: %@\r\nDescription: %@",
     fugitive_.name,
     [fugitive_.fugitiveID stringValue],
     [fugitive_.bounty stringValue],
     fugitive_.desc];
}

- (void) updateDossier {
    if (fugitive_.image != nil) {
        self.fugitiveImageView.image = [UIImage imageWithData:fugitive_.image];
    }
    
    fugitiveDescription_.text = [self prepareFugitiveDescription];
    CLLocationCoordinate2D mapCenter = CLLocationCoordinate2DMake([fugitive_.capturedLat doubleValue], 
                                                                  [fugitive_.capturedLon doubleValue]);      
    MKCoordinateSpan mapSpan = MKCoordinateSpanMake(0.005, 0.005);        
    MKCoordinateRegion mapRegion = MKCoordinateRegionMake(mapCenter, mapSpan);
    
    self.mapView.region = mapRegion;
    self.mapView.mapType = MKMapTypeHybrid;
    
    if (popOver_ != nil) {
        [popOver_ dismissPopoverAnimated:YES];
    }
}

- (void) showFugitiveDossier: (Fugitive *)someFugitive {
    self.fugitive = someFugitive;
    [self updateDossier];
}

#pragma mark - UISplitViewControllerDelegate methods

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc {
    barButtonItem.title = @"Fugitives";
    
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.popOver = pc;
}

- (void) splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.popOver = nil;
}


@end

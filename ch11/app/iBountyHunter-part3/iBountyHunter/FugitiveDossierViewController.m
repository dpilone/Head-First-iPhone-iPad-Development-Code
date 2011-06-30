//
//  FugitiveDossierViewController.m
//  iBountyHunter
//
//  Created by Dan Pilone on 3/27/11.
//  Copyright 2011 Element 84, LLC. All rights reserved.
//

#import <QuartzCore/CoreAnimation.h>
#import "FugitiveDossierViewController.h"

#define NO_FUGITIVE_SELECTED_HTML @"<html><link rel=\"stylesheet\" type=\"text/css\" href=\"fugitive.css\" /><body><dl class=\"dossier\"><dt>No fugitive selected.</dt><dd></dd></dl></body></html>";

#define NO_KNOWN_LOCATION_HTML @"<html><link rel=\"stylesheet\" type=\"text/css\" href=\"fugitive.css\" /><body><dl class=\"dossier\"><dt>No last known location.</dt><dd></dd></dl></body></html>";

@interface FugitiveDossierViewController ()
    - (void) updateDossier;
    - (NSString *) prepareFugitiveDescription;
    - (NSString *) prepareMapDescription;
@end

@implementation FugitiveDossierViewController

@synthesize fugitive=fugitive_;
@synthesize fugitiveImageView=fugitiveImageView_;
@synthesize fugitiveDescription=fugitiveDescription_;
@synthesize mapView=mapView_;
@synthesize mapOverlay=mapOverlay_;
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
    [mapOverlay_ release];
    
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
    UIImage *backgroundTexture = [UIImage imageNamed:@"corkboard.png"];
    UIColor *backgroundColor = [UIColor colorWithPatternImage:backgroundTexture];
    [self.view setBackgroundColor:backgroundColor];
    
    [fugitiveDescription_ setBackgroundColor:[UIColor clearColor]];
    [mapDescription_ setBackgroundColor:[UIColor clearColor]];

    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [fugitiveDescription_ loadHTMLString:[self prepareFugitiveDescription] baseURL:baseURL];
    [mapDescription_ loadHTMLString:[self prepareMapDescription] baseURL:baseURL];
    
    self.fugitiveImageView.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    self.fugitiveImageView.layer.shadowOpacity = 0.75;
    
    self.mapOverlay.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    self.mapOverlay.layer.shadowOpacity = 0.75;
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
    NSString *response = nil;
    
    if (self.fugitive) {
        response = [NSString stringWithFormat: @"<html><link rel=\"stylesheet\" type=\"text/css\" href=\"fugitive.css\" /><body><dl class=\"dossier\"><dt>Name:</dt><dd>%@</dd><dt>ID:</dt><dd>%@</dd><dt>Bounty:</dt><dd>%@</dd><dt>Description:</dt><dd>%@</dd></dl></body></html>",
                    fugitive_.name,
                    [fugitive_.fugitiveID stringValue],
                    [fugitive_.bounty stringValue],
                    fugitive_.desc];
    }
    else {
        response = NO_FUGITIVE_SELECTED_HTML;
    }
    return response;
}

- (NSString *) prepareMapDescription {
    NSString *response = nil;
    if (self.fugitive && self.fugitive.lastSeenDesc) {
        response = [NSString stringWithFormat: @"<html><link rel=\"stylesheet\" type=\"text/css\" href=\"fugitive.css\" /><body><dl class=\"dossier\"><dt>Last Seen:</dt><dd>%6.3f, %6.3f</dd><dt>Description:</dt><dd>%@</dd></dl></body></html>",
                    [fugitive_.lastSeenLat doubleValue],
                    [fugitive_.lastSeenLon doubleValue],
                    fugitive_.lastSeenDesc];
    }
    else if (self.fugitive) {
        response = NO_KNOWN_LOCATION_HTML;
    }
    else {
        response = NO_FUGITIVE_SELECTED_HTML;
    }
    
    return response;
}

- (void) updateDossier {
    if (fugitive_.image != nil) {
        self.fugitiveImageView.image = [UIImage imageWithData:fugitive_.image];
    }
    else {
        self.fugitiveImageView.image = [UIImage imageNamed:@"silhouette.png"];
    }
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [fugitiveDescription_ loadHTMLString:[self prepareFugitiveDescription] baseURL:baseURL];
    [mapDescription_ loadHTMLString:[self prepareMapDescription] baseURL:baseURL];
    
    if (fugitive_.lastSeenLat != nil) {
        CLLocationCoordinate2D mapCenter = CLLocationCoordinate2DMake([fugitive_.lastSeenLat doubleValue], [fugitive_.lastSeenLon doubleValue]);      
        MKCoordinateSpan mapSpan = MKCoordinateSpanMake(0.005, 0.005);        
        MKCoordinateRegion mapRegion = MKCoordinateRegionMake(mapCenter, mapSpan);
    
        self.mapView.region = mapRegion;
        self.mapView.mapType = MKMapTypeHybrid;
        self.mapOverlay.hidden = YES;
    }
    else {
        self.mapOverlay.hidden = NO;
    }
    
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

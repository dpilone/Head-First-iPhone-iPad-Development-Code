//
//  FugitiveDetailViewController.m
//  iBountyHunter
//
//  Created by Dan Pilone on 2/20/11.
//  Copyright 2011 Element 84, LLC. All rights reserved.
//

#import "FugitiveDetailViewController.h"


@implementation FugitiveDetailViewController

@synthesize fugitive=fugitive_;
@synthesize nameLabel=nameLabel_;
@synthesize idLabel=idLabel_;
@synthesize descriptionTextView=descriptionTextView_;
@synthesize bountyLabel=bountyLabel_;
@synthesize capturedToggle=capturedToggle_;
@synthesize capturedDateLabel=capturedDateLabel_;

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
    
    self.nameLabel.text = fugitive_.name;
    self.idLabel.text = [fugitive_.fugitiveID stringValue];
    self.descriptionTextView.text = fugitive_.desc;
    self.bountyLabel.text = [fugitive_.bounty stringValue];
    self.capturedDateLabel.text = [fugitive_.captdate description];
    self.capturedToggle.selectedSegmentIndex = [fugitive_.captured boolValue] ? 0 : 1;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma - Callbacks

- (IBAction) capturedToggleChanged: (id) sender {
    if (self.capturedToggle.selectedSegmentIndex == 0) {
        // The user just marked this fugitive as captured
        fugitive_.captdate = [NSDate date];
        fugitive_.captured = [NSNumber numberWithBool:YES];
        self.capturedDateLabel.text = [fugitive_.captdate description];
    }
    else {
        fugitive_.captdate = nil;
        fugitive_.captured = [NSNumber numberWithBool:NO];
        self.capturedDateLabel.text = @"";
    }
}

@end

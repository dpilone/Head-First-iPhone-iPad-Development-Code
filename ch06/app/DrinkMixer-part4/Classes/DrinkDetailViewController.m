//
//  DrinkDetailViewController.m
//  DrinkMixer
//
//  Created by Dan Pilone on 12/14/10.
//  Copyright 2010 Element 84, LLC. All rights reserved.
//

#import "DrinkDetailViewController.h"
#import "DrinkConstants.h"

@implementation DrinkDetailViewController

@synthesize drink=drink_, nameTextField=nameTextField_, ingredientsTextView=ingredientsTextView_, directionsTextView=directionsTextView_;
@synthesize scrollView=scrollView_;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Set the scroll view's content size to be our view's size
	self.scrollView.contentSize = self.view.frame.size;
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	// Setup our UI with the provided drink
	self.nameTextField.text =		[self.drink objectForKey:NAME_KEY];
	self.ingredientsTextView.text = [self.drink objectForKey:INGREDIENTS_KEY];
	self.directionsTextView.text =	[self.drink objectForKey:DIRECTIONS_KEY];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[nameTextField_ release];
	[ingredientsTextView_ release];
	[directionsTextView_ release];
	[scrollView_ release];
	[drink_ release];
	
    [super dealloc];
}


@end

    //
//  AddDrinkViewController.m
//  DrinkMixer
//
//  Created by Dan Pilone on 1/2/11.
//  Copyright 2011 Element 84, LLC. All rights reserved.
//

#import "AddDrinkViewController.h"
#import "DrinkConstants.h"


@implementation AddDrinkViewController
@synthesize drinkArray=drinkArray_;

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
																						   target:self action:@selector(cancel:)] autorelease];
	
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave 
																							target:self action:@selector(save:)] autorelease];
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	NSLog(@"%@", @"Registering for keyboard events...");
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
	keyboardVisible_ = NO;
}

- (void) viewWillDisappear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	NSLog(@"%@", @"Unregistering for keyboard events...");
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Keyboard handlers

- (void) keyboardDidShow:(NSNotification *)notif {
	NSLog(@"%@", @"Received UIKeyboardDidShowNotification");
	
	if (keyboardVisible_) {
		NSLog(@"%@", @"Keyboard is already visible.  Ignoring notifications.");
		return;
	}
	
	// The keyboard wasn't visible before
	NSLog(@"Resizing smaller for keyboard");
	
	// Get the origin of the keyboard when it finishes animating
	NSDictionary *info = [notif userInfo];
	NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
	
	// Get the top of the keyboard in view's coordinate system. 
	// We need to set the bottom of the scrollview to line up with it
	CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
	CGFloat keyboardTop = keyboardRect.origin.y;

	// Resize the scroll view to make room for the keyboard
    CGRect viewFrame = self.view.bounds;
	viewFrame.size.height = keyboardTop - self.view.bounds.origin.y;
	
	self.scrollView.frame = viewFrame;
	keyboardVisible_ = YES;
}

- (void) keyboardDidHide:(NSNotification *)notif {
	NSLog(@"%@", @"Received UIKeyboardDidHideNotification");
	
	if (!keyboardVisible_) {
		NSLog(@"%@", @"Keyboard already hidden.  Ignoring notification.");
		return;
	}
	
	// The keyboard was visible
	NSLog(@"%@", @"Resizing bigger with no keyboard");

	// Resize the scroll view back to the full size of our view
	self.scrollView.frame = self.view.bounds;
	keyboardVisible_ = NO;
}

#pragma mark -
#pragma mark Save and Cancel

- (IBAction) save: (id) sender {
	NSLog(@"%@", @"Save pressed!");
	
	if (self.drink != nil) {
		// We're working with an existing drink, so let's remove
		// it from the array and just recreate it like we would a new
		// drink...
		[drinkArray_ removeObject:self.drink];
		self.drink = nil; // This will release our reference and set the property to nil
	}
	
	// Create a new drink dictionary for the new values
	NSMutableDictionary *newDrink = [[NSMutableDictionary alloc] init];
	[newDrink setValue:self.nameTextField.text forKey:NAME_KEY];
	[newDrink setValue:self.ingredientsTextView.text forKey:INGREDIENTS_KEY];
	[newDrink setValue:self.directionsTextView.text forKey:DIRECTIONS_KEY];
	
	// Add it to the master drink array and release our reference
	[drinkArray_ addObject:newDrink];
	[newDrink release];
	
	// Sort the array since we just added a new drink
	NSSortDescriptor *nameSorter = [[NSSortDescriptor alloc] initWithKey:NAME_KEY ascending:YES selector:@selector(caseInsensitiveCompare:)];
	[drinkArray_ sortUsingDescriptors:[NSArray arrayWithObject:nameSorter]];
	[nameSorter release];
	
	// Pop the modal view and go back to the list
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction) cancel: (id) sender {
	NSLog(@"%@", @"Cancel pressed!");
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -


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
	[drinkArray_ release];
    [super dealloc];
}


@end

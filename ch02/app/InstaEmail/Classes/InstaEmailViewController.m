//
//  InstaEmailViewController.m
//  InstaEmail
//
//  Created by Dan Pilone on 11/12/10.
//  Copyright 2010 Element 84, LLC. All rights reserved.
//

#import "InstaEmailViewController.h"

@implementation InstaEmailViewController

@synthesize emailPicker=emailPicker_;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	activities_ = [[NSArray alloc] initWithObjects:@"sleeping", @"eating", @"working", @"thinking",
				  @"crying", @"begging", @"leaving", @"shopping", @"hello worlding", nil];
	feelings_ = [[NSArray alloc] initWithObjects:@"awesome", @"sad", @"happy", @"ambivalent", @"nauseous",
				@"psyched", @"confused", @"hopeful", @"anxious", nil];
}

#pragma mark -
#pragma mark Picker Datasource Protocol

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	if (component == 0) {
		return [activities_ count];
	}
	else {
		return [feelings_ count];
	}
}

#pragma mark -
#pragma mark Picker Delegate Protocol

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if (component == 0) {
		return [activities_ objectAtIndex:row];
	}
	else {
		return [feelings_ objectAtIndex:row];
	}
}

#pragma mark -
#pragma mark Actions

- (IBAction) sendButtonTapped: (id) sender {
	NSLog(@"%@", @"Email button tapped!");

	NSString *theMessage = [NSString stringWithFormat:@"I'm %@ and feeling %@ about it.",
							[activities_ objectAtIndex:[emailPicker_ selectedRowInComponent:0]],
							[feelings_ objectAtIndex:[emailPicker_ selectedRowInComponent:1]]];
	
	NSLog(@"%@", theMessage);
	
	if ([MFMailComposeViewController canSendMail]) {
		MFMailComposeViewController* mailController = [[MFMailComposeViewController alloc] init];
		mailController.mailComposeDelegate = self;
		[mailController setSubject:@"Hello Renee!"];
		[mailController setMessageBody:theMessage isHTML:NO]; 
		[self presentModalViewController:mailController animated:YES];
		[mailController release];
	}
	else {
		NSLog(@"%@", @"Sorry, you need to setup mail first!");
	}
}

#pragma mark -
#pragma mark Mail composer delegate method

- (void)mailComposeController:(MFMailComposeViewController*)controller  
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError*)error;
{
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[emailPicker_ release];
	[activities_ release];
	[feelings_ release];
    [super dealloc];
}

@end

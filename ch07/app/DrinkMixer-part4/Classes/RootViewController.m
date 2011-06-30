//
//  RootViewController.m
//  DrinkMixer
//
//  Created by Dan Pilone on 11/28/10.
//  Copyright 2010 Element 84, LLC. All rights reserved.
//

#import "RootViewController.h"
#import "DrinkDetailViewController.h"
#import "AddDrinkViewController.h"
#import "DrinkConstants.h"

@implementation RootViewController

@synthesize drinks=drinks_, addButton=addButton_, splitViewDetailView=splitViewDetailView_;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"DrinkDirections" ofType:@"plist"];
	drinks_ = [[NSMutableArray alloc] initWithContentsOfFile:path];
	
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	self.navigationItem.rightBarButtonItem = self.addButton;
	
	// Register for application backgrounding information so we can save data
	[[NSNotificationCenter defaultCenter] addObserver:self
										  selector:@selector(applicationDidEnterBackground:)
										  name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.tableView reloadData];
}

- (void) applicationDidEnterBackground:(NSNotification *)notification {
	NSLog(@"%@", @"Backgrounding.. should save.");
	NSString *path = [[NSBundle mainBundle] pathForResource:@"DrinkDirections" ofType:@"plist"];
	[self.drinks writeToFile:path atomically:YES];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/

/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/


 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return YES;
}



#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.drinks count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	cell.textLabel.text = [[self.drinks objectAtIndex:indexPath.row] objectForKey:NAME_KEY];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
		[self.drinks removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}



/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark -
#pragma mark Actions

- (IBAction) addButtonPressed: (id) sender {
	NSLog(@"%@", @"Add button pressed.");
	
	AddDrinkViewController *addViewController = [[AddDrinkViewController alloc] initWithNibName:@"DrinkDetailViewController" bundle:nil];
	addViewController.drinkArray = self.drinks;
	
	UINavigationController *addNavController = [[UINavigationController alloc] initWithRootViewController:addViewController];
	[self presentModalViewController:addNavController animated:YES];
	[addViewController release];
	[addNavController release];
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (!self.editing) {
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
			[self.splitViewDetailView drinkChanged:[self.drinks objectAtIndex:indexPath.row]];
		}
		else {
			DrinkDetailViewController *detailViewController = [[DrinkDetailViewController alloc] initWithNibName:@"DrinkDetailViewController" bundle:nil];
			detailViewController.drink = [self.drinks objectAtIndex:indexPath.row];
			[self.navigationController pushViewController:detailViewController animated:YES];
			[detailViewController release];
		}
	}
	else {
		AddDrinkViewController *editingDrinkVC = [[AddDrinkViewController alloc] initWithNibName:@"DrinkDetailViewController" bundle:nil];
		editingDrinkVC.drink = [self.drinks objectAtIndex:indexPath.row];
		editingDrinkVC.drinkArray = self.drinks;
		
		UINavigationController *editingNavCon = [[UINavigationController alloc] initWithRootViewController:editingDrinkVC];
		[self.navigationController presentModalViewController:editingNavCon animated:YES];
		[editingDrinkVC release];
		[editingNavCon release];
	}
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)dealloc {
	[splitViewDetailView_ release];
	[drinks_ release];
	[addButton_ release];
	
    [super dealloc];
}


@end


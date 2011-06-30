//
//  RootViewController.h
//  DrinkMixer
//
//  Created by Dan Pilone on 11/28/10.
//  Copyright 2010 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DrinkDetailViewController;
@interface RootViewController : UITableViewController {
	NSMutableArray *drinks_;
	UIBarButtonItem *addButton_;
	DrinkDetailViewController *splitViewDetailView_;
}

@property (nonatomic, retain) NSMutableArray *drinks;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *addButton;
@property (nonatomic, retain) IBOutlet DrinkDetailViewController *splitViewDetailView;

- (IBAction) addButtonPressed: (id) sender;

@end

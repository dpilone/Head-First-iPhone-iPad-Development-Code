//
//  RootViewController.h
//  DrinkMixer
//
//  Created by Dan Pilone on 11/28/10.
//  Copyright 2010 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {
	NSMutableArray *drinks_;
	UIBarButtonItem *addButton_;
}

@property (nonatomic, retain) NSMutableArray *drinks;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *addButton;

- (IBAction) addButtonPressed: (id) sender;

@end

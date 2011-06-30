//
//  AddDrinkViewController.h
//  DrinkMixer
//
//  Created by Dan Pilone on 1/2/11.
//  Copyright 2011 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DrinkDetailViewController.h"


@interface AddDrinkViewController : DrinkDetailViewController {
	BOOL keyboardVisible_;
}

- (IBAction) save: (id) sender;
- (IBAction) cancel: (id) sender;

- (void) keyboardDidShow:(NSNotification *)notif;
- (void) keyboardDidHide:(NSNotification *)notif;

@end

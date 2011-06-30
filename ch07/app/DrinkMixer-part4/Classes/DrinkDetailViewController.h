//
//  DrinkDetailViewController.h
//  DrinkMixer
//
//  Created by Dan Pilone on 12/14/10.
//  Copyright 2010 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DrinkDetailViewController : UIViewController <UISplitViewControllerDelegate> {
@private
	UITextField *nameTextField_;
	UITextView *ingredientsTextView_;
	UITextView *directionsTextView_;
	UIScrollView *scrollView_;
	NSDictionary *drink_;
    UIPopoverController *popOver_;
}

@property (nonatomic, retain) IBOutlet UITextField *nameTextField;
@property (nonatomic, retain) IBOutlet UITextView *ingredientsTextView;
@property (nonatomic, retain) IBOutlet UITextView *directionsTextView;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) NSDictionary *drink;
@property (nonatomic, retain) UIPopoverController *popOver;

- (void) refreshView;
- (void) drinkChanged:(NSDictionary *)newDrink;

@end

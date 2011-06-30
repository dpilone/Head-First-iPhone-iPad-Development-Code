//
//  InstaEmailViewController.h
//  InstaEmail
//
//  Created by Dan Pilone on 11/12/10.
//  Copyright 2010 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface InstaEmailViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, MFMailComposeViewControllerDelegate> {
	UIPickerView *emailPicker_;
	NSArray *activities_;
	NSArray *feelings_;
	UITextField *notesField_;
}

@property (nonatomic, retain) IBOutlet UIPickerView *emailPicker;
@property (nonatomic, retain) IBOutlet UITextField *notesField;

- (IBAction) sendButtonTapped: (id) sender;
- (IBAction) textFieldDoneEditing: (id) sender;

@end


//
//  FugitiveDetailViewController.h
//  iBountyHunter
//
//  Created by Dan Pilone on 2/20/11.
//  Copyright 2011 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Fugitive.h"

@interface FugitiveDetailViewController : UIViewController {
@private
    Fugitive *fugitive_;
    UILabel *nameLabel_;
    UILabel *idLabel_;
    UITextView *descriptionTextView_;
    UILabel *bountyLabel_;
}

@property (nonatomic, retain) Fugitive *fugitive;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *idLabel;
@property (nonatomic, retain) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, retain) IBOutlet UILabel *bountyLabel;

@end

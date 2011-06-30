//
//  CapturedPhotoViewController.h
//  iBountyHunter
//
//  Created by Dan Pilone on 3/27/11.
//  Copyright 2011 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Fugitive.h"

@interface CapturedPhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
@private
    UIImageView *fugitiveImage_;
    Fugitive *fugitive_;
}

@property (nonatomic, retain) IBOutlet UIImageView *fugitiveImage;
@property (nonatomic, retain) IBOutlet Fugitive *fugitive;

- (IBAction) doneButtonPressed;
- (IBAction) takePictureButtonPressed;

@end

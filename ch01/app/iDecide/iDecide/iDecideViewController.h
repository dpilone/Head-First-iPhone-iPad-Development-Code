//
//  iDecideViewController.h
//  iDecide
//
//  Created by Tracey Pilone on 7/1/11.
//  Copyright 2011 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iDecideViewController : UIViewController {
    UILabel *decisionText_;
    
}
@property (retain, nonatomic) IBOutlet UILabel *decisionText;

-(IBAction)buttonPressed:(id)sender;

@end

//
//  iDecideAppDelegate.h
//  iDecide
//
//  Created by Tracey Pilone on 7/1/11.
//  Copyright 2011 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iDecideViewController;

@interface iDecideAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet iDecideViewController *viewController;

@end

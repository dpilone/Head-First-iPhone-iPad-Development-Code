//
//  InstaEmailAppDelegate.h
//  InstaEmail
//
//  Created by Dan Pilone on 11/12/10.
//  Copyright 2010 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InstaEmailViewController;

@interface InstaEmailAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    InstaEmailViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet InstaEmailViewController *viewController;

@end


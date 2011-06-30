//
//  iBountyHunterAppDelegate_iPhone.h
//  iBountyHunter
//
//  Created by Dan Pilone on 2/14/11.
//  Copyright 2011 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iBountyHunterAppDelegate.h"

@interface iBountyHunterAppDelegate_iPhone : iBountyHunterAppDelegate {
    UITabBarController *tabBarController_;
}

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end

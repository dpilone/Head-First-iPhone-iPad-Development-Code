//
//  iBountyHunterAppDelegate_iPhone.m
//  iBountyHunter
//
//  Created by Dan Pilone on 2/14/11.
//  Copyright 2011 Element 84, LLC. All rights reserved.
//

#import "iBountyHunterAppDelegate_iPhone.h"

@implementation iBountyHunterAppDelegate_iPhone

@synthesize tabBarController=tabBarController_;

- (void)dealloc
{
    [tabBarController_ release];
	[super dealloc];
}

@end

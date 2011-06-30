//
//  Fugitive.h
//  iBountyHunter
//
//  Created by Dan Pilone on 3/27/11.
//  Copyright (c) 2011 Element 84, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import <MapKit/MapKit.h>

@interface Fugitive : NSManagedObject <MKAnnotation> {
@private
}
@property (nonatomic, retain) NSDecimalNumber * bounty;
@property (nonatomic, retain) NSNumber * captured;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSNumber * fugitiveID;
@property (nonatomic, retain) NSDate * captdate;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * capturedLat;
@property (nonatomic, retain) NSNumber * capturedLon;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (NSString *) title;
- (NSString *) subtitle;

@end

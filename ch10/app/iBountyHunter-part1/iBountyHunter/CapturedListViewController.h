//
//  CapturedListViewController.h
//  iBountyHunter
//
//  Created by Dan Pilone on 2/20/11.
//  Copyright 2011 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CapturedListViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
@private
    NSFetchedResultsController *resultsController_;
}

@property (nonatomic, readonly) NSFetchedResultsController *resultsController;

@end

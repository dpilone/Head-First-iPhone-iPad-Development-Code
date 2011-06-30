//
//  FugitiveListViewController.h
//  iBountyHunter
//
//  Created by Dan Pilone on 2/20/11.
//  Copyright 2011 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FugitiveDossierViewController;


@interface FugitiveListViewController : UITableViewController {
@private
    NSMutableArray *items_;
    FugitiveDossierViewController *dossierView_;
}

@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) IBOutlet FugitiveDossierViewController *dossierView;

@end

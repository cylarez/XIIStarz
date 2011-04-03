//
//  HistoryViewController.h
//  XIIStarz
//
//  Created by sylvain NICOLLE on 11-04-02.
//  Copyright 2011 XIIStarz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpressionAppDelegate.h"
#import "Entry.h"
#import "QRCodeViewController.h"
#import "DetailHistoryViewController.h"

@interface HistoryViewController : UITableViewController {
    NSManagedObjectContext *managedObjectContext;
    NSMutableArray *entryArray;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext; 
@property (nonatomic, retain) NSMutableArray *entryArray;

- (void)fetchRecords;

@end

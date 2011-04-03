//
//  ProjectsViewController.h
//  Expression
//
//  Created by sylvain NICOLLE on 10-10-17.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailProjectViewController.h"
#import "JSON.h"
#import "ExpressionAppDelegate.h"



@interface ProjectsViewController : UITableViewController {
	NSArray *projects;
	ExpressionAppDelegate *appDelegate;
	NSIndexPath *selectedRowIndexPath;
}

@property (nonatomic, retain) NSArray *projects;
@property (nonatomic, retain) NSIndexPath *selectedRowIndexPath;

- (void) launchProjectImage;


@end

//
//  ProjectsViewController.m
//  Expression
//
//  Created by sylvain NICOLLE on 10-10-17.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ProjectsViewController.h"


@implementation ProjectsViewController

@synthesize projects, selectedRowIndexPath;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
	
	appDelegate = [[[UIApplication sharedApplication] delegate] retain];
	projects = appDelegate.projects;
	
	[self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]]];
	[super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
	
	self.navigationItem.title = @"Projects";	
	//[self.tableView	reloadData];
    [super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
	if (selectedRowIndexPath) {
		UITableViewCell  *cell = [self.tableView cellForRowAtIndexPath:selectedRowIndexPath];
		UIActivityIndicatorView *activityView = (UIActivityIndicatorView *) cell.accessoryView;
		[activityView stopAnimating];
	}
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.projects count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.

	NSArray *sectionSelected	=	[self.projects objectAtIndex:section];
	NSArray *sectionData		=	[sectionSelected valueForKey:@"data"];
	
	return [sectionData count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	NSArray *sectionSelected	=	[self.projects objectAtIndex:indexPath.section];
	NSArray *sectionData		=	[sectionSelected valueForKey:@"data"];
	NSDictionary *project		=	[sectionData objectAtIndex:indexPath.row];
	cell.imageView.image		=	[project valueForKey:@"thumb2"];
    cell.textLabel.text			=	[project valueForKey:@"name"];

    return cell;
}

//- (UITableViewCellAccessoryType)tableView:(UITableView *)tv accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
//	return UITableViewCellAccessoryDetailDisclosureButton;
//}

// Custom Headers
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
	UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)] autorelease];

	UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 3, tableView.bounds.size.width - 10, 30)] autorelease];
	
	NSArray *sectionSelected		=	[self.projects objectAtIndex:section];
	
	label.text	=	[sectionSelected valueForKey:@"name"];
	label.textColor = [UIColor colorWithRed :255 green:255 blue:255 alpha:0.8];
	label.backgroundColor = [UIColor clearColor];
	[headerView addSubview:label];
	
	return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{	
	return 30;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	
	UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	[activityView startAnimating];
	[cell setAccessoryView:activityView];
	[activityView release];
	
	self.selectedRowIndexPath	=	[self.tableView indexPathForSelectedRow];
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
	
	[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(launchProjectImage) userInfo:nil repeats:NO];
	
}

- (void)launchProjectImage {
	
	NSIndexPath *indexPath		=	self.selectedRowIndexPath;
	NSArray *sectionSelected	=	[self.projects objectAtIndex:indexPath.section];
	NSArray *sectionData		=	[sectionSelected valueForKey:@"data"];
	NSDictionary *project		=	[sectionData objectAtIndex:indexPath.row];
    
    DetailProjectViewController *detailProjectViewController = [[DetailProjectViewController alloc] initWithNibName:@"DetailProjectViewController" bundle:[NSBundle mainBundle]];
	
	detailProjectViewController.linkImage   =  [project valueForKey:@"image"];
    detailProjectViewController.linkName    = [project valueForKey:@"name"];
    
	detailProjectViewController.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:detailProjectViewController animated:YES];
	[detailProjectViewController release];
	detailProjectViewController = nil; 
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[projects release];
	[selectedRowIndexPath release];
    [super dealloc];
}


@end


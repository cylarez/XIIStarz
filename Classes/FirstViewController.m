//
//  FirstViewController.m
//  Expression
//
//  Created by sylvain NICOLLE on 10-10-03.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"

// Test Git

@implementation FirstViewController

@synthesize timer, splashImageView, username, avatar, _fbButton, facebook;

- (IBAction)fbButtonClick:(id)sender
{
	if (_fbButton.isLoggedIn) {
		[facebook logout:self];
	} else {
		NSArray* permissions =  [[NSArray arrayWithObjects:
								  @"email", @"read_stream", nil] retain];
		[facebook authorize:permissions delegate:self];
        [permissions release];
	}
}

// Handle FB GRAPH API requests
- (void)request:(FBRequest *)request didLoad:(id)result {
	
	NSLog(@"FB request");
	
	if ([result isKindOfClass:[NSData class]]) {
        UIImage* profilePicture = [[UIImage alloc] initWithData: result];
		[self.avatar setImage:profilePicture];
		
    }
	
	if ([result isKindOfClass:[NSDictionary class]]) {
		if ([result objectForKey:@"name"]) {
			[self.username setText:[result objectForKey:@"name"]];
		}
	}
};

- (void)fbDidLogin
{
	NSLog(@"fb login");
	_fbButton.isLoggedIn = YES;
	[facebook requestWithGraphPath:@"me" andDelegate:self];
	[facebook requestWithGraphPath:@"me/picture" andDelegate:self];
	avatar.hidden = NO;
	username.hidden = NO;
	[_fbButton updateImage];
}

- (void)fbDidLogout
{
	_fbButton.isLoggedIn = NO;
	avatar.hidden = YES;
	username.hidden = YES;
	[_fbButton updateImage];
}

/*
- (void)viewDidAppear:(BOOL)animated
{
	NSLog(@"appear!");
	
	if ([facebook isSessionValid]) {
		[self fbDidLogin];
	} else {	
		[self fbDidLogout];
	}
	[_fbButton updateImage];
    [super viewDidAppear:animated];	
}
*/
 
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


- (void)fadeScreen
{
	[UIView beginAnimations:nil context:nil]; // begins animation block
	[UIView setAnimationDuration:0.75];        // sets animation duration
	[UIView setAnimationDelegate:self];        // sets delegate for this block
	[UIView setAnimationDidStopSelector:@selector(finishedFading)];   // calls the finishedFading method when the animation is done (or done fading out)	
	self.view.alpha = 0.0;       // Fades the alpha channel of this view to "0.0" over the animationDuration of "0.75" seconds
	[UIView commitAnimations];   // commits the animation block.  This Block is done.
}


- (void) finishedFading
{
	[UIView beginAnimations:nil context:nil]; // begins animation block
	[UIView setAnimationDuration:0.75];        // sets animation duration
	self.view.alpha = 1.0;   // fades the view to 1.0 alpha over 0.75 seconds
	//viewController.view.alpha = 1.0;
	[UIView commitAnimations];   // commits the animation block.  This Block is done.
	[splashImageView removeFromSuperview];
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	//[self viewDidLoad];
	
	appDelegate = [[[UIApplication sharedApplication] delegate] retain];
	facebook = appDelegate.facebook;

	[self fbDidLogout];
	NSLog(@"Did Load");
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end

//
//  DetailProjectViewController.m
//  Expression
//
//  Created by sylvain NICOLLE on 10-10-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DetailProjectViewController.h"



@implementation DetailProjectViewController

@synthesize linkImage, linkName;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSURL *url = [NSURL URLWithString: linkImage];
	NSData *data = [NSData dataWithContentsOfURL:url];
	UIImage *img = [[UIImage alloc] initWithData:data];
	
    self.navigationItem.title= linkName;
    
	[projectImage setImage:img];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (IBAction)showNavigationBar:(id)sender {
	//[self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
    UITouch *touch = [touches anyObject];
	
    if ([touch view] == projectImage)
    {
		NSLog(@"TOUCH!!");

		[self.navigationController setNavigationBarHidden:(self.navigationController.navigationBarHidden ? NO : YES) animated:YES];
		//add your code for image touch here 
    }
	
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

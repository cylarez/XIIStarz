    //
//  FindUsViewController.m
//  Expression
//
//  Created by sylvain NICOLLE on 10-10-03.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FindUsViewController.h"
#import <MapKit/MapKit.h>


@implementation FindUsViewController

@synthesize currentView, mapButton, annotation;

- (IBAction)loadMap:(id)sender {

	if (mapButton.titleLabel.text != @"Close") {
		NSLog(@"loading map...");
		[mapButton setTitle:@"Close" forState:(UIControlState)UIControlStateNormal];
		CGRect CellFrame = CGRectMake(5, 5, 310, 350);
		
		mapView=[[MKMapView alloc] initWithFrame:CellFrame];
		[mapView setMapType:MKMapTypeStandard];
        [mapView setZoomEnabled:YES];
        [mapView setScrollEnabled:YES];
		
        MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } }; 
        region.center.latitude = 34.062312;
        region.center.longitude = -118.346679;
        region.span.longitudeDelta = 0.01f;
        region.span.latitudeDelta = 0.01f;
        [mapView setRegion:region animated:YES]; 
        
        annotation = [[DisplayMap alloc] init]; 
        annotation.title = @" XII Starz";
        annotation.subtitle = @"5405 Wilshire Blvd. S Los Angeles"; 
        annotation.coordinate = region.center; 
		
		NSLog(@"display map");
        [mapView addAnnotation:annotation];
		NSArray* annotations = [[NSArray alloc] initWithObjects:annotation, nil];
		[mapView setSelectedAnnotations:annotations];
        [annotations release];
		[currentView addSubview:mapView];
		
	} else {
		NSLog(@"Close map...");
		[mapButton setTitle:@"Map" forState:(UIControlState)UIControlStateNormal];
		[mapView removeFromSuperview];
	}
}

- (IBAction) loadEmailView
{
    
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setSubject:@"Information"];
    [controller setMessageBody:@"Hello there." isHTML:NO]; 
    [controller setToRecipients:[NSArray arrayWithObject:@"info@12starz.com"]];   
    if (controller) [self presentModalViewController:controller animated:YES];
    [controller release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller  
didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
	NSLog(@"Finish Loading Map");
}



/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	appDelegate = (ExpressionAppDelegate *)[[UIApplication sharedApplication] delegate];
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
    [mapView release];
    [super dealloc];
}


@end

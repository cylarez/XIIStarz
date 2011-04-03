//
//  DetailHistoryViewController.m
//  XIIStarz
//
//  Created by sylvain NICOLLE on 11-04-03.
//  Copyright 2011 XIIStarz. All rights reserved.
//

#import "DetailHistoryViewController.h"


@implementation DetailHistoryViewController

@synthesize entry;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"MMM dd, yyyy HH:mm"];
	}
    
    url.text = entry.url;
    date.text = [dateFormatter stringFromDate: entry.date];
    
    // Restore Image
    UIImage * newImage = [UIImage imageWithData:entry.image] ; 
    [image setImage:newImage];
    
    // Set Map
    [self setMap];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) setMap
{
    
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } }; 
    
    
    region.center.latitude = [entry.latitude doubleValue];
    region.center.longitude = [entry.longitude doubleValue];
    region.span.longitudeDelta = 0.01f;
    region.span.latitudeDelta = 0.01f;
    [map setRegion:region animated:YES]; 
    
    annotation = [[DisplayMap alloc] init]; 
    annotation.title = @"Scanned Here!";
    annotation.subtitle = entry.url; 
    annotation.coordinate = region.center; 
    
    NSLog(@"display map");
    [map addAnnotation:annotation];
    NSArray* annotations = [[NSArray alloc] initWithObjects:annotation, nil];
    [map setSelectedAnnotations:annotations];
    [annotations release];
}

-(IBAction) loadCodeUrl
{
	QRCodeUrlViewController *urlViewController	=	[[QRCodeUrlViewController alloc] initWithNibName:@"QRCodeUrlViewController" bundle:[NSBundle mainBundle]];
	urlViewController.codeUrl = entry.url;
    
	[self.navigationController pushViewController:urlViewController animated:YES];
    
	[urlViewController release];
	urlViewController = nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

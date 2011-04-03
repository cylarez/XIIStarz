//
//  QRCodeViewController.m
//  XIIStarz
//
//  Created by sylvain NICOLLE on 11-02-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QRCodeViewController.h"


@implementation QRCodeViewController

@synthesize btLaunchScan, resultText, resultImage, managedObjectContext, entryArray;

-(IBAction)launchScan:(id)sender
{	
	// ADD: present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
	
    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here
	
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
				   config: ZBAR_CFG_ENABLE
					   to: 0];
	
    // present and release the controller
    [self presentModalViewController: reader
							animated: YES];
    [reader release];
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =	[info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    
	for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
	
    // EXAMPLE: do something useful with the barcode data
    resultText.text = symbol.data;
	
    // EXAMPLE: do something useful with the barcode image
    resultImage.image =	[info objectForKey: UIImagePickerControllerOriginalImage];
	
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissModalViewControllerAnimated: YES];
    
    // Insert into database
    [self insertEntry:resultText.text];
    
    // Load Url
	[self loadCodeUrl:resultText.text];
}

-(IBAction) loadCodeUrl:(NSString*)codeUrl 
{
	QRCodeUrlViewController *urlViewController	=	[[QRCodeUrlViewController alloc] initWithNibName:@"QRCodeUrlViewController" bundle:[NSBundle mainBundle]];
	urlViewController.codeUrl = codeUrl;

	[self.navigationController pushViewController:urlViewController animated:YES];

	[urlViewController release];
	urlViewController = nil;
}

-(IBAction) loadHistory
{
    HistoryViewController *historyViewController	=	[[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:[NSBundle mainBundle]];

	[self.navigationController pushViewController:historyViewController animated:YES];
    
	[historyViewController release];
	historyViewController = nil;
    
}

-(void) insertEntry:(NSString*) url
{
    Entry *entry = (Entry *)[NSEntityDescription insertNewObjectForEntityForName:@"Entry" inManagedObjectContext:managedObjectContext];
    [entry setUrl:url];
    [entry setDate: [NSDate date]];
    CLLocation *location = [(ExpressionAppDelegate *)[[UIApplication sharedApplication] delegate] lastKnownLocation];
    [entry setLatitude:[NSNumber numberWithDouble:location.coordinate.latitude]];
    [entry setLongitude:[NSNumber numberWithDouble:location.coordinate.longitude]];
    
    // Save Image

    NSData *data = UIImagePNGRepresentation(resultImage.image);
    [entry setImage:data];
    
    NSError *error;
    
    if (![managedObjectContext save:&error]) {        
    }
    
    [entryArray insertObject:entry atIndex:0];

}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    if (managedObjectContext == nil)
    {
        managedObjectContext = [(ExpressionAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	
	self.btLaunchScan = nil;
	self.resultText = nil;
	self.resultImage = nil;
	
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [managedObjectContext release];  
    [entryArray release]; 
    [super dealloc];
}


@end

//
//  QRCodeUrlViewController.m
//  XIIStarz
//
//  Created by sylvain NICOLLE on 11-03-01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QRCodeUrlViewController.h"


@implementation QRCodeUrlViewController

@synthesize webViewCode, codeUrl, loading;


#pragma mark UIWebView delegate methods

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	[loading startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
	[loading stopAnimating];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	appDelegate = [[[UIApplication sharedApplication] delegate] retain];
	facebook = appDelegate.facebook;
	
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc]
								   initWithTitle:NSLocalizedString(@"share", @"")
								   style:UIBarButtonItemStyleBordered
								   target:self
								   action:@selector(shareUrl)] autorelease];
	self.navigationItem.rightBarButtonItem = addButton;
	
	webViewCode.scalesPageToFit = YES;
	webViewCode.delegate = self;
    
    self.navigationItem.title =codeUrl;

	[self loadUrl: codeUrl];
}

- (void)shareUrl
{
	NSString *url =	[NSString stringWithFormat:@"%@", webViewCode.request.mainDocumentURL];
	
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   @"Share on Facebook",  @"user_message_prompt",
								   url,  @"message",
								   nil];
	
	
	[facebook dialog:@"feed" andParams:params andDelegate:self];	
}

- (void)loadUrl:(id)_url
{
	NSURL *url = [NSURL URLWithString:_url];
	
	//URL Requst Object
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[webViewCode loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}

- (void)dealloc {
	webViewCode.delegate = nil;
	[webViewCode stopLoading];
    [webViewCode release];
    [super dealloc];
}


@end

//
//  QRCodeUrlViewController.h
//  XIIStarz
//
//  Created by sylvain NICOLLE on 11-03-01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpressionAppDelegate.h"


@interface QRCodeUrlViewController : UIViewController <UIWebViewDelegate, FBDialogDelegate> {
	UIWebView *webViewCode;
	NSString *codeUrl;
	UIActivityIndicatorView *loading;
	ExpressionAppDelegate *appDelegate;
	Facebook *facebook;
}

@property(nonatomic, retain) IBOutlet UIWebView *webViewCode;
@property(nonatomic, retain) IBOutlet UIActivityIndicatorView *loading;
@property(nonatomic, retain) NSString *codeUrl;

- (void)loadUrl:(id)_url;

@end

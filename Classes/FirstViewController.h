//
//  FirstViewController.h
//  Expression
//
//  Created by sylvain NICOLLE on 10-10-03.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "FBLoginButton.h"
#import	"ExpressionAppDelegate.h"


@interface FirstViewController : UIViewController <FBRequestDelegate, FBDialogDelegate, FBSessionDelegate> {
	NSTimer *timer;
	UIImageView *splashImageView;
	
	UITextView *username;
	UIImageView *avatar;
	
	Facebook *facebook;
	IBOutlet FBLoginButton* _fbButton;
	ExpressionAppDelegate *appDelegate;
	
	NSUserDefaults *defaults;
}

@property(nonatomic, retain) NSTimer *timer;
@property(nonatomic, retain) UIImageView *splashImageView;

@property (nonatomic, retain) IBOutlet UITextView *username;
@property (nonatomic, retain) IBOutlet UIImageView *avatar;
@property (nonatomic, retain) IBOutlet FBLoginButton *_fbButton;
@property (nonatomic, retain) Facebook *facebook;

- (IBAction)fbButtonClick;

- (void)fbDidLogin;

@end

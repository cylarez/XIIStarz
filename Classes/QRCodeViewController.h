//
//  QRCodeViewController.h
//  XIIStarz
//
//  Created by sylvain NICOLLE on 11-02-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import "QRCodeUrlViewController.h"
#import "Entry.h"
#import "HistoryViewController.h"

@interface QRCodeViewController : UIViewController < UIImagePickerControllerDelegate, UINavigationControllerDelegate, ZBarReaderDelegate > {
	UIButton *btLaunchScan;
	UIImageView *resultImage;
    UITextView *resultText;
    
    NSManagedObjectContext *managedObjectContext;
    NSMutableArray *entryArray;
}

@property(nonatomic, retain) IBOutlet UIButton *btLaunchScan;
@property (nonatomic, retain) IBOutlet UIImageView *resultImage;
@property (nonatomic, retain) IBOutlet UITextView *resultText;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext; 
@property (nonatomic, retain) NSMutableArray *entryArray; 

-(IBAction)launchScan:(id)sender;
-(IBAction)loadCodeUrl:(NSString*)codeUrl ;
-(IBAction)loadHistory;
-(void)insertEntry:(NSString*) url;

@end

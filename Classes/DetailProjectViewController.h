//
//  DetailProjectViewController.h
//  Expression
//
//  Created by sylvain NICOLLE on 10-10-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailProjectViewController : UIViewController {
	IBOutlet UIImageView *projectImage;
	NSString *linkImage;
    NSString *linkName;
}

@property (nonatomic, copy) NSString *linkImage;
@property (nonatomic, copy) NSString *linkName;

- (IBAction)showNavigationBar:(id)sender;

@end

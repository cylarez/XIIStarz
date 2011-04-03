//
//  FindUsViewController.h
//  Expression
//
//  Created by sylvain NICOLLE on 10-10-03.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ExpressionAppDelegate.h"
#import "DisplayMap.h"


@interface FindUsViewController : UIViewController {
	MKMapView *mapView;
	ExpressionAppDelegate *appDelegate;
	IBOutlet UIView *currentView;
	IBOutlet UIButton *mapButton;
	DisplayMap *annotation;
}

@property (nonatomic, retain) IBOutlet UIView *currentView;
@property (nonatomic, retain) IBOutlet UIButton *mapButton;
@property (nonatomic, retain) IBOutlet DisplayMap *annotation;

- (IBAction)loadMap:(id)sender;

@end

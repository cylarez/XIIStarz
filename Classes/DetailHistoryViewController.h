//
//  DetailHistoryViewController.h
//  XIIStarz
//
//  Created by sylvain NICOLLE on 11-04-03.
//  Copyright 2011 XIIStarz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Entry.h"
#import "QRCodeUrlViewController.h"
#import "DisplayMap.h"

@interface DetailHistoryViewController : UIViewController {
    Entry *entry;
    IBOutlet UILabel *url;
    IBOutlet UILabel *date;
    IBOutlet UIImageView *image;
    
    IBOutlet MKMapView *map;
    DisplayMap *annotation;
}

@property(nonatomic, retain) Entry *entry;

-(IBAction) loadCodeUrl;
-(void) setMap;

@end

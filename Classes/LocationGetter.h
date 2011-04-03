//
//  LocationGetter.h
//  XIIStarz
//
//  Created by sylvain NICOLLE on 11-04-02.
//  Copyright 2011 XIIStarz. All rights reserved.
//

#import <uikit/UIKit.h>
#import <coreLocation/CoreLocation.h>

@protocol LocationGetterDelegate
@required
- (void) newPhysicalLocation:(CLLocation *)location;
@end

@interface LocationGetter : NSObject <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    id delegate;
}

- (void)startUpdates;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property(nonatomic , retain) id delegate;
@end
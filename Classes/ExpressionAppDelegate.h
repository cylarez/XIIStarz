//
//  ExpressionAppDelegate.h
//  Expression
//
//  Created by sylvain NICOLLE on 10-10-03.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "LocationGetter.h"

#define _JSON_URL @"http://mobile.12starz.com/projects.php"

#define _APP_ID @"145293638868150"
#define _APP_KEY @"70be5d5593c6d1d0c330d119abfa7324"
#define _SECRET_KEY @"744c31c56905594892b577adc78fc5a8"

@interface ExpressionAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, FBRequestDelegate, FBDialogDelegate, FBSessionDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	NSTimer *timer;
	UIImageView *splashImageView;
	
	Facebook *facebook;

    NSManagedObjectModel *managedObjectModel;
	NSManagedObjectContext *managedObjectContext;	    
	NSPersistentStoreCoordinator *persistentStoreCoordinator;
    LocationGetter *locationGetter;
    CLLocation *lastKnownLocation;
    
    IBOutlet UITabBar *theTabBar;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UITabBar *theTabBar;
@property (nonatomic, retain) Facebook *facebook;

@property(nonatomic, retain) NSTimer *timer;
@property(nonatomic, retain) UIImageView *splashImageView;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) CLLocation *lastKnownLocation;
@property (nonatomic, retain) LocationGetter *locationGetter;

- (NSString *)applicationDocumentsDirectory;

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;


- (NSString *)stringWithUrl:(NSURL *)url;
- (id) objectWithUrl:(NSURL *)url;
- (NSDictionary *) downloadProjects;
- (void) getProjects;
- (void) fadeScreen;
- (void) updateLocation;
- (void) hideTheTabBarWithAnimation:(BOOL) withAnimation;

@property (nonatomic, retain) NSArray *projects;


@end

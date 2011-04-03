//
//  ExpressionAppDelegate.m
//  Expression
//
//  Created by sylvain NICOLLE on 10-10-03.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ExpressionAppDelegate.h"


@implementation ExpressionAppDelegate

@synthesize window, tabBarController, facebook, timer, splashImageView, projects, lastKnownLocation, locationGetter;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

	// Facebook connect
	facebook = [[Facebook alloc] initWithAppId:_APP_ID];
	
	// Add the tab bar controller's view to the window and display.	
    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];
	
	splashImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading.png"]];
	splashImageView.frame = CGRectMake(0, 0, 320, 480);
	[window addSubview:splashImageView];
	
	//[splashImageView removeFromSuperview];
	timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(getProjects) userInfo:nil repeats:NO];
	
    // get our physical location
    [self updateLocation];
    
    return YES;
}

- (void) updateLocation
{
    if (locationGetter == nil) {
        locationGetter = [[LocationGetter alloc] init];
    }
    locationGetter.delegate = self;
    
    [locationGetter startUpdates];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {	
    return [facebook handleOpenURL:url]; 
}

#pragma mark -
#pragma mark Projects Data Loader

- (NSString *)stringWithUrl:(NSURL *)url
{
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
												cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
											timeoutInterval:30];
	NSURLResponse *response;
	NSError *error;
	
	// Make synchronous request
	NSData *urlData = [NSURLConnection sendSynchronousRequest:urlRequest
											returningResponse:&response
														error:&error];
	
 	// Construct a String around the Data from the response
    NSString *str = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
	
    [str autorelease];
    return str;
}

- (id)objectWithUrl:(NSURL *)url
{	
	SBJsonParser *parser = [SBJsonParser new];
    [parser autorelease];
	NSString *jsonString = [self stringWithUrl:url];

	return [parser objectWithString:jsonString];
}

- (NSDictionary *)downloadProjects 
{
	id result = [self objectWithUrl:[NSURL URLWithString:_JSON_URL]];
	NSDictionary *feed = (NSDictionary *)result;

	return feed;
}

- (void)getProjects
{
	// Get projects
	NSDictionary *feed = [self downloadProjects];
	
	// get the array of "stream" from the feed and cast to NSArray
	self.projects = (NSArray *)[feed valueForKey:@"projects"];
	
	// Get all thumbs pre loaded
	for (NSDictionary *s in projects) {
		for (NSDictionary *p in [s valueForKey:@"data"]) {
			NSString *projectImage		=	[p valueForKey:@"image"];
			NSString *projectIcon		=	[projectImage stringByReplacingOccurrencesOfString:@".jpg" withString:@"_thumb.jpg"];
			NSURL *url					=	[NSURL URLWithString: projectIcon];
			NSData *data				=	[NSData dataWithContentsOfURL:url];
			UIImage *img				=	[[UIImage alloc] initWithData:data];
           
			[p setValue:img forKey:@"thumb2"];
            
            [img release];
		}
	}
    
    
	
	[self fadeScreen];
}

#pragma mark -
#pragma mark Image Loading

- (void)fadeScreen
{
	[UIView beginAnimations:nil context:nil]; // begins animation block
	[UIView setAnimationDuration:1];        // sets animation duration
	[UIView setAnimationDelegate:self];        // sets delegate for this block
	[UIView setAnimationDidStopSelector:@selector(finishedFading)];   // calls the finishedFading method when the animation is done (or done fading out)	
	splashImageView.alpha = 0.0;       // Fades the alpha channel of this view to "0.0" over the animationDuration of "0.75" seconds
	[UIView commitAnimations];   // commits the animation block.  This Block is done.
}


- (void) finishedFading
{
	[splashImageView removeFromSuperview];
}


#pragma mark -
#pragma mark UITabBarControllerDelegate methods

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/

/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
	
    NSError *error = nil;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			//abort();
        } 
    }
}


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"History.sqlite"]];
	
	NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }    
	
    return persistentStoreCoordinator;
}

#pragma mark - Location Service

- (void)newPhysicalLocation:(CLLocation *)location {
    
    // Store for later use
    self.lastKnownLocation = location;
    NSLog(@"New Location!  %f %f", location.coordinate.latitude, location.coordinate.longitude);
    
    // Alert user
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Found" message:[NSString stringWithFormat:@"Found New Physical Location.  %f %f", self.lastKnownLocation.coordinate.latitude, self.lastKnownLocation.coordinate.longitude] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    [alert show];
//    [alert release];

}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [tabBarController release];
	[projects release];
    [window release];
    
    [managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];
    
    [super dealloc];
}

@end


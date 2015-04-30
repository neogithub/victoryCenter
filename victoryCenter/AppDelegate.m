//
//  AppDelegate.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 9/23/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "AppDelegate.h"
#import "GAI.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"firstRun"])
        [defaults setBool:YES forKey:@"firstRun"];
    else
        [defaults setBool:NO forKey:@"firstRun"];
    
    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    // Initialize tracker. Replace with your tracking ID.
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-62452557-1"];
    
    return YES;
}



- (void)setUpScreenConnectionNotificationHandlers
{
	NSLog(@"setUpScreenConnectionNotificationHandlers");
    
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	
    [center addObserver:self selector:@selector(handleScreenDidConnectNotification:)
				   name:UIScreenDidConnectNotification object:nil];
    [center addObserver:self selector:@selector(handleScreenDidDisconnectNotification:)
				   name:UIScreenDidDisconnectNotification object:nil];
	[center addObserver:self selector:@selector(screenModeDidChange:)
				   name:UIScreenModeDidChangeNotification object:nil];
}

- (void)handleScreenDidConnectNotification:(NSNotification*)aNotification
{
    //UIScreen *newScreen = [aNotification object];
	//CGRect screenBounds = newScreen.bounds;
	NSLog(@"handleScreenDidConnectNotification");
    if (!self.external_wind)
    {
        [self checkForExistingScreenAndInitializeIfPresent];
        //Set the initial UI for the window.
	}
}

- (void)handleScreenDidDisconnectNotification:(NSNotification*)aNotification
{
	NSLog(@"handleScreenDidDisConnectNotification");
	if (self.external_wind)
    {
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"ScreenRemovedNotification"
		 object:nil
		 userInfo:nil]; // as (NSDictionary*)
		
		// Hide and then delete the window.
        self.external_wind.hidden = YES;
        self.external_wind = nil;
		
		_appendFilenameForExternal = @"";
		_extDisplayConnected = NO;
    }
}

- (void)screenModeDidChange:(NSNotification *)aNotification{
    UIScreen *someScreen = [aNotification object];
    NSLog(@"The screen mode for a screen did change: %@", [someScreen currentMode]);
	
}

#pragma mark - External Monitor Detection
- (void)checkForExistingScreenAndInitializeIfPresent
{
	NSLog(@"There are %lu connected screens.", (unsigned long)[[UIScreen screens] count]);
	
	NSString *t = [NSString stringWithFormat:@"There are %lu connected screens.", (unsigned long)[[UIScreen screens] count]];
    
	UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Screen Connected"
                                                      message:t
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
	if ([[UIScreen screens] count] > 1)
    {
		_extDisplayConnected = YES;
		
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"SyncSlideshowNotification"
		 object:nil
		 userInfo:nil]; // as (NSDictionary*)
		
		//[self setUpScreenConnectionNotificationHandlers];
        // Get the screen object that represents the external display.
        _external_disp = [[UIScreen screens] objectAtIndex:1];
		//_external_disp.overscanCompensation = 3;
        // Get the screen's bounds so that you can create a window of the correct size.
        CGRect screenBounds = _external_disp.bounds;
		_external_disp.overscanCompensation = 3;
        _external_wind = [[UIWindow alloc] initWithFrame:screenBounds];
        _external_wind.screen = _external_disp;
        // Set up initial content to display...
        // Show the window.
        _external_wind.hidden = NO;
		//[_external_wind setBackgroundColor:[UIColor blueColor]];
		_appendFilenameForExternal = @"_ext";
    } else {
		//[_external_wind setBackgroundColor:[UIColor redColor]];
		_extDisplayConnected = NO;
		_appendFilenameForExternal = @"";
	}
}




- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end

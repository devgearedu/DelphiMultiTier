
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------


#import "IOS2AppDelegate.h"
#import "RootViewController.h"
#import "DSProxyExt.h"
#import "users.h"
#import "login.h"




@implementation IOS2AppDelegate

@synthesize window;
@synthesize navigationController,loginView;




#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
    // Add the navigation controller's view to the window and display.
    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];
	[[TCompanyTweet getConnectioninstance] setDelegate:self];
	[TCompanyTweet getConnectioninstance].connectionTimeout = 5;
	[UIApplication sharedApplication].idleTimerDisabled = YES;
	Users * u =[Users getinstance ] ;
	
	u.navigationController = self.navigationController;
	
	
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
	
	
	@try {
		if ([[Users getinstance] isLogged]) {
			
			@try {
				[[Users getinstance] logOut];
		
			}
			@catch (NSException * e) {
				
			}
						
				
			
		}
		
	}
		@finally {
			
			
			if([self.navigationController.topViewController respondsToSelector:@selector(returnToLogin)]) {
				objc_msgSend(self.navigationController.topViewController , @selector(returnToLogin),nil);
			}else{
				if( self.navigationController.topViewController != loginView ){
					
					
					[self.navigationController pushViewController:loginView animated:YES];	}
			}	
			
			
	
			
		
	}
	
	
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
	
	
	
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
	
	
	
}



- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error

{
	if([self.navigationController.topViewController respondsToSelector:@selector(returnToLogin)]) {
		objc_msgSend(self.navigationController.topViewController , @selector(returnToLogin),nil);
	}	
	
	
	
}

- (void)dealloc {
	[TCompanyTweet releaseProxyinstance];
    [TCompanyTweet releaseConnectioninstance];

	[navigationController release];
	[window release];
	[super dealloc];
}


@end


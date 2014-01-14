//
//  AppDelegate.m
//  SampleImageUpload
//
//  Created by  on 1/6/14.
//  Copyright (c) 2014 Name. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    FirstViewController *objFirst =[[FirstViewController alloc]init];
    self.window.rootViewController=objFirst;
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
#pragma mark - Network Indicator
-(void)RemoveNetworkIndicatorLabel:(UIView *)view
{
    [AppDelegate HideNetworkStatus];
	[MBProgressHUD hideHUDForView:view animated:YES];
}

-(void)ShowImNetWorkIndicator:(UIView *) view
{
	[AppDelegate ShowNetworkStatus];
	hud =[MBProgressHUD showHUDAddedTo:view animated:YES];
	hud.labelText=@"Loading";
    
}
+(void)ShowNetworkStatus
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
+(void)HideNetworkStatus
{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
-(void)ShowNetWorkIndicator:(UIView *) view :(NSString *)Message
{
    [self RemoveNetworkIndicatorLabel:view];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	hud =[MBProgressHUD showHUDAddedTo:view animated:YES];
	hud.labelText=Message;
    
}

-(void)ShowNetWorkIndicatoWithLabel:(NSString *)message
{
    [self ShowNetWorkIndicator:self.window :message];
}
-(void)RemoveNetworkIndicator
{
    [self performSelectorOnMainThread:@selector(RemoveNetworkIndicatorLabel:) withObject:self.window waitUntilDone:YES];
}
-(void)UpdateLabel:(NSString *)Message
{
    [AppDelegate ShowNetworkStatus];
	if(hud!=nil && hud.labelText!=nil)
        hud.labelText=Message;
    
}
+(AppDelegate *)GetDelegate
{
    return (AppDelegate*)[[UIApplication sharedApplication]delegate];
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
}

@end

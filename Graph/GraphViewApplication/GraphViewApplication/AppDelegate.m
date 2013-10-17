//
//  AppDelegate.m
//  GraphViewApplication
//
//  Created by b.dalby.thoomkuzhy on 9/5/13.
//  Copyright (c) 2013 praseeda.manissery. All rights reserved.
//

#import "AppDelegate.h"

//#import "ViewController.h"
//#import "GraphUI.h"

@implementation AppDelegate
@synthesize values,keys;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  //  NSMutableDictionary *valueKeyPair=[[NSMutableDictionary alloc]init];
    
//    [valueKeyPair setObject:@"10" forKey:@"Data1"];
//    [valueKeyPair setObject:@"20" forKey:@"Data2"];
//    [valueKeyPair setObject:@"30" forKey:@"Data3"];
//    [valueKeyPair setObject:@"40" forKey:@"Data4"];
//    [valueKeyPair setObject:@"50" forKey:@"Data5"];
   
    //Data points to be plotted
    values=[[NSArray alloc]initWithObjects:@"10",@"200",@"180",@"40",@"220", nil];
    keys=[[NSArray alloc]initWithObjects:@"data1",@"data2",@"data3",@"data4",@"data5", nil];
       //NSMutableArray *datapointList=[[NSMutableArray alloc]init];
        
    NSLog(@"size o each is %d and %d",[values count],[keys count]);
    
   
    graphView = [[GraphViewUI alloc] init ];

    
     
    self.navigationController=[[UINavigationController alloc]initWithRootViewController:[graphView Invoke:values LabelValueList:keys]];
    [self.navigationController setNavigationBarHidden:YES];
    self.window.rootViewController = self.navigationController;

    
    [self.window makeKeyAndVisible];
    
    return YES;
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

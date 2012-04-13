//
//  FacebookPhotoBrowserAppDelegate.m
//  FacebookPhotoBrowser
//
//  Created by Purnama Santo on 2/23/12.
//  Copyright (c) 2012 Grio. All rights reserved.
//

#import "FacebookPhotoBrowserAppDelegate.h"
#import "FacebookPhotoBrowserViewController.h"


@implementation FacebookPhotoBrowserAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;


- (void)dealloc
{
  [_window release];
  [_viewController release];
    [super dealloc];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

  self.viewController = [[[FacebookPhotoBrowserViewController alloc] initWithNibName:@"FacebookPhotoBrowserViewController" bundle:nil] autorelease];
  self.window.rootViewController = self.viewController;
  [self.window makeKeyAndVisible];
  return YES;
}



@end

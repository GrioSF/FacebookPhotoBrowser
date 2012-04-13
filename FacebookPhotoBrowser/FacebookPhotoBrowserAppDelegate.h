//
//  FacebookPhotoBrowserAppDelegate.h
//  FacebookPhotoBrowser
//
//  Created by Purnama Santo on 2/23/12.
//  Copyright (c) 2012 Grio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookPhotoPickerController.h"

@class FacebookPhotoBrowserViewController;

@interface FacebookPhotoBrowserAppDelegate : UIResponder <UIApplicationDelegate> {
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) FacebookPhotoBrowserViewController *viewController;
@end

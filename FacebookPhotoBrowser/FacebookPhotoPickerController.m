//
//  FacebookPhotoPickerController.m
//  FacebookPhotoBrowser
//
//  Created by Purnama Santo on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FacebookPhotoPickerController.h"
#import "FacebookAlbumsTableController.h"


@implementation FacebookPhotoPickerController

@synthesize facebook = _facebook;


- (id)initWithDelegate:(id<FacebookPhotoPickerControllerDelegate>)delegate {
  self = [super init];
  if (self) {
    _pickerDelegate = delegate;
  }
  return self;
}


- (void)dealloc {
  self.facebook = nil;
  [super dealloc];
}


- (void)loadView {
  [super loadView];

  self.facebook = [[[Facebook alloc] initWithAppId:@"39624508329" andDelegate:self] autorelease];
  
  FacebookAlbumsTableController *table = [[FacebookAlbumsTableController alloc] initWithFacebook:_facebook];
  [self pushViewController:table animated:NO];
}


- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  if ([defaults objectForKey:@"FBAccessTokenKey"] 
      && [defaults objectForKey:@"FBExpirationDateKey"]) {
    _facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
    _facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
  }
  
  if (![_facebook isSessionValid]) {
    // force fb sdk to shows popup within app
//    [_facebook authorizeWithFBAppAuth:NO safariAuth:NO];
    if ([_facebook respondsToSelector:@selector(authorizeWithFBAppAuth:safariAuth:)]) {
      [_facebook performSelector:@selector(authorizeWithFBAppAuth:safariAuth:) withObject:NO withObject:NO];
    }
  }
  else {
    [self showAlbums];
  }
}


- (void)fbDidLogin {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:[_facebook accessToken] forKey:@"FBAccessTokenKey"];
  [defaults setObject:[_facebook expirationDate] forKey:@"FBExpirationDateKey"];
  [defaults synchronize];
  
  [self showAlbums];
}


- (void)fbDidNotLogin:(BOOL)cancelled {
  NSLog(@"didnotlogin: %d", cancelled);
  [_pickerDelegate facebookPhotoPickerControllerDidCancel:self];
}


- (void)showAlbums {
//  [_facebook requestWithGraphPath:@"me/albums" andDelegate:self];

  [(TTModelViewController*)self.topViewController reload];
}


- (void)pickPhoto:(id)photo {
  if (!photo)
    [_pickerDelegate facebookPhotoPickerControllerDidCancel:self];
  else {
    NSDictionary *imageInfo = [NSDictionary dictionaryWithObject:photo forKey:UIImagePickerControllerOriginalImage];
    [_pickerDelegate facebookPhotoPickerController:self didFinishPickingMediaWithInfo:imageInfo];
  }
}


@end


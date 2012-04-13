//
//  FacebookPhotoPickerController.m
//  FacebookPhotoBrowser
//
//  Created by Purnama Santo on 2/23/12.
//  Copyright (c) 2012 Grio. All rights reserved.
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

  // this is the place where you'd replace the app id with yours.
  // you can easily create a constructor that accepts both delegate and app id, like:
  //  initWithDelegate:... andAppId:...
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
    // fb doesn't expose these functions, so we go thru backdoor
    // for more info, see http://blog.grio.com/2012/02/in-app-facebook-authentication-on-ios.html
    if ([_facebook respondsToSelector:@selector(authorizeWithFBAppAuth:safariAuth:)]) {
      NSArray *permissions = [NSArray arrayWithObjects:@"user_photos", nil];
      [_facebook performSelector:@selector(setPermissions:) withObject:permissions];
      [_facebook performSelector:@selector(authorizeWithFBAppAuth:safariAuth:) withObject:NO withObject:NO];
    }
  }
  else {
    [self showAlbums];
  }
}


#pragma mark - FBSessionDelegate

- (void)fbDidLogin {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:[_facebook accessToken] forKey:@"FBAccessTokenKey"];
  [defaults setObject:[_facebook expirationDate] forKey:@"FBExpirationDateKey"];
  [defaults synchronize];
  
  [self showAlbums];
}


- (void)fbDidNotLogin:(BOOL)cancelled {
  [_pickerDelegate facebookPhotoPickerControllerDidCancel:self];
}


- (void)showAlbums {
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


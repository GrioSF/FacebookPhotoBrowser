//
//  FacebookPhoto.m
//  MyFacebookPhotos
//
//  Created by Purnama Santo on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FacebookPhoto.h"

@implementation FacebookPhoto

@synthesize caption = _caption;
@synthesize urlLarge = _urlLarge;
@synthesize urlSmall = _urlSmall;
@synthesize urlThumb = _urlThumb;
@synthesize photoSource = _photoSource;
@synthesize size = _size;
@synthesize index = _index;


- (id)initWithFacebookData:(NSDictionary *)fbData {
  self = [super init];
  if (self) {
    NSLog(@"photo data: %@", fbData);
    self.urlThumb = [fbData objectForKey:@"picture"];
    self.urlLarge = [fbData objectForKey:@"source"];
    int w = [[fbData objectForKey:@"width"] intValue];
    int h = [[fbData objectForKey:@"height"] intValue];
    self.size = CGSizeMake(w, h);

//    self.caption = caption;
    self.index = NSIntegerMax;
    self.photoSource = nil;
  }
  return self;
}

- (void) dealloc {
  self.caption = nil;
  self.urlLarge = nil;
  self.urlSmall = nil;
  self.urlThumb = nil;    
  [super dealloc];
}

#pragma mark TTPhoto

- (NSString*)URLForVersion:(TTPhotoVersion)version {
  switch (version) {
    case TTPhotoVersionLarge:
      return _urlLarge;
    case TTPhotoVersionMedium:
      return _urlLarge;
    case TTPhotoVersionSmall:
      return _urlSmall;
    case TTPhotoVersionThumbnail:
      return _urlThumb;
    default:
      return nil;
  }
}

@end
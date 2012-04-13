//
//  FacebookPhotoSource.h
//  FacebookPhotoBrowser
//  This class encapsulates the facebook photo data source of a particular album.
//
//  Created by Purnama Santo on 2/23/12.
//  Copyright (c) 2012 Grio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"
#import "FBConnect.h"


// loading state of data source
typedef enum {
  idle,
  loading,
  loaded
} LoadState;


@interface FacebookPhotoSource : TTURLRequestModel <TTPhotoSource, FBRequestDelegate> {
  NSArray *_photos;
  Facebook *_facebook;
  NSDictionary *_album;
  LoadState _loadState;
  int _page;
  NSString *_title;
}

- (id)initWithFacebook:(Facebook*)facebook andAlbumInfo:(NSDictionary*)album;

@property (nonatomic, retain) NSArray *photos;

@end
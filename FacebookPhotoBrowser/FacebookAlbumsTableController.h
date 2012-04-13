//
//  FacebookAlbumsTableController.h
//  FacebookPhotoBrowser
//  This table controller manages the list of facebook albums.
//
//  Created by Purnama Santo on 2/23/12.
//  Copyright (c) 2012 Grio. All rights reserved.
//

#import <Three20/Three20.h>
#import "FBConnect.h"
#import "FacebookPhotoPickerController.h"
#import "FacebookPhotoThumbnailViewController.h"


@interface FacebookAlbumsTableController : TTTableViewController <FBRequestDelegate> {
  Facebook *_facebook;
  id<FacebookPhotoPickerControllerDelegate> *_delegate;
}

- (id)initWithFacebook:(Facebook*)facebook;

@end

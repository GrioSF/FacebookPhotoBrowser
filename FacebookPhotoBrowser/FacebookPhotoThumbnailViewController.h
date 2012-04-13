//
//  FacebookPhotoThumbnailViewController.h
//  FacebookPhotoBrowser
//  This view controller displays facebook photos in grid of thumbnails.
//
//  Created by Purnama Santo on 2/23/12.
//  Copyright (c) 2012 Grio. All rights reserved.
//

#import <Three20/Three20.h>
#import "FBConnect.h"
#import "FacebookPhotoPickerController.h"


@interface FacebookPhotoThumbnailViewController : TTThumbsViewController <TTThumbsViewControllerDelegate, TTURLRequestDelegate, FBRequestDelegate> {
  Facebook *_facebook;
  NSDictionary *_album;
  TTActivityLabel *_label;
  TTURLRequest *_request;
}

- (id)initWithFacebook:(Facebook*)facebook andAlbumInfo:(NSDictionary*)album;

@end

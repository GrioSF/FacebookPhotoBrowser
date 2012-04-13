//
//  FacebookPhotoPickerController.h
//  FacebookPhotoBrowser
//
//  Created by Purnama Santo on 2/23/12.
//  Copyright (c) 2012 Grio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"


@class FacebookPhotoPickerController;

/*
 * Application that uses FacebookPhotoPickerController needs to implement this delegate
 * This delegate mimics UIImagePickerControllerDelegate so it's save to refer to its doc for further info.
 */
@protocol FacebookPhotoPickerControllerDelegate

- (void)facebookPhotoPickerController:(FacebookPhotoPickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
- (void)facebookPhotoPickerControllerDidCancel:(FacebookPhotoPickerController *)picker;

@end

///////////////////////////////////////////////////////////////////////////////////////////////////



@interface FacebookPhotoPickerController : UINavigationController <FBSessionDelegate> {
  Facebook *_facebook;
  id _pickerDelegate;
}

@property (nonatomic, retain) Facebook *facebook;

- (id)initWithDelegate:(id<FacebookPhotoPickerControllerDelegate>)delegate;
- (void)showAlbums;
- (void)pickPhoto:(id)photo;
@end




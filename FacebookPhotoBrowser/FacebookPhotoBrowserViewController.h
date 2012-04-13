//
//  FacebookPhotoBrowserViewController.h
//  FacebookPhotoBrowser
//
//  Created by Purnama Santo on 2/23/12.
//  Copyright (c) 2012 Grio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookPhotoPickerController.h"

@interface FacebookPhotoBrowserViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, FacebookPhotoPickerControllerDelegate> {
  IBOutlet UIImageView *_imageView;
}

@property (nonatomic, retain) UIImageView *imageView;

// toolbar buttons
- (IBAction)facebookPhotoLibraryAction:(id)sender;
- (IBAction)cameraAction:(id)sender;

@end

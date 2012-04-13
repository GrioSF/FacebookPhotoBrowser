//
//  FacebookPhotoBrowserViewController.m
//  FacebookPhotoBrowser
//
//  Main view controller that demonstrates the use of FacebookPhotoPickerController
//
//  Created by Purnama Santo on 2/23/12.
//  Copyright (c) 2012 Grio. All rights reserved.
//

#import "FacebookPhotoBrowserViewController.h"


@implementation FacebookPhotoBrowserViewController

@synthesize imageView = _imageView;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


//
// Example of picking image from camera
//
- (IBAction)cameraAction:(id)sender {
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
  {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    [self presentModalViewController:imagePickerController animated:YES];
  }
}


//
// Example of picking image from facebook photo library.
// As you can see, picking an image from facebook is as easy as from a camera library.
//
- (IBAction)facebookPhotoLibraryAction:(id)sender {
  FacebookPhotoPickerController *fbPicker = [[FacebookPhotoPickerController alloc] initWithDelegate:self];
  [self presentModalViewController:fbPicker animated:YES];
}


- (void)dismissPicker:(id)picker {
  [self dismissViewControllerAnimated:YES completion:^(void) {
    [picker release];
  }];
}


#pragma mark UIImagePickerControllerDelegate

//
// this get called when an image has been chosen from the library or taken from the camera
//
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
  [self.imageView setImage:image];
  [self dismissPicker:picker];
}

- (void)imagePickerControllerDidCancel:(id)picker
{
  [self dismissPicker:picker];
}


#pragma mark FacebookPhotoPickerControllerDelegate

//
// this is called when an image is chosne from user's facebook library.
//
- (void)facebookPhotoPickerController:(FacebookPhotoPickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
  [self.imageView setImage:image];
  [self dismissPicker:picker];
}


//
// any cancelation, including user's rejection of installing your fb app, will end up here
//
- (void)facebookPhotoPickerControllerDidCancel:(FacebookPhotoPickerController *)picker {
  [self dismissPicker:picker];
}


@end

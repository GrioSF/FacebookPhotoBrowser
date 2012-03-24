//
//  FacebookPhotoBrowserViewController.m
//  FacebookPhotoBrowser
//
//  Created by Purnama Santo on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
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


- (IBAction)cameraAction:(id)sender {
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
  {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    [self presentModalViewController:imagePickerController animated:YES];
  }
}


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
- (void)facebookPhotoPickerController:(FacebookPhotoPickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
  [self.imageView setImage:image];
  [self dismissPicker:picker];
}

- (void)facebookPhotoPickerControllerDidCancel:(FacebookPhotoPickerController *)picker {
  [self dismissPicker:picker];
}





@end

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

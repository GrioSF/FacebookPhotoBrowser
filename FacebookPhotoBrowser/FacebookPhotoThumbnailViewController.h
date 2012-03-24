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

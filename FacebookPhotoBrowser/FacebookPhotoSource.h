#import <Foundation/Foundation.h>
#import "Three20/Three20.h"
#import "FBConnect.h"


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
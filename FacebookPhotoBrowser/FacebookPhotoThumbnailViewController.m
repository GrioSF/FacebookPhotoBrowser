#import "FacebookPhotoThumbnailViewController.h"
#import "FacebookPhotoSource.h"
#import "FacebookPhoto.h"


@implementation FacebookPhotoThumbnailViewController

- (id)initWithFacebook:(Facebook*)facebook andAlbumInfo:(NSDictionary*)album {
  self = [super init];
  if (self) {
    _facebook = [facebook retain];
    _album = [album retain];
  }
  return self;
}


- (void)dealloc {
  [_facebook release];
  [_album release];
  self.photoSource = nil;
  [super dealloc];
}


- (void)loadView {
  [super loadView];

}


- (void)viewDidLoad {
  _delegate = self;
  self.photoSource = [[[FacebookPhotoSource alloc] initWithFacebook:_facebook
                                                       andAlbumInfo:_album] autorelease];
}


#pragma mark - TTThumbsViewControllerDelegate implementation
- (void)thumbsViewController: (TTThumbsViewController*)controller
              didSelectPhoto: (id<TTPhoto>)photo {
  // download has begun, ignore the selection...
  if (_request)
    return;

  FacebookPhoto *fbPhoto = (FacebookPhoto*)photo;
  NSLog(@"--> %@", fbPhoto.urlLarge);

  TTURLRequest* request = [TTURLRequest requestWithURL:fbPhoto.urlLarge delegate:self];
  request.response = [[[TTURLImageResponse alloc] init] autorelease];
  
  [request send];
}

- (BOOL)thumbsViewController: (TTThumbsViewController*)controller
       shouldNavigateToPhoto: (id<TTPhoto>)photo {
  return NO;
}


- (void)pick:(UIImage*)photo {
  [_label removeFromSuperview];
  [_label release];

  FacebookPhotoPickerController *picker = (FacebookPhotoPickerController*)self.parentViewController;
  [picker pickPhoto:photo];
}


#pragma mark - FBRequestDelegate implementation


/**
 * Called when an error prevents the request from completing successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
  
}

/**
 * Called when a request returns and its response has been parsed into
 * an object.
 *
 * The resulting object may be a dictionary, an array, a string, or a number,
 * depending on thee format of the API response.
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
  if ([result isKindOfClass:[NSDictionary class]]) {
    result = [(NSDictionary*)result objectForKey:@"data"];
    if ([result isKindOfClass:[NSArray class]]) {
      NSArray *data = (NSArray*)result;
      NSMutableArray *items = [[NSMutableArray alloc] init];
      
      for (NSDictionary *photo in data) {
        FacebookPhoto *fbPhoto = [[[FacebookPhoto alloc] initWithFacebookData:photo] autorelease];
        [items addObject:fbPhoto];
      }
      [items release];
    }
  }
}


#pragma mark TTURLRequestDelegate


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidStartLoad:(TTURLRequest*)request {
  [_request release];
  _request = [request retain];
  
  _label = [[TTActivityLabel alloc] initWithStyle:TTActivityLabelStyleBlackBezel];
  _label.text = @"Loading image...";
  [_label sizeToFit];
  
  [self.view addSubview:_label];
  _label.center = _label.superview.center;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
  TTURLImageResponse* response = request.response;
  [self pick:response.image];
  
  TT_RELEASE_SAFELY(_request);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {
  TT_RELEASE_SAFELY(_request);
  [self pick:nil];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidCancelLoad:(TTURLRequest*)request {
  TT_RELEASE_SAFELY(_request);
  [self pick:nil];
}



@end

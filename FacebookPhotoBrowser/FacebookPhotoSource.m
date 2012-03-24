#import "FacebookPhotoSource.h"
#import "FacebookPhoto.h"

#define NUM_PHOTOS_PER_PAGE 60


@implementation FacebookPhotoSource

@synthesize photos = _photos;
@synthesize title = _title;


- (id)initWithFacebook:(Facebook*)facebook andAlbumInfo:(NSDictionary*)album {
  self = [super init];
  if (self) {
    _facebook = [facebook retain];
    _album = [album retain];
    _loadState = idle;
    _page = 0;
    self.title = [_album objectForKey:@"name"];
  }
  return self;
}


- (void) dealloc {
  [_facebook release];
  [_album release];
  [super dealloc];
}



#pragma mark TTModel

- (BOOL)isLoading {
  return _loadState==loading;
}

- (BOOL)isLoaded {
  return _loadState==loaded;
}

/**
 * Loads the model.
 *
 * Default implementation does nothing.
 */
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
  _loadState = loading;
  
  if (more)
    _page++;

  NSString *albumId = [_album objectForKey:@"id"];
  NSString *request = [NSString stringWithFormat:@"%@/photos?limit=%d&offset=%d", albumId, NUM_PHOTOS_PER_PAGE, _page*NUM_PHOTOS_PER_PAGE];
  NSLog(@"fb request: %@", request);
  [_facebook requestWithGraphPath:request
                      andDelegate:self];
}


#pragma mark - FBRequestDelegate implementation

/**
 * Called when an error prevents the request from completing successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
  _loadState = idle;
  [_delegates perform: @selector(model:didFailLoadWithError:)
           withObject: self
           withObject: nil];
}


/**
 * Called when a request returns and its response has been parsed into
 * an object.
 *
 * The resulting object may be a dictionary, an array, a string, or a number,
 * depending on thee format of the API response.
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
  _loadState = loaded;

  if ([result isKindOfClass:[NSDictionary class]]) {
    result = [(NSDictionary*)result objectForKey:@"data"];
    if ([result isKindOfClass:[NSArray class]]) {
      NSArray *data = (NSArray*)result;
      NSMutableArray *items;
      if (self.photos)
        items = [[NSMutableArray arrayWithArray:self.photos] retain];
      else
        items = [[NSMutableArray alloc] init];
      
      int i = items.count;
      for (NSDictionary *photo in data) {
        FacebookPhoto *fbPhoto = [[[FacebookPhoto alloc] initWithFacebookData:photo] autorelease];
        fbPhoto.photoSource = self;
        fbPhoto.index = i++;
        [items addObject:fbPhoto];
      }

      self.photos = items;
      [items release];
    }
  }

  [_delegates perform:@selector(modelDidFinishLoad:) withObject:self];
}



#pragma mark TTPhotoSource

- (NSInteger)numberOfPhotos {
  int count = [[_album objectForKey:@"count"] intValue];
  return count;//_photos.count;
}

- (NSInteger)maxPhotoIndex {
  return _photos.count-1;
}

- (id<TTPhoto>)photoAtIndex:(NSInteger)photoIndex {
  if (photoIndex < _photos.count) {
    return [_photos objectAtIndex:photoIndex];
  } else {
    return nil;
  }
}
@end
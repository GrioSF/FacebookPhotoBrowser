#import "FacebookAlbumsTableController.h"


static NSString* kGraphBaseURL = @"https://graph.facebook.com/";


@implementation FacebookAlbumsTableController

- (id)initWithFacebook:(Facebook*)facebook {
  self = [super init];
  if (self) {
    _facebook = [facebook retain];
  }
  return self;
}


- (void)dealloc {
  [super dealloc];
  [_facebook release];
}


- (void)viewDidLoad {
  [super viewDidLoad];

  self.navigationItem.rightBarButtonItem =
  [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                 target:self
                                                 action:@selector(cancelSelection)] autorelease];

  self.title = @"Albums";
}


- (void)reload {
  [super reload];
  
  [_facebook requestWithGraphPath:@"me/albums" andDelegate:self];
}


- (void)cancelSelection {
  FacebookPhotoPickerController *picker = (FacebookPhotoPickerController*)self.parentViewController;
  [picker pickPhoto:nil];
}



#pragma mark - FBRequestDelegate implementation


/**
 * Called when the server responds and begins to send back data.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
  
}


/**
 * Called when an error prevents the request from completing successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
  // here, you can show an alert and send cancellation notice to delegate
  [self cancelSelection];
}


/**
 * Called when a request returns and its response has been parsed into
 * an object.
 *
 * The resulting object may be a dictionary, an array, a string, or a number,
 * depending on thee format of the API response.
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
  TTListDataSource *ds = nil;

  if ([result isKindOfClass:[NSDictionary class]]) {
    result = [(NSDictionary*)result objectForKey:@"data"];

    if ([result isKindOfClass:[NSArray class]]) {
      NSArray *data = (NSArray*)result;
      NSMutableArray *items = [[NSMutableArray alloc] init];
      
      for (NSDictionary *album in data) {
        NSString *imageURL = [NSString stringWithFormat:@"%@/%@/picture?type=thumbnail&access_token=%@", 
                              kGraphBaseURL,
                              [album objectForKey:@"id"], 
                              _facebook.accessToken];
        
        TTTableSubtitleItem *item = [TTTableSubtitleItem itemWithText:[album objectForKey:@"name"]
                                                     subtitle:[album objectForKey:@"created_time"]
                                                     imageURL:imageURL
                                                 defaultImage:nil
                                                          URL:nil
                                                 accessoryURL:nil];
        item.delegate = self;
        item.selector = @selector(onClicked:);
        item.userInfo = album;
        [items addObject:item];
      }
      ds = [TTListDataSource dataSourceWithItems:items];
      [items release];
    }
  }

  // make sure ds is not nil, otherwise the table will keep showing "loading..."
  if (!ds)
    ds = [TTListDataSource dataSourceWithItems:nil];

  self.dataSource = ds;
}


- (void)onClicked:(TTTableSubtitleItem*)item {
  NSLog(@"item: %@", item);
  NSDictionary *album = (NSDictionary*)item.userInfo;
  
  UINavigationController *parent = (UINavigationController*)self.parentViewController;
  FacebookPhotoThumbnailViewController *thumbView = 
    [[FacebookPhotoThumbnailViewController alloc] initWithFacebook:_facebook 
                                                      andAlbumInfo:album];
  [parent pushViewController:thumbView animated:YES];
}


@end

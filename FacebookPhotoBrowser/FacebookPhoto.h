//
//  FacebookPhoto.h
//  MyFacebookPhotos
//
//  Created by Purnama Santo on 3/8/12.
//  Copyright (c) 2012 Grio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>

@interface FacebookPhoto : NSObject <TTPhoto> {
  NSString *_urlLarge;
  NSString *_urlSmall;
  NSString *_urlThumb;
  id <TTPhotoSource> _photoSource;
  CGSize _size;
  NSInteger _index;
}

@property (nonatomic, copy) NSString *urlLarge;
@property (nonatomic, copy) NSString *urlSmall;
@property (nonatomic, copy) NSString *urlThumb;
@property (nonatomic, assign) id <TTPhotoSource> photoSource;
@property (nonatomic) CGSize size;
@property (nonatomic) NSInteger index;

- (id)initWithFacebookData:(NSDictionary *)fbData;

@end
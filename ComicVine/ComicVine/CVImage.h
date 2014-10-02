//
//  VineImage.h
//  ComicVine
//
//  Created by Alexander Appa on 10/2/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

@interface CVImage : NSObject

@property (strong, nonatomic) NSURL *iconUrl;
@property (strong, nonatomic) NSURL *mediumUrl;
@property (strong, nonatomic) NSURL *screenUrl;
@property (strong, nonatomic) NSURL *smallUrl;
@property (strong, nonatomic) NSURL *superUrl;
@property (strong, nonatomic) NSURL *thumbUrl;
@property (strong, nonatomic) NSURL *tinyUrl;

- (id) initWithRawData:(NSDictionary*)rawData;
- (NSDictionary*) dictionaryForImage;
- (id) setToValueIfNotNull:(id)value withDefaultValue:(id)defaultValue;

@end

//
//  VineObject.h
//  ComicVine
//
//  Created by Alexander Appa on 10/2/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CVImage.h"

@interface CVObject : NSObject

@property (strong, nonatomic) NSString *apiDetailURL;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) CVImage *image;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *objectId;
@property (strong, nonatomic) NSString *sortName;

- (id) initWithRawData:(NSDictionary*)rawData;
- (NSDictionary*) dictionaryForObject;
- (NSString*) searchStringFromString:(NSString*)string;
- (id) setToValueIfNotNull:(id)value withDefaultValue:(id)defaultValue;

@end

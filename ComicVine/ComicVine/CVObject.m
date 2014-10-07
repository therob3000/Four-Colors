//
//  VineObject.m
//  ComicVine
//
//  Created by Alexander Appa on 10/2/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import "CVObject.h"

@implementation CVObject

#pragma mark - Lifecycle

@synthesize description = _description;

- (id) initWithRawData:(NSDictionary*)rawData {
    self = [super init];
    
    if(self) {
        if(rawData
           && [rawData class] != [NSNull class]) {
            self.apiDetailURL = [self setToValueIfNotNull:[rawData objectForKey:@"api_detail_url"] withDefaultValue:@""];
            self.description = [self setToValueIfNotNull:[rawData objectForKey:@"description"] withDefaultValue:@""];
            self.image = [[CVImage alloc] initWithRawData:[self setToValueIfNotNull:[rawData objectForKey:@"image"] withDefaultValue:nil]];
            self.name = [self setToValueIfNotNull:[rawData objectForKey:@"name"] withDefaultValue:@""];
            self.objectId = [self setToValueIfNotNull:[rawData objectForKey:@"id"] withDefaultValue:[NSNumber numberWithInt:-1]];
            
            if(self.name
               && [self.name class] != [NSNull class]) {
                self.sortName = [self searchStringFromString:self.name];
            }
        }
    }
    
    return self;
}

#pragma mark - Public

- (NSDictionary*) dictionaryForObject {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    if(self.name) {
        [dictionary setObject:self.name forKey:@"name"];
    }
    
    if(self.objectId) {
        [dictionary setObject:self.objectId forKey:@"id"];
    }
    
    if(self.description) {
        [dictionary setObject:self.description forKey:@"description"];
    }
    
    if(self.apiDetailURL) {
        [dictionary setObject:self.apiDetailURL forKey:@"api_detail_url"];
    }
    
    if(self.image) {
        [dictionary setObject:[self.image dictionaryForImage] forKey:@"image"];
    }
    
    return dictionary;
}

- (NSString*) searchStringFromString:(NSString*)string {
    NSString *resultString = string;
    NSString *lowerString = [string lowercaseString];
    
    if([lowerString hasPrefix:@"the "]
       || [lowerString hasPrefix:@"a "]) {
        NSRange range = [string rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
        if(range.location != NSNotFound) {
            resultString = [resultString substringFromIndex:range.location + 1];
        }
    }
    
    return resultString;
}

- (id) setToValueIfNotNull:(id)value withDefaultValue:(id)defaultValue {
    return (value && [value class] != [NSNull class]) ? value : defaultValue;
}

@end

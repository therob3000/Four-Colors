//
//  VineImage.m
//  ComicVine
//
//  Created by Alexander Appa on 10/2/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import "CVImage.h"

@implementation CVImage

#pragma mark - Lifecycle

- (id) initWithRawData:(NSDictionary *)rawData {
    self = [super init];
    
    if(self) {
        if(rawData && [rawData class] != [NSNull class]) {
            NSString *urlString = [self setToValueIfNotNull:[rawData objectForKey:@"icon_url"] withDefaultValue:nil];
            if(urlString) {
                self.iconUrl = [[NSURL alloc] initWithString:[rawData objectForKey:@"icon_url"]];
            }
            
            urlString = [self setToValueIfNotNull:[rawData objectForKey:@"medium_url"] withDefaultValue:nil];
            if(urlString) {
                self.mediumUrl = [[NSURL alloc] initWithString:[rawData objectForKey:@"medium_url"]];
            }
            
            urlString = [self setToValueIfNotNull:[rawData objectForKey:@"screen_url"] withDefaultValue:nil];
            if(urlString) {
                self.screenUrl = [[NSURL alloc] initWithString:[rawData objectForKey:@"screen_url"]];
            }
            
            urlString = [self setToValueIfNotNull:[rawData objectForKey:@"small_url"] withDefaultValue:nil];
            if(urlString) {
                self.smallUrl = [[NSURL alloc] initWithString:[rawData objectForKey:@"small_url"]];
            }
            
            urlString = [self setToValueIfNotNull:[rawData objectForKey:@"super_url"] withDefaultValue:nil];
            if(urlString) {
                self.superUrl = [[NSURL alloc] initWithString:[rawData objectForKey:@"super_url"]];
            }
            
            urlString = [self setToValueIfNotNull:[rawData objectForKey:@"thumb_url"] withDefaultValue:nil];
            if(urlString) {
                self.thumbUrl = [[NSURL alloc] initWithString:[rawData objectForKey:@"thumb_url"]];
            }
            
            urlString = [self setToValueIfNotNull:[rawData objectForKey:@"tiny_url"] withDefaultValue:nil];
            if(urlString) {
                self.tinyUrl = [[NSURL alloc] initWithString:[rawData objectForKey:@"tiny_url"]];
            }
        }
    }
    
    return self;
}

#pragma mark - Public

- (NSDictionary*) dictionaryForImage {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    if(self.tinyUrl.absoluteString) {
        [dictionary setObject:self.tinyUrl.absoluteString forKey:@"tiny_url"];
    }
    
    if(self.iconUrl) {
        [dictionary setObject:self.iconUrl.absoluteString forKey:@"icon_url"];
    }
    
    if(self.smallUrl) {
        [dictionary setObject:self.smallUrl.absoluteString forKey:@"small_url"];
    }
    
    if(self.mediumUrl) {
        [dictionary setObject:self.mediumUrl.absoluteString forKey:@"medium_url"];
    }
    
    if(self.screenUrl) {
        [dictionary setObject:self.screenUrl.absoluteString forKey:@"screen_url"];
    }
    
    if(self.superUrl) {
        [dictionary setObject:self.superUrl.absoluteString forKey:@"super_url"];
    }
    
    if(self.thumbUrl) {
        [dictionary setObject:self.thumbUrl.absoluteString forKey:@"thumb_url"];
    }
    
    return dictionary;
}

- (id) setToValueIfNotNull:(id)value withDefaultValue:(id)defaultValue {
    return (value && [value class] != [NSNull class]) ? value : defaultValue;
}

@end

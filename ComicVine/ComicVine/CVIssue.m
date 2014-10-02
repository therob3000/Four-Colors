//
//  VineVolume.m
//  ComicVine
//
//  Created by Alexander Appa on 10/2/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import "CVIssue.h"

@implementation CVIssue

#pragma mark - Lifecycle

- (id) initWithRawData:(NSDictionary *)rawData {
    self = [super initWithRawData:rawData];
    
    if(self) {
        if(rawData && [rawData class] != [NSNull class]) {
            self.issueNumber = [rawData objectForKey:@"issue_number"];
            self.inStoreDate = [[NSString alloc] init];
            self.inStoreDate = @"Unknown";
            self.volumeName = [[rawData objectForKey:@"volume"] objectForKey:@"name"];
            self.volumeSortName = [self searchStringFromString:self.volumeName];
            self.volumeId = [[rawData objectForKey:@"volume"] objectForKey:@"id"];
            
            NSString *dateString = [rawData objectForKey:@"store_date"];
            if(dateString && [dateString class] != [NSNull class]) {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                
                NSDateFormatter *outFormat = [[NSDateFormatter alloc] init];
                [outFormat setDateFormat:@"MMMM d, YYYY"];
                
                NSDate *date = [dateFormatter dateFromString:dateString];
                self.inStoreDate = [outFormat stringFromDate:date];
            }
            
            NSDictionary *volumeData = [rawData objectForKey:@"volume"];
            if(volumeData && [volumeData class] != [NSNull class]) {
                self.volumeId = [volumeData objectForKey:@"id"];
            }
        }
    }
    
    return self;
}

#pragma mark - Public

- (NSDictionary*) dictionaryForIssue {
    NSMutableDictionary *dictionary = [[super dictionaryForObject] mutableCopy];
    if(self.issueNumber) {
        [dictionary setObject:self.issueNumber forKey:@"issue_number"];
    }
    
    NSMutableDictionary *volumeDictionary = [[NSMutableDictionary alloc] init];
    if(self.volumeName) {
        [volumeDictionary setObject:self.volumeName forKey:@"name"];
    }
    
    if(self.volumeId) {
        [volumeDictionary setObject:self.volumeId forKey:@"id"];
    }
    
    [dictionary setObject:volumeDictionary forKey:@"volume"];
    
    if(![self.inStoreDate isEqualToString:@"Unknown"]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMMM d, YYYY"];
        
        NSDateFormatter *outFormat = [[NSDateFormatter alloc] init];
        [outFormat setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *date = [dateFormatter dateFromString:self.inStoreDate];
        NSString *outDateString = [outFormat stringFromDate:date];
        
        [dictionary setObject:outDateString forKey:@"store_date"];
    }
    
    return dictionary;
}

@end

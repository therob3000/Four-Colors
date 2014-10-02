//
//  VineVolume.m
//  ComicVine
//
//  Created by Alexander Appa on 10/2/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import "CVVolume.h"

@implementation CVVolume

#pragma mark - Lifecycle

- (id) initWithRawData:(NSDictionary *)rawData {
    self = [super initWithRawData:rawData];
    
    if(self) {
        self.lastIssueInStoreDate = @"";
        
        self.countOfIssues = [self setToValueIfNotNull:[rawData objectForKey:@"count_of_issues"] withDefaultValue:nil];
        self.startYear = [self setToValueIfNotNull:[rawData objectForKey:@"start_year"] withDefaultValue:nil];
        
        NSDictionary *lastIssue = [rawData objectForKey:@"last_issue"];
        if(lastIssue && [lastIssue class] != [NSNull class]) {
            self.lastIssueAPIDetail = [self setToValueIfNotNull:[lastIssue objectForKey:@"api_detail_url"] withDefaultValue:@""];
            self.lastIssueInStoreDate = [self setToValueIfNotNull:[lastIssue objectForKey:@"last_issue_in_store_date"] withDefaultValue:@""];
        }
    }
    
    return self;
}

#pragma mark - Public

- (NSDictionary*) dictionaryForVolume {
    NSMutableDictionary *dictionary = [[super dictionaryForObject] mutableCopy];
    [dictionary setObject:self.countOfIssues forKey:@"count_of_issues"];
    
    if(self.startYear) {
        [dictionary setObject:self.startYear forKey:@"start_year"];
    }
    
    NSMutableDictionary *lastIssueDictionary = [[NSMutableDictionary alloc] init];
    if(self.lastIssueAPIDetail) {
        [lastIssueDictionary setObject:self.lastIssueAPIDetail forKey:@"api_detail_url"];
    }
    
    if(self.lastIssueInStoreDate) {
        [lastIssueDictionary setObject:self.lastIssueInStoreDate forKey:@"last_issue_in_store_date"];
    }
    
    [dictionary setObject:lastIssueDictionary forKey:@"last_issue"];
    
    return dictionary;
}

@end

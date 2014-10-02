//
//  VolumesRequest.m
//  ComicVine
//
//  Created by Alexander Appa on 10/2/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import "CVIssuesRequest.h"
#import "CVIssue.h"

@interface CVIssuesRequest()
@property (strong, nonatomic) NSNumber *volumeId;
@property (strong, nonatomic) NSMutableArray *issues;
@end

@implementation CVIssuesRequest

static NSString *const IssuesUrlTemplate = @"http://api.comicvine.com/issues/?api_key=%@&format=json&filter=volume:%@&sort=issue_number:asc&offset=%ld";

#pragma mark - Lifecycle

- (id) initWithVolumeId:(NSNumber *)volumeId atOffset:(unsigned long)offset withDelegate:(id)delegate {
    self = [super init];
    
    if(self) {
        self.issues = [[NSMutableArray alloc] init];
        self.volumeId = volumeId;
        self.requestURL = [NSString stringWithFormat:IssuesUrlTemplate, self.apiKey, volumeId, offset];
        self.delegate = delegate;
    }
    
    return self;
}

#pragma mark - NSURLDataConnectionData

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    [super connectionDidFinishLoading:connection];
    
    if(self.responseOK) {
        for(NSDictionary *issue in self.responseResults) {
            CVIssue *vineVolume = [[CVIssue alloc] initWithRawData:issue];
            [self.issues addObject:vineVolume];
        }
        
        NSNumber *totalResults = [self.responseFull objectForKey:@"number_of_total_results"];
        if(self.issues.count < [totalResults integerValue]) {
            self.requestURL = [NSString stringWithFormat:IssuesUrlTemplate, self.apiKey, self.volumeId, (unsigned long)self.issues.count];
            self.requestData.length = 0;
            [self send];
        }
        else {
            NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc]
                                                 initWithKey:@"issueNumber" ascending:YES selector:@selector(localizedStandardCompare:)];
            
            NSMutableArray  *sortedIssues = [[self.issues sortedArrayUsingDescriptors:@[valueDescriptor]] mutableCopy];
            
            if([self.delegate respondsToSelector:@selector(issuesResponseReceived:)]) {
                [self.delegate performSelectorOnMainThread:@selector(issuesResponseReceived:) withObject:sortedIssues waitUntilDone:NO];
            }
        }
    }
}

@end

@implementation CVIssuesRequestOperation

#pragma mark - Lifecycle

- (id) initWithVolumesRequest:(CVIssuesRequest *)request {
    self = [super init];
    
    if(self) {
        self.request = request;
    }
    
    return self;
}

#pragma mark - Private

- (void) main
{
    @autoreleasepool {
        if(self.isCancelled) {
            return;
        }
        
        [self.request send];
    }
}

@end
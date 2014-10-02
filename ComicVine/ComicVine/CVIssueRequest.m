//
//  VolumesRequest.m
//  ComicVine
//
//  Created by Alexander Appa on 10/2/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import "CVIssueRequest.h"
#import "CVIssue.h"

@implementation CVIssueRequest

static NSString *const IssueUrlTemplate = @"http://api.comicvine.com/issue/4000-%@/?api_key=%@&format=json";
static NSString *const IssueUrlTemplateWithAPIDetail = @"%@?api_key=%@&format=json";

#pragma mark - Lifecycle

- (id) initWithVolumeId:(NSNumber *)volumeId withDelegate:(id)delegate {
    self = [super init];
    
    if(self) {
        self.requestURL = [NSString stringWithFormat:IssueUrlTemplate, volumeId, self.apiKey];
        self.delegate = delegate;
    }
    
    return self;
}

- (id) initWithAPIDetail:(NSString *)apiDetailUrl withDelegate:(id)delegate {
    self = [super init];
    
    if(self) {
        self.requestURL = [NSString stringWithFormat:IssueUrlTemplateWithAPIDetail, apiDetailUrl, self.apiKey];
        self.delegate = delegate;
    }
    
    return self;
}

#pragma mark - NSURLConnectionData

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    [super connectionDidFinishLoading:connection];
    
    if(self.responseOK) {
        CVIssue *issue = [[CVIssue alloc] initWithRawData:self.responseResults];
        if([self.delegate respondsToSelector:@selector(issueResponseReceived:)]) {
            [self.delegate performSelectorOnMainThread:@selector(issueResponseReceived:) withObject:issue waitUntilDone:NO];
        }
    }
}

@end

@implementation CVIssueRequestOperation

#pragma mark - Lifecycle

- (id) initWithVolumesRequest:(CVIssueRequest *)request {
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
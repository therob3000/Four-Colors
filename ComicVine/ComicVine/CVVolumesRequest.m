//
//  VolumesRequest.m
//  ComicVine
//
//  Created by Alexander Appa on 10/2/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import "CVVolumesRequest.h"
#import "CVVolume.h"

@implementation CVVolumesRequest

static NSString *const VolumesUrlTemplate = @"http://api.comicvine.com/search?api_key=%@&query=%@&resources=volume&offset=0&format=json";

#pragma mark - Lifecycle

- (id) initWithQueryString:(NSString *)queryString withDelegate:(id)delegate {
    self = [super init];
    
    if(self) {
        NSString *encodedQueryString = [queryString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        self.requestURL = [NSString stringWithFormat:VolumesUrlTemplate, self.apiKey, encodedQueryString];
        self.delegate = delegate;
    }
    
    return self;
}

#pragma mark - NSURLConnectionData

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    [super connectionDidFinishLoading:connection];
    
    if(self.responseOK) {
        NSMutableArray *volumes = [[NSMutableArray alloc] init];
        for(NSDictionary *volume in self.responseResults) {
            CVVolume *vineVolume = [[CVVolume alloc] initWithRawData:volume];
            [volumes addObject:vineVolume];
        }
        
        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startYear" ascending:NO selector:@selector(localizedStandardCompare:)];
        volumes = [[volumes sortedArrayUsingDescriptors:@[valueDescriptor]] mutableCopy];
        if([self.delegate respondsToSelector:@selector(volumesResponseReceived:)]) {
            [self.delegate performSelectorOnMainThread:@selector(volumesResponseReceived:) withObject:volumes waitUntilDone:NO];
        }
    }
}

@end

@implementation CVVolumesRequestOperation

#pragma mark - Lifecycle

- (id) initWithVolumesRequest:(CVVolumesRequest *)request {
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

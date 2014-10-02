//
//  VolumesRequest.m
//  ComicVine
//
//  Created by Alexander Appa on 10/2/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import "CVVolumeRequest.h"
#import "CVVolume.h"

@implementation CVVolumeRequest

static NSString *const VolumeUrlTemplate = @"http://api.comicvine.com/volume/4050-%@/?api_key=%@&format=json";
static NSString *const VolumeUrlMinimalTemplate = @"http://api.comicvine.com/volume/4050-%@/?api_key=%@&format=json&field_list=last_issue,id,name,image,count_of_issues,start_year";

#pragma mark - Lifecycle

- (id) initWithVolumeId:(NSNumber *)volumeId forMinimalRequest:(BOOL)minimalRequest withDelegate:(id)delegate {
    self = [super init];
    
    if(self) {
        self.requestURL =
            minimalRequest ?
            [NSString stringWithFormat:VolumeUrlMinimalTemplate, volumeId, self.apiKey] :
            [NSString stringWithFormat:VolumeUrlTemplate, volumeId, self.apiKey];
        self.delegate = delegate;
    }
    
    return self;
}

#pragma mark - NSURLConnectionData

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [super connectionDidFinishLoading:connection];
    
    if(self.responseOK) {
        CVVolume *volume = [[CVVolume alloc] initWithRawData:self.responseResults];
        if([self.delegate respondsToSelector:@selector(volumeResponseReceived:)]) {
            [self.delegate performSelectorOnMainThread:@selector(volumeResponseReceived:) withObject:volume waitUntilDone:NO];
        }
    }
}

@end

@implementation CVVolumeRequestOperation

#pragma mark - Lifecycle

- (id) initWithVolumeRequest:(CVVolumeRequest *)request {
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

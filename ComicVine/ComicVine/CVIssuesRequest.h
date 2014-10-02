//
//  VolumesRequest.h
//  ComicVine
//
//  Created by Alexander Appa on 10/2/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import "CVRequest.h"

@interface CVIssuesRequest : CVRequest <NSURLConnectionDataDelegate>

- (id) initWithVolumeId:(NSNumber *)volumeId atOffset:(unsigned long)offset withDelegate:(id)delegate;

@end

@protocol CVIssuesRequestDelegate <NSObject>

- (void) issuesResponseReceived:(NSArray*)issues;

@end

@interface CVIssuesRequestOperation : NSOperation

@property (strong, nonatomic) CVIssuesRequest *request;

- (id) initWithVolumesRequest:(CVIssuesRequest*)request;

@end
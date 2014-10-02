//
//  VolumesRequest.h
//  ComicVine
//
//  Created by Alexander Appa on 10/2/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import "CVRequest.h"
#import "CVIssue.h"

@interface CVIssueRequest : CVRequest <NSURLConnectionDataDelegate>
- (id) initWithVolumeId:(NSNumber *)volumeId withDelegate:(id)delegate;
- (id) initWithAPIDetail:(NSString *)apiDetailUrl withDelegate:(id)delegate;
@end

@protocol CVIssueRequestDelegate <NSObject>
- (void) issueResponseReceived:(CVIssue*)issue;
@end

@interface CVIssueRequestOperation : NSOperation
@property (strong, nonatomic) CVIssueRequest *request;
- (id) initWithVolumesRequest:(CVIssueRequest*)request;
@end
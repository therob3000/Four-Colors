//
//  VolumesRequest.h
//  ComicVine
//
//  Created by Alexander Appa on 10/2/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import "CVRequest.h"

@interface CVVolumesRequest : CVRequest <NSURLConnectionDataDelegate>

- (id) initWithQueryString:(NSString*)queryString withDelegate:(id)delegate;

@end

@protocol CVVolumesRequestDelegate <NSObject>

- (void) volumesResponseReceived:(NSArray*)volumes;

@end

@interface CVVolumesRequestOperation : NSOperation

@property (strong, nonatomic) CVVolumesRequest *request;

- (id) initWithVolumesRequest:(CVVolumesRequest*)request;

@end
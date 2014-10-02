//
//  VolumesRequest.h
//  ComicVine
//
//  Created by Alexander Appa on 10/2/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import "CVRequest.h"
#import "CVVolume.h"

@interface CVVolumeRequest : CVRequest <NSURLConnectionDataDelegate>

- (id) initWithVolumeId:(NSNumber*)volumeId forMinimalRequest:(BOOL)minimalRequest withDelegate:(id)delegate;

@end

@protocol CVVolumeRequestDelegate <NSObject>

- (void) volumeResponseReceived:(CVVolume*)volume;

@end

@interface CVVolumeRequestOperation : NSOperation

@property (strong, nonatomic) CVVolumeRequest *request;

- (id) initWithVolumeRequest:(CVVolumeRequest*)request;

@end
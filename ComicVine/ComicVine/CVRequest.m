//
//  VineRequest.m
//  ComicVine
//
//  Created by Alexander Appa on 10/2/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import "CVRequest.h"

@implementation CVRequest

static NSString *cvAPIKey;
static NSOperationQueue *_requestQueue;

#pragma mark - Lifecycle

- (id) init {
    self = [super init];
    
    if(self) {
        if(!_requestQueue) {
            _requestQueue = [[NSOperationQueue alloc] init];
            _requestQueue.maxConcurrentOperationCount = 1;
        }
        
        self.requestData = [[NSMutableData alloc] init];
        self.responseOK = NO;
        self.responseResults = nil;
    }
    
    return self;
}

#pragma mark - Public Static

+ (void) useAPIKey:(NSString *)apiKey {
    cvAPIKey = apiKey;
}

#pragma mark - Public

- (NSString*) apiKey {
    return cvAPIKey;
}

- (void) setAPIKey:(NSString *)apiKey {
    //
    // Not settable - implementation required.
    //
}

- (void) send {
    if(!self.apiKey || [self.apiKey isEqualToString:@""]) {
        return;
    }
    
    NSURL *url = [[NSURL alloc] initWithString:self.requestURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    VineRequestOperation *operation = [[VineRequestOperation alloc] initWithConnection:connection];
    [_requestQueue addOperation:operation];
}

#pragma mark - NSURLConnectionData

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.requestData appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *error;
    self.responseFull = [NSJSONSerialization JSONObjectWithData:self.requestData options:kNilOptions error:&error];
    
    if(!error
       && self.responseFull
       && [[self.responseFull objectForKey:@"error"] isEqualToString:@"OK"]) {
        self.responseResults = [self.responseFull objectForKey:@"results"];
        self.responseOK = YES;
    }
}

@end

@implementation VineRequestOperation

#pragma mark - Lifecycle

- (id) initWithConnection:(NSURLConnection *)connection {
    self = [super init];
    if(self) {
        self.connection = connection;
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
        
        [self.connection start];
    }
}

@end





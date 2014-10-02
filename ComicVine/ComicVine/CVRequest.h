//
//  VineRequest.h
//  ComicVine
//
//  Created by Alexander Appa on 10/2/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VineConstants.h"

@interface CVRequest : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) NSString *apiKey;
@property (strong, nonatomic) id delegate;
@property (strong, nonatomic) NSMutableData *requestData;
@property (strong, nonatomic) NSString *requestURL;
@property BOOL responseOK;
@property (strong, nonatomic) NSDictionary *responseFull;
@property (strong, nonatomic) NSDictionary *responseResults;

- (void) send;
+ (void) useAPIKey:(NSString*)apiKey;

@end

@interface VineRequestOperation : NSOperation

@property (strong, nonatomic) NSURLConnection *connection;

- (id) initWithConnection:(NSURLConnection*)connection;

@end
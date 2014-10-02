//
//  VineVolume.h
//  ComicVine
//
//  Created by Alexander Appa on 10/2/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import "CVObject.h"

@interface CVVolume : CVObject

@property (strong, nonatomic) NSNumber *countOfIssues;
@property (strong, nonatomic) NSString *lastIssueAPIDetail;
@property (strong, nonatomic) NSString *lastIssueInStoreDate;
@property (strong, nonatomic) NSNumber *startYear;

- (id) initWithRawData:(NSDictionary*)rawData;
- (NSDictionary*) dictionaryForVolume;

@end

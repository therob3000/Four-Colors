//
//  VineVolume.h
//  ComicVine
//
//  Created by Alexander Appa on 10/2/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import "CVObject.h"

@interface CVIssue : CVObject

@property (strong, nonatomic) NSString *inStoreDate;
@property (strong, nonatomic) NSNumber *issueNumber;
@property (strong, nonatomic) NSNumber *volumeId;
@property (strong, nonatomic) NSString *volumeName;
@property (strong, nonatomic) NSString *volumeSortName;

- (id) initWithRawData:(NSDictionary*)rawData;
- (NSDictionary*) dictionaryForIssue;

@end

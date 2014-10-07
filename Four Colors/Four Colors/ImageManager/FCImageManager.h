//
//  FCImageManager.h
//  Four Colors
//
//  Created by Alexander Appa on 10/6/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCLazyImage.h"

@interface FCImageManager : NSOperationQueue <FCLazyImageDelegate>

- (void)cancelAllPendingImages;
- (void)cancelPendingImage:(FCLazyImage*)lazyImage;
- (FCLazyImage*)retrieveImageAtUrl:(NSURL*)url forIndex:(NSIndexPath*)index delegate:(id)delegate;

@end

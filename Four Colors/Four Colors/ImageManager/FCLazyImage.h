//
//  LazyImage.h
//  Four Colors
//
//  Created by Alexander Appa on 10/4/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface FCLazyImage : NSObject
@property (strong, nonatomic) NSURL *targetUrl;
@property (strong, nonatomic) UIImage *defaultImage;
@property (strong, nonatomic) UIImage *retrievedImage;
- (id)initWithUrl:(NSURL*)url withDelegate:(id)delegate;
- (UIImage*)getCurrentImage;
- (void)refreshAtIndex:(NSIndexPath*)index;
@end

@protocol FCLazyImageDelegate
- (void)imageLoaded:(FCLazyImage*)lazyImage atIndex:(NSIndexPath*)index;
@end

@interface FCLazyImageOperation : NSOperation
@property (weak, nonatomic) FCLazyImage *lazyImage;
- (id)initWithImage:(FCLazyImage*)image managerDelegate:(id)delegate;
@end

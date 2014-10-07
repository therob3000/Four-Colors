//
//  LazyImage.m
//  Four Colors
//
//  Created by Alexander Appa on 10/4/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCLazyImage.h"

@interface FCLazyImage()
@property (strong, nonatomic) id delegate;

@end

@implementation FCLazyImage
- (id)initWithUrl:(NSURL *)url withDelegate:(id)delegate {
    self = [super init];
    if(self) {
        self.targetUrl = url;
        self.delegate = delegate;
        self.retrievedImage = nil;
        
        NSString* defaultLazyImagePath = [[NSBundle mainBundle] pathForResource:@"defaultLazy" ofType:@"jpg"];
        self.defaultImage = [[UIImage alloc] initWithContentsOfFile:defaultLazyImagePath];
    }
    return self;
}

- (UIImage*)getCurrentImage {
    if(self.retrievedImage) {
        return self.retrievedImage;
    }
    
    return self.defaultImage;
}

- (void)refreshAtIndex:(NSIndexPath *)index {
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(imageLoaded:atIndex:)]) {
        [self.delegate imageLoaded:self atIndex:index];
    }
}

@end

@interface FCLazyImageOperation()
@property (strong, nonatomic) id managerDelegate;
@end

@implementation FCLazyImageOperation
- (id)initWithImage:(FCLazyImage*)image managerDelegate:(id)delegate {
    self = [super init];
    if(self) {
        self.lazyImage = image;
        self.managerDelegate = delegate;
    }
    return self;
}

- (void) main {
    @autoreleasepool {
        if(self.isCancelled) {
            return;
        }
        
        self.lazyImage.retrievedImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:self.lazyImage.targetUrl]];
        
        if(self.managerDelegate &&
           [self.managerDelegate respondsToSelector:@selector(imageLoaded:atIndex:)]) {
            [self.managerDelegate imageLoaded:self.lazyImage atIndex:nil];
        }
        
        self.lazyImage = nil;
    }
}

@end

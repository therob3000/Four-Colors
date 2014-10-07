//
//  FCImageManager.m
//  Four Colors
//
//  Created by Alexander Appa on 10/6/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import "FCImageManager.h"

@interface FCImageManager()
@property (strong, nonatomic) NSMutableDictionary *lastKnownIndexes;
@property (strong, nonatomic) NSMutableDictionary *knownImages;
@property (strong, nonatomic) NSMutableDictionary *pendingImageOperations;
@end

@implementation FCImageManager

- (id)init {
    self = [super init];
    if(self) {
        self.maxConcurrentOperationCount = 1;
        self.lastKnownIndexes = [[NSMutableDictionary alloc] init];
        self.knownImages = [[NSMutableDictionary alloc] init];
        self.pendingImageOperations = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)cancelPendingImage:(FCLazyImage*)lazyImage {
    FCLazyImageOperation *lazyOperation = nil;
    @synchronized(self.pendingImageOperations) {
        lazyOperation = [self.pendingImageOperations objectForKey:lazyImage.targetUrl.absoluteString];
        if(lazyOperation) {
            [lazyOperation cancel];
            [self.pendingImageOperations removeObjectForKey:lazyImage.targetUrl.absoluteString];
        }
    }
}

- (void)cancelAllPendingImages {
    @synchronized(self.pendingImageOperations) {
        for(FCLazyImageOperation *lazyOperation in [self.pendingImageOperations allValues]) {
            [lazyOperation cancel];
        }
        [self.pendingImageOperations removeAllObjects];
    }
}

- (FCLazyImage*)retrieveImageAtUrl:(NSURL *)url forIndex:(NSIndexPath *)index delegate:(id)delegate {
    FCLazyImage *lazyImage = nil;
    @synchronized(self.knownImages) {
        lazyImage = [self.knownImages objectForKey:url.absoluteString];
    }
    
    if(lazyImage) {
        return lazyImage;
    }
    
    @synchronized(self.lastKnownIndexes) {
        [self.lastKnownIndexes setObject:index forKey:url.absoluteString];
    }
    
    FCLazyImageOperation *pendingOperation = nil;
    @synchronized(self.pendingImageOperations) {
        pendingOperation = [self.pendingImageOperations objectForKey:url.absoluteString];
    }
    
    if(pendingOperation) {
        return pendingOperation.lazyImage;
    }
    
    lazyImage = [[FCLazyImage alloc] initWithUrl:url withDelegate:delegate];
    FCLazyImageOperation *lazyOperation = [[FCLazyImageOperation alloc] initWithImage:lazyImage managerDelegate:self];
    [self.pendingImageOperations setObject:lazyOperation forKey:url.absoluteString];
    [self addOperation:lazyOperation];
    
    return lazyImage;
}

- (void)imageLoaded:(FCLazyImage *)lazyImage atIndex:(NSIndexPath *)index {
    NSIndexPath* lastKnownIndex = nil;
    @synchronized(self.lastKnownIndexes) {
        lastKnownIndex = [self.lastKnownIndexes objectForKey:lazyImage.targetUrl.absoluteString];
    }
    
    if(!lastKnownIndex) {
        return;
    }
    
    [lazyImage refreshAtIndex:lastKnownIndex];
    
    @synchronized(self.knownImages) {
        [self.knownImages setObject:lazyImage forKey:lazyImage.targetUrl.absoluteString];
    }
    
    @synchronized(self.pendingImageOperations) {
        [self.pendingImageOperations removeObjectForKey:lazyImage.targetUrl.absoluteString];
    }
}

@end

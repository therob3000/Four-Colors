//
//  FCHeroCardCell.m
//  Four Colors
//
//  Created by Alexander Appa on 10/6/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import "FCHeroCardCell.h"
#import "FCImageManager.h"
#import "FCLazyImage.h"

@interface FCHeroCardCell()
@property (strong, nonatomic) NSIndexPath *index;
@property (strong, nonatomic) CVVolume *volume;
@property (strong, nonatomic) FCLazyImage *lazyImage;
@end

static FCImageManager *_imageManager;

@implementation FCHeroCardCell

- (id)initWithVolume:(CVVolume*)volume withIdentifier:(NSString*)identifier forIndex:(NSIndexPath *)index lazyImageDelegate:(id)delegate {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    if(self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _imageManager = [[FCImageManager alloc] init];
        });
        
        [self fillCellWithVolume:volume forIndex:index lazyImageDelegate:delegate];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)fillCellWithVolume:(CVVolume*)volume forIndex:(NSIndexPath*)index lazyImageDelegate:(id)delegate {
    self.index = index;
    self.volume = volume;
    self.lazyImage = [_imageManager retrieveImageAtUrl:volume.image.superUrl forIndex:index delegate:delegate];
    self.textLabel.text = self.volume.name;
    self.imageView.image = [self.lazyImage getCurrentImage];
}

- (void)prepareForReuse {
    [self removeFromSuperview];
    
    self.imageView.image = nil;
    self.textLabel.text = nil;
    self.index = nil;
    self.volume = nil;
    self.lazyImage = nil;
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    
    [_imageManager cancelPendingImage:self.lazyImage];
}

@end

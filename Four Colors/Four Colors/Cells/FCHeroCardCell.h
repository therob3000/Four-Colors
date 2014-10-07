//
//  FCHeroCardCell.h
//  Four Colors
//
//  Created by Alexander Appa on 10/6/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CVVolume.h>

@interface FCHeroCardCell : UITableViewCell

- (id)initWithVolume:(CVVolume*)volume withIdentifier:(NSString*)identifier forIndex:(NSIndexPath*)index lazyImageDelegate:(id)delegate;
- (void)fillCellWithVolume:(CVVolume*)volume forIndex:(NSIndexPath*)index lazyImageDelegate:(id)delegate;

@end

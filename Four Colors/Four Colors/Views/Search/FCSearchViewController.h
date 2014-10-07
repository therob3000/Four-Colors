//
//  FCSearchViewController.h
//  Four Colors
//
//  Created by Alexander Appa on 10/2/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CVVolumesRequest.h>
#import "FCLazyImage.h"

@interface FCSearchViewController : UIViewController <
    CVVolumesRequestDelegate,
    FCLazyImageDelegate,
    UISearchBarDelegate,
    UITableViewDelegate,
    UITableViewDataSource>

@end

//
//  FCSearchViewController.m
//  Four Colors
//
//  Created by Alexander Appa on 10/2/14.
//  Copyright (c) 2014 Alexander Appa. All rights reserved.
//

#import "FCSearchViewController.h"
#import <CVRequest.h>
#import <CVVolumesRequest.h>
#import <CVVolume.h>
#import "FCLazyImage.h"
#import "FCHeroCardCell.h"

@interface FCSearchViewController ()
@property (strong, nonatomic) UIView *slideoutSearchView;
@property (strong, nonatomic) NSMutableArray *volumes;
@property CGPoint lastKnownTableOffset;
@property (weak, nonatomic) IBOutlet UITableView *volumesTable;
@property (strong, nonatomic) NSMutableDictionary *images;
@property (strong, nonatomic) NSMutableDictionary *knownIndexes;

@property (strong, nonatomic) NSOperationQueue *queue;

- (void)attachSlideoutSearchView;
@end


@implementation FCSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [CVRequest useAPIKey:@""];
    
    self.queue = [[NSOperationQueue alloc] init];
    self.queue.maxConcurrentOperationCount = 1;
    
    self.volumesTable.delegate = self;
    self.volumesTable.dataSource = self;
    self.volumes = [[NSMutableArray alloc] init];
    self.images = [[NSMutableDictionary alloc] init];
    self.knownIndexes = [[NSMutableDictionary alloc] init];
    
    [self attachSlideoutSearchView];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.volumes.count;
}

#pragma mark - UISearchBarDelegate

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    CVVolumesRequest *request = [[CVVolumesRequest alloc] initWithQueryString:searchBar.text withDelegate:self];
    [request send];
    
    [searchBar resignFirstResponder];
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar becomeFirstResponder];
    [searchBar setShowsCancelButton:YES animated:YES];
}


- (void) volumesResponseReceived:(NSArray *)volumes {
    self.volumes = [volumes mutableCopy];
    [self.volumesTable reloadData];
}

- (void)attachSlideoutSearchView {
    CGRect barFrame = CGRectMake(0, 0, self.view.frame.size.width, 44.0f);
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:barFrame];
    searchBar.delegate = self;
    
    CGPoint pointBelowNav = CGPointMake(0, self.navigationController.navigationBar.frame.size.height + 20);
    CGRect viewFrame = CGRectMake(pointBelowNav.x, pointBelowNav.y, 320.0f, 44.0f);
    self.slideoutSearchView = [[UIView alloc] initWithFrame:viewFrame];
    [self.slideoutSearchView addSubview:searchBar];
    [self.view addSubview:self.slideoutSearchView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CVVolume *volume = [self.volumes objectAtIndex:indexPath.row];
    
    NSString *identifier = [NSString stringWithFormat:@"cell%d", (int)indexPath.row%5];
    FCHeroCardCell *cell = [self.volumesTable dequeueReusableCellWithIdentifier:identifier];
    if(cell) {
        [cell fillCellWithVolume:volume forIndex:indexPath lazyImageDelegate:self];
    }
    else {
        cell = [[FCHeroCardCell alloc] initWithVolume:volume withIdentifier:identifier forIndex:indexPath lazyImageDelegate:self];
    }
    
    return cell;
}

- (void)imageLoaded:(FCLazyImage *)lazyImage atIndex:(NSIndexPath *)index {
    if(index) {
        dispatch_async(dispatch_get_main_queue(), ^() {
            [self.volumesTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:index]
                                     withRowAnimation:UITableViewRowAnimationNone];
        });
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140.0f;
}

@end

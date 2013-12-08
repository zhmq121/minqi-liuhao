//
//  WCFavoritesViewController.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 9/8/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCFavoritesViewController.h"
#import "WCFavoriteCell.h"
#import "WCFavoritesManager.h"
#import "WCMainMenuButton.h"
#import <AddressBook/AddressBook.h>

NSString *const kFavoriteCellReuseIdentifier = @"FavoriteCell";
const CGFloat kFavoritesBottomViewHeight = 30;

@interface WCFavoritesViewController ()

@property (strong) UITableView *favoritesTableView;
@property (assign) BOOL isEditing;
@property (strong) WCFavorite *selectedFavorite;
@end

@implementation WCFavoritesViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = NSLocalizedString(@"Favorites", @"");
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Edit", @"") style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonPressed:)];
    
    self.favoritesTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frameWidth, self.contentView.frameHeight) style:UITableViewStylePlain];
    self.favoritesTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.favoritesTableView.backgroundColor = [UIColor clearColor];
    self.favoritesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.favoritesTableView.delegate = self;
    self.favoritesTableView.dataSource = self;
    [self.contentView addSubview:self.favoritesTableView];
}

- (void)rightBarButtonPressed:(id)sender
{
    self.isEditing = !self.isEditing;
    
    if (self.isEditing)
    {
        self.navigationItem.rightBarButtonItem.title = NSLocalizedString(@"Delete", @"");
    }
    else
    {
        self.navigationItem.rightBarButtonItem.title = NSLocalizedString(@"Edit", @"");
        [self deleteCheckedCells];
    }
    
    for (int i = 0; i < [self.favoritesTableView numberOfRowsInSection:0]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        WCFavoriteCell *cell = (WCFavoriteCell *)[self.favoritesTableView cellForRowAtIndexPath:indexPath];
        
        cell.isEditing = self.isEditing;
        if (self.isEditing)
            cell.isSelected = NO;
    }
}

- (void)deleteCheckedCells
{
    NSMutableArray *cellIndicesToBeDeleted = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.favoritesTableView numberOfRowsInSection:0]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        WCFavoriteCell *cell = (WCFavoriteCell *)[self.favoritesTableView cellForRowAtIndexPath:indexPath];
        
        if (cell.isSelected)
        {
            [cellIndicesToBeDeleted addObject:indexPath];
            [[WCFavoritesManager sharedInstance].favorites removeObject:cell.favorite];
            /*
             perform deletion on data source
             object here with i as the index
             for whatever array-like structure
             you're using to house the data
             objects behind your UITableViewCells
             */
        }
    }
    [self.favoritesTableView deleteRowsAtIndexPaths:cellIndicesToBeDeleted
                     withRowAnimation:UITableViewRowAnimationLeft];
    
    // not sure if it is needed
    [self.favoritesTableView reloadData];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WCFavoriteCell *cell = (WCFavoriteCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.isEditing = YES;
    
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [WCFavoritesManager sharedInstance].favorites.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WCFavoriteCell heightForCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WCFavoriteCell *cell = [tableView dequeueReusableCellWithIdentifier:kFavoriteCellReuseIdentifier];
    
    if (cell == nil)
        cell = [[WCFavoriteCell alloc] initWithReuseIdentifier:kFavoriteCellReuseIdentifier];
    
    cell.favorite = (WCFavorite *)[[WCFavoritesManager sharedInstance].favorites objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WCFavoriteCell *cell = [tableView dequeueReusableCellWithIdentifier:kFavoriteCellReuseIdentifier];
    
    if (cell == nil)
        cell = [[WCFavoriteCell alloc] initWithReuseIdentifier:kFavoriteCellReuseIdentifier];
    
    cell.favorite = (WCFavorite *)[[WCFavoritesManager sharedInstance].favorites objectAtIndex:indexPath.row];
    self.selectedFavorite = cell.favorite;
    
    if (self.isEditing == NO)
    {
        NSString *message = [NSString stringWithFormat:NSLocalizedString(@"Do you want to navigate to \"%@\"?\nThis action will open Apple Map.", @""), cell.favorite.note];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"Cancel", @"")
                                                  otherButtonTitles:NSLocalizedString(@"OK", @""),nil];
        
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSDictionary *addressDict = @{(NSString *)kABPersonAddressStreetKey: self.selectedFavorite.address};
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.selectedFavorite.lat, self.selectedFavorite.lng);
        // Create an MKMapItem to pass to the Maps app
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:addressDict];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [mapItem setName:NSLocalizedString(self.selectedFavorite.note, @"")];
        // Pass the map item to the Maps app
        [mapItem openInMapsWithLaunchOptions:@{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving}];
    }
}

@end

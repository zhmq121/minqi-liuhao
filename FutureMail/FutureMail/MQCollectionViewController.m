//
//  MQCollectionViewController.m
//  ImageTest
//
//  Created by Minqi Zhou on 12/14/13.
//  Copyright (c) 2013 Minqi Zhou. All rights reserved.
//

#import "MQCollectionViewController.h"
#import "MOGlassButton.h"
#import "HMAppDelegate.h"
#import "HMMailComposeViewController.h"
#import "HMSubTitleView.h"
#import "HMImageFilterView.h"

@implementation MQCollectionViewController


- (id)init {

    self = [super init];
    
    if (self) {
        HMSubTitleView *titleView = [[HMSubTitleView alloc] init];
        [self setupAppearanceViewOne];
        [self.view addSubview:titleView];
    }
    
    return self;
}




-(void) setupAppearanceViewOne
{
    UIBarButtonItem *cameraBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(selectPicture:)];
    
    HMAppDelegate *appDelegate = [HMAppDelegate appDelegate];

    [appDelegate.navigationController setNavigationBarHidden:NO];
    appDelegate.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    [[self navigationItem] setRightBarButtonItem:cameraBarButtonItem];
    
}

-(void) setupAppearanceViewTwo
{
    UIBarButtonItem *saveBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(didSelectPicture:)];
    
    HMAppDelegate *appDelegate = [HMAppDelegate appDelegate];
    
    [appDelegate.navigationController setNavigationBarHidden:NO];
    [[self navigationItem] setRightBarButtonItem:saveBarButtonItem];
    
}

-(void) selectPicture:(id) sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];

    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imagePicker setDelegate:self];
    
    [self presentViewController:imagePicker animated:YES completion:NULL];
}


-(void) didSelectPicture:(id) sender
{
    HMAppDelegate *appDelegate = [HMAppDelegate appDelegate];
    HMMailComposeViewController *viewController = [[HMMailComposeViewController alloc] init];
    
    UIImageView *detailView = (UIImageView*)[self.view viewWithTag:detailViewTag];
    
    //pass the selected image to the next view controller.
    [viewController selectImage:detailView.image];
    //viewController.selectedImage = detailView;
    [appDelegate.navigationController pushViewController:viewController animated:YES];
}



-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.view = nil;
    HMImageFilterView *filterView = [[HMImageFilterView alloc] init];
    UIImageView *detailView = (UIImageView*)[filterView viewWithTag:detailViewTag];
    
    
    detailView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    filterView.currImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self setupAppearanceViewTwo];
    self.view = filterView;
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    //[self.collectionView reloadData];
}



/*
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        self.photoAlbumLayout.numberOfColumns = 3;
        
        // handle insets for iPhone 4 or 5
        CGFloat sideInset = [UIScreen mainScreen].preferredMode.size.width == 1136.0f ?
        45.0f : 25.0f;
        
        self.photoAlbumLayout.itemInsets = UIEdgeInsetsMake(22.0f, sideInset, 13.0f, sideInset);
        
    } else {
        self.photoAlbumLayout.numberOfColumns = 2;
        self.photoAlbumLayout.itemInsets = UIEdgeInsetsMake(22.0f, 22.0f, 13.0f, 22.0f);
    }
}
*/
 

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Create and initialize a tap gesture

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  HMMailComposeViewController.m
//  FutureMail
//
//  Created by Minqi Zhou on 12/22/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "HMMailComposeViewController.h"
#import "HMAppDelegate.h"
#import "HMEmailComposerView.h"
#import "ColorPickerViewController.h"


@implementation HMMailComposeViewController
@synthesize selectedImage = _selectedImage;

-(id) init {
    self = [super init];
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.size.height -= 44.0f;

    HMEmailComposerView *view = [[HMEmailComposerView alloc] initWithFrame:frame];
    [view registerDelegate:self];
    self.view = view;
    return self;
}

- (void) selectImage:(UIImage*)image {
    HMEmailComposerView *view = (HMEmailComposerView*)self.view;
    view.selectedImage = image;
}


-(IBAction) selectColor:(id)sender {
    // Make a new ColorPickerViewController with the interface defined in the referenced nib:
    ColorPickerViewController *colorPickerViewController =
    [[ColorPickerViewController alloc] initWithNibName:@"ColorPickerViewController" bundle:nil];
    
    // The ColorPickerViewController needs a delegate to send the results back to.
    // Here, we'll use self, and implement (colorPickerViewController: didSelectColor:) below.
    colorPickerViewController.delegate = self;
    
    // The defaults key helps you keep track of the color we're supposed to be selecting
    colorPickerViewController.defaultsKey = @"BackgroundColor";
    
    // Slides the color picker view in place.
    [self presentViewController:colorPickerViewController animated:YES completion:NULL];

}

// Delegate method handling the result
- (void)colorPickerViewController:(ColorPickerViewController *)colorPicker didSelectColor:(UIColor *)color {
    
    // We're going to save the color into the user preferences, so we need to pack it into an NSData Object.
    NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:color];
    [[NSUserDefaults standardUserDefaults] setObject:colorData forKey:colorPicker.defaultsKey];
    
    // If you just want to use the color right away, go ahead and use the passed UIColor* parameter
    //if ([colorPicker.defaultsKey isEqualToString:@"BackgroundColor"])
        //colorSwatch.backgroundColor = color;
    HMEmailComposerView *view = (HMEmailComposerView*)self.view;
    view.body.textColor = color;
    [colorPicker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)viewDidDisappear:(BOOL)animated {
  
    
    
}
@end

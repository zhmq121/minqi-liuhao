//
//  WCCurrentParkingViewController.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 8/28/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCCurrentParkingViewController.h"
#import "WCMapView.h"
#import "WCGlassGreenButton.h"
#import "WCMainMenuButton.h"
#import "WCGeoManager.h"
#import "WCPlace.h"
#import "WCIconAnnotationView.h"
#import "WCAppDataManager.h"
#import "WCFavoritesManager.h"
#import "WCNotificationManager.h"

const CGFloat kTopbarViewHeight = 50;
const CGFloat kTopbarButtonMargin = 2;
const CGFloat kParkingMeterSettingViewHeight = 280;
const CGFloat kParkingMeterSettingTitleLabelHeight = 30;
const CGFloat kRemainingTimeLabelHeight = 15;
const CGFloat kDistanceLabelHeight = 15;

const CGFloat kParkingMeterSettingButtonMargin = 3;

@interface WCCurrentParkingViewController ()

@property (assign) BOOL isParkingMeterSettingViewVisible;
@property (strong) UIScrollView *scrollView;

@property (strong) UIView *topbarView;
@property (strong) WCGlassGreenButton *topbarButton;
@property (strong) UIView *parkingMeterSettingView;

@property (strong) UIDatePicker *timePicker;

@property (strong) WCMainMenuButton *timePickerConfirmButton;
@property (strong) WCMainMenuButton *timePickerCancelButton;

@property (strong) WCMapView *wcMapView;

@property (strong) UILabel *remainingTimeLabel;
@property (strong) UILabel *distanceLabel;

@property (strong) NSTimer *remainingTimeUpdateTimer;
@property (assign) BOOL isParked;

@property (strong) UIImageView *arrowView;
@end

@implementation WCCurrentParkingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"My Car", @"");
    __weak typeof(self) weakSelf = self;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frameWidth, self.contentView.frameHeight)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    
    self.wcMapView = [[WCMapView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.frameWidth, self.scrollView.frameHeight)];
    [self.wcMapView setCenterToCurrentLocationForced:NO];
    self.wcMapView.delegate = self;
    [self.scrollView addSubview:self.wcMapView];
    
    self.topbarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.frameWidth, kTopbarViewHeight)];
    self.topbarView.backgroundColor = [UIColor clearColor];
    self.topbarButton = [[WCGlassGreenButton alloc] initWithFrame:CGRectMake(kTopbarButtonMargin,
                                                                             kTopbarButtonMargin,
                                                                             self.topbarView.frameHeight - 2 * kTopbarButtonMargin,
                                                                             self.topbarView.frameHeight - 2 * kTopbarButtonMargin)];

    self.topbarButton.titleLabel.numberOfLines = 2;
    self.topbarButton.titleLabel.font = [UIFont lightWCFontOfSize:18];
    [self.topbarButton addTarget:self action:@selector(topBarButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.topbarView addSubview:self.topbarButton];
    
    [self.scrollView addSubview:self.topbarView];
    
    self.arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"direction_arrow.png"]];
    self.arrowView.frameOrigin = CGPointMake(self.topbarView.frameX + 3, self.topbarView.frameBottom + 4);
    [self.scrollView addSubview:self.arrowView];
    
    
    self.distanceLabel = [[UILabel alloc] init];
    self.distanceLabel.backgroundColor = [UIColor WCLoungeBuddyColor];
    self.distanceLabel.textColor = [UIColor whiteColor];
    self.distanceLabel.font = [UIFont lightWCFontOfSize:17];
    self.distanceLabel.hidden = YES;
    [self.scrollView addSubview:self.self.distanceLabel];
    
    
    self.remainingTimeLabel = [[UILabel alloc] init];
    self.remainingTimeLabel.backgroundColor = [UIColor WCLoungeBuddyColor];
    self.remainingTimeLabel.textColor = [UIColor whiteColor];
    self.remainingTimeLabel.font = [UIFont lightWCFontOfSize:17];
    self.remainingTimeLabel.hidden = YES;
    [self.scrollView addSubview:self.remainingTimeLabel];
    
    
    self.parkingMeterSettingView = [[UIView alloc] initWithFrame:[self parkingMeterSettingViewHiddenFrame]];
    self.parkingMeterSettingView.backgroundColor = [UIColor whiteColor];

    UILabel *parkingMeterSettingTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.parkingMeterSettingView.frameWidth, kParkingMeterSettingTitleLabelHeight)];
    parkingMeterSettingTitleLabel.backgroundColor = [UIColor WCBlackColorR36G37B42Alpha0_5];
    parkingMeterSettingTitleLabel.font = [UIFont lightWCFontOfSize:18];
    parkingMeterSettingTitleLabel.text = NSLocalizedString(@"Parking meter", @"");
    parkingMeterSettingTitleLabel.textColor = [UIColor whiteColor];
    parkingMeterSettingTitleLabel.textAlignment = NSTextAlignmentCenter;
    [parkingMeterSettingTitleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showParkingMeterSettingView)]];
    parkingMeterSettingTitleLabel.userInteractionEnabled = YES;
    [self.parkingMeterSettingView addSubview:parkingMeterSettingTitleLabel];
    
    self.timePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,
                                                                     parkingMeterSettingTitleLabel.frameHeight,
                                                                     self.scrollView.frameWidth,
                                                                     0)];
    self.timePicker.backgroundColor = [UIColor clearColor];
    self.timePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    [self.timePicker setCountDownDuration:3600];
    self.timePicker.minuteInterval = 5;
    [self.parkingMeterSettingView addSubview:self.timePicker];
    
    self.timePickerConfirmButton = [[WCMainMenuButton alloc] initWithFrame:CGRectMake(kParkingMeterSettingButtonMargin,
                                                                                     parkingMeterSettingTitleLabel.frameHeight + self.timePicker.frameHeight + kParkingMeterSettingButtonMargin,
                                                                                      self.parkingMeterSettingView.frameWidth / 2 - 2 * kParkingMeterSettingButtonMargin, self.parkingMeterSettingView.frameHeight - parkingMeterSettingTitleLabel.frameHeight - self.timePicker.frameHeight - kParkingMeterSettingButtonMargin * 2)];
    self.timePickerConfirmButton.title = NSLocalizedString(@"Confirm", @"");
    self.timePickerConfirmButton.titleLabel.font = [UIFont ultraLightWCFontOfSize:18];
    [self.timePickerConfirmButton addTarget:self action:@selector(confirmButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.parkingMeterSettingView addSubview:self.timePickerConfirmButton];
    
    self.timePickerCancelButton = [[WCMainMenuButton alloc] initWithFrame:CGRectMake(self.parkingMeterSettingView.frameWidth / 2 + kParkingMeterSettingButtonMargin,
                                                                                      parkingMeterSettingTitleLabel.frameHeight + self.timePicker.frameHeight + kParkingMeterSettingButtonMargin,
                                                                                      self.parkingMeterSettingView.frameWidth / 2 - 2 * kParkingMeterSettingButtonMargin, self.parkingMeterSettingView.frameHeight - parkingMeterSettingTitleLabel.frameHeight - self.timePicker.frameHeight - kParkingMeterSettingButtonMargin * 2)];
    self.timePickerCancelButton.title = NSLocalizedString(@"Cancel", @"");
    self.timePickerCancelButton.titleLabel.font = [UIFont ultraLightWCFontOfSize:18];
    self.timePickerCancelButton.actionBlock = ^{
        [weakSelf hideParkingMeterSettingView];
    };
    [self.parkingMeterSettingView addSubview:self.timePickerCancelButton];

    [self.scrollView addSubview:self.parkingMeterSettingView];
    [self.contentView addSubview:self.scrollView];
    
    [self updateUI];
}

- (void)updateUI
{
    // If the car is still there, we show it.
    WCPlace *carPlace = [WCAppDataManager sharedInstance].carPlace;
    if (carPlace != nil)
    {
        self.isParked = YES;
        [self.wcMapView.mapView addAnnotation:carPlace];
        
        self.topbarButton.title = NSLocalizedString(@"Stop", @"");
        [self.topbarButton setBackgroundImage:[UIImage imageWithColor:[UIColor WCRedColorR209G68B79Alpha1]] forState:UIControlStateNormal];
        
        NSDate *expireDate = [WCAppDataManager sharedInstance].expireDate;
        if ([expireDate timeIntervalSinceNow] < 0)
        {
            [self showDue];
        }
        else
        {
            self.remainingTimeUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showRemainingTime) userInfo:nil repeats:YES];
        }
        self.remainingTimeLabel.text = nil;
        self.remainingTimeLabel.hidden = NO;
        [self showRemainingTime];
        self.arrowView.hidden = NO;
        self.distanceLabel.hidden = NO;
        [self showDistance];
    }
    else
    {
        self.remainingTimeLabel.hidden = NO;
        self.remainingTimeLabel.hidden = NO;
        self.isParked = NO;
        self.topbarButton.title = NSLocalizedString(@"Start", @"");
        [self.topbarButton setBackgroundImage:[UIImage imageWithColor:[UIColor WCLoungeBuddyColor]] forState:UIControlStateNormal];
        self.arrowView.hidden = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)topBarButtonPressed
{
    // Stop -> Start
    if (self.isParked)
    {
        self.topbarButton.title = NSLocalizedString(@"Start", @"");
        [self.topbarButton setBackgroundImage:[UIImage imageWithColor:[UIColor WCLoungeBuddyColor]] forState:UIControlStateNormal];
        [self hideParkingMeterSettingView];
        self.remainingTimeLabel.hidden = YES;
        self.remainingTimeLabel.backgroundColor = [UIColor WCLoungeBuddyColor];
        self.distanceLabel.hidden = YES;
        // empty parking meter
        self.timePicker.countDownDuration = 0;
        
        [self showSaveToFavoriteDialog];

        [self.remainingTimeUpdateTimer invalidate];
        self.arrowView.hidden = YES;
        
        // cancel the current notification
        [[WCNotificationManager sharedInstance] cancelAllNotifications];
        
        self.isParked = !self.isParked;
    }
    // Start -> Stop
    else
    {
        __weak typeof(self) weakSelf = self;
        
        [[WCGeoManager sharedInstance] getAddress:self.wcMapView.mapView.userLocation.coordinate
                             addCompletionHandler:^(NSString *address) {
                                 self.arrowView.hidden = NO;
                                 
                                 WCPlace *place = [[WCPlace alloc] initWithCoordinate:weakSelf.wcMapView.mapView.userLocation.coordinate
                                                                             withType:WCPlaceTypeCar];
                                 [place setTitle:NSLocalizedString(@"My car location", @"")];
                                 [place setSubtitle:address];
                                 [self.wcMapView setCenterToCurrentLocationForced:YES];
                                 [WCAppDataManager sharedInstance].carPlace = place;
                                 [weakSelf.wcMapView.mapView addAnnotation:place];
                                 self.topbarButton.title = NSLocalizedString(@"Stop", @"");
                                 [self.topbarButton setBackgroundImage:[UIImage imageWithColor:[UIColor WCRedColorR209G68B79Alpha1]] forState:UIControlStateNormal];
                                 
                                 [self showParkingMeterSettingViewForced:YES];
                                 [self showDistance];
                                 self.isParked = !self.isParked;
                             }
                             errorHandler:^(NSError *error){
                                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                                 message:NSLocalizedString(@"Internet network error. Unable to get current location information.", @"")
                                                                                delegate:self
                                                                       cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                                                       otherButtonTitles:nil];
                                 
                                 [alert show];
                             }
         ];
    }
}


- (void)removeCarPlace
{
    [WCAppDataManager sharedInstance].carPlace = nil;
    [self.wcMapView removeAllPinsButUserLocation];
}

- (void)showParkingMeterSettingView
{
    [self showParkingMeterSettingViewForced:NO];
}

- (void)showParkingMeterSettingViewForced:(BOOL)forced
{
    if (forced || (!self.isParkingMeterSettingViewVisible && self.isParked))
    {
        __weak typeof(self) weakSelf = self;
        UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseIn;
        [UIView animateWithDuration:0.25
                              delay:0.0
                            options:options animations:^{
                                weakSelf.parkingMeterSettingView.frame = [weakSelf parkingMeterSettingViewVisibleFrame];
                                weakSelf.isParkingMeterSettingViewVisible = YES;
                            } completion:^(BOOL finished) {}];
    }
}

- (void)hideParkingMeterSettingView
{
    if (self.isParkingMeterSettingViewVisible)
    {
        __weak typeof(self) weakSelf = self;
        UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseIn;
        [UIView animateWithDuration:0.25
                              delay:0.0
                            options:options animations:^{
                                weakSelf.parkingMeterSettingView.frame = [weakSelf parkingMeterSettingViewHiddenFrame];
                                weakSelf.isParkingMeterSettingViewVisible = NO;
                            } completion:^(BOOL finished) {}];
    }
}

- (CGRect)parkingMeterSettingViewHiddenFrame
{
    return CGRectMake(0,
                      self.scrollView.frameHeight - kParkingMeterSettingTitleLabelHeight,
                      self.scrollView.frameWidth,
                      kParkingMeterSettingViewHeight);
}

- (CGRect)parkingMeterSettingViewVisibleFrame
{
    return CGRectMake(0,
                      self.scrollView.frameHeight - kParkingMeterSettingViewHeight,
                      self.scrollView.frameWidth,
                      kParkingMeterSettingViewHeight);
}

- (void)confirmButtonPressed:(id)sender
{
    [WCAppDataManager sharedInstance].expireDate = [[NSDate date] dateByAddingTimeInterval:self.timePicker.countDownDuration];
    [[WCNotificationManager sharedInstance] scheduleTimerNotification];
    self.remainingTimeLabel.text = nil;
    self.remainingTimeLabel.hidden = NO;
    self.remainingTimeLabel.backgroundColor = [UIColor WCLoungeBuddyColor];
    [self showRemainingTime];
    self.remainingTimeUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showRemainingTime) userInfo:nil repeats:YES];
    
    [self hideParkingMeterSettingView];
}

- (void)showRemainingTime
{
    NSTimeInterval parkingMeterIntialVal = [[WCAppDataManager sharedInstance].expireDate timeIntervalSinceNow];
    
    if (parkingMeterIntialVal > 0)
    {
        NSInteger hours = parkingMeterIntialVal / 3600;
        NSInteger minutes = (parkingMeterIntialVal - hours * 3600) / 60;
        
        if (hours == 0)
            self.remainingTimeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Time left: %d min", @""), minutes];
        else
            self.remainingTimeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Time left: %d hr %d min", @""), hours, minutes];
        [self.remainingTimeLabel sizeToFit];
        self.remainingTimeLabel.frame = CGRectMake(self.scrollView.frameWidth - self.remainingTimeLabel.frameWidth - kTopbarButtonMargin,
                                                   30 + kTopbarButtonMargin,
                                                   self.remainingTimeLabel.frameWidth,
                                                   self.remainingTimeLabel.frameHeight);
    }
    else
    {
        [self showDue];
        [self.remainingTimeUpdateTimer invalidate];
    }
}

- (void)showDue
{
    self.remainingTimeLabel.text = NSLocalizedString(@"Time Expired!", @"");
    self.remainingTimeLabel.backgroundColor = [UIColor WCRedColorR209G68B79Alpha1];
    [self.remainingTimeLabel sizeToFit];
    self.remainingTimeLabel.frame = CGRectMake(self.scrollView.frameWidth - self.remainingTimeLabel.frameWidth - kTopbarButtonMargin,
                                               30 + kTopbarButtonMargin,
                                               self.remainingTimeLabel.frameWidth,
                                               self.remainingTimeLabel.frameHeight);
}

- (void)calculateArrowDirection
{
    CLLocationCoordinate2D userCoordinate = self.wcMapView.mapView.userLocation.coordinate;
    CLLocationCoordinate2D carCoordinate = [WCAppDataManager sharedInstance].carPlace.coordinate;
    
    CGFloat angle = atan2f(userCoordinate.longitude - carCoordinate.longitude, userCoordinate.latitude - carCoordinate.latitude);
    CGAffineTransform rotationTransform = CGAffineTransformIdentity;
    rotationTransform = CGAffineTransformMakeRotation(angle);
    self.arrowView.transform = rotationTransform;
}

- (void)calculateViewableRangeBasedOnUserAndCarDistance
{
    CLLocationCoordinate2D userCoordinate = self.wcMapView.mapView.userLocation.coordinate;
    
    CLLocationCoordinate2D carCoordinate = [WCAppDataManager sharedInstance].carPlace.coordinate;
    
    CLLocation *userLocation = [[CLLocation alloc] initWithLatitude:userCoordinate.latitude longitude:userCoordinate.longitude];
    CLLocation *carLocation = [[CLLocation alloc] initWithLatitude:carCoordinate.latitude longitude:carCoordinate.longitude];
    
    CLLocationDistance distance = [userLocation distanceFromLocation:carLocation];
    MKCoordinateRegion viewRegion =  MKCoordinateRegionMakeWithDistance(userCoordinate, 500, 500);
    
    if (distance > 500)
    {
        viewRegion = MKCoordinateRegionMakeWithDistance(userCoordinate, distance * 1.1, distance * 1.1);
    }
    
    MKCoordinateRegion adjustedRegion = [self.wcMapView.mapView regionThatFits:viewRegion];
    [self.wcMapView.mapView setRegion:adjustedRegion animated:NO];
}

- (void)showSaveToFavoriteDialog
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Save And Name This Location", @"")
                                                    message:[NSString stringWithFormat:@"%@",
                                                             [WCAppDataManager sharedInstance].carPlace.subtitle]
                                                   delegate:self 
                                          cancelButtonTitle:NSLocalizedString(@"Cancel", @"")
                                          otherButtonTitles:NSLocalizedString(@"Save", @""),nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;

    [alert show];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {

    }
    else
    {
        // ok
        WCFavorite *favorite = [[WCFavorite alloc] init];
        favorite.lat = [WCAppDataManager sharedInstance].carPlace.coordinate.latitude;
        favorite.lng = [WCAppDataManager sharedInstance].carPlace.coordinate.longitude;
        
        NSString *customizedName = [actionSheet textFieldAtIndex:0].text;
        
        if (customizedName != nil && ![customizedName isEqualToString:@""])
        {
            favorite.note = customizedName;
        }
        else
        {
            favorite.note = NSLocalizedString(@"No Name", @"");
        }

        favorite.address = [[WCAppDataManager sharedInstance].carPlace.subtitle copy];
        favorite.date = [NSDate date];
        [[WCFavoritesManager sharedInstance] addFavorite:favorite];
    }
    
    [self removeCarPlace];
}

- (void)showDistance
{
    self.distanceLabel.hidden = NO;
    [self recalculateDistance];
}

- (void)userLocationUpdated
{
    if (self.isParked)
    {
        [self recalculateDistance];
    }
}

- (void)recalculateDistance
{
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:self.wcMapView.mapView.userLocation.coordinate.latitude
                                                  longitude:self.wcMapView.mapView.userLocation.coordinate.longitude];
    
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:[WCAppDataManager sharedInstance].carPlace.coordinate.latitude
                                                  longitude:[WCAppDataManager sharedInstance].carPlace.coordinate.longitude];
    
    CLLocationDistance distance = [locA distanceFromLocation:locB];
    double distanceInMiles = distance * 0.000621371;
    
    self.distanceLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Distance: %.2f miles", @""), distanceInMiles];
    [self.distanceLabel sizeToFit];
    self.distanceLabel.frame = CGRectMake(self.scrollView.frameWidth - self.distanceLabel.frameWidth - kTopbarButtonMargin,
                                               kTopbarButtonMargin,
                                               self.distanceLabel.frameWidth,
                                               self.distanceLabel.frameHeight);
}

@end

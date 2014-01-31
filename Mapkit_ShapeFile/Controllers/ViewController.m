//
//  ViewController.m
//  Mapkit_ShapeFile
//
//  Created by Al Tyus on 10/13/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //set mapView Delegate and Map Type
    self.mapView.delegate = self;
    [self.mapView setMapType:MKMapTypeSatellite];
    
    //Load initial MapOverlays
    GeoRegionStack *countryRegionStack = [[GeoRegionStack alloc] initWithPathComponent:@"countries"
                                                                         withFieldName:@"CNTRY_NAME"
                                                                    withColorForRegion:nil
                                                                     randomRegionColor:YES];
    [self drawOverlaysWithGeoRegionStack:countryRegionStack
                               onMapView:self.mapView];
}

#pragma mark - IBActions

//Change overlay with segmented control index
- (IBAction)overlayTypeValueChanged:(id)sender {
    if ([sender isKindOfClass:[UISegmentedControl class]])
    {
        [self updateUI];
    }
}

- (IBAction)randomColorValueChanged:(id)sender {
    [self updateUI];
}

#pragma mark - UI

-(void)updateUI
{
    BOOL random;
    
    if (self.randomSwitch.isOn)
    {
        random = YES;
    }
    else random = NO;
    
    //remove existing overlays
    [self.mapView removeOverlays:[self.mapView overlays]];
    
    //Draw Overlays here
    if (self.regionSegmentedControl.selectedSegmentIndex == 0)
    {
        GeoRegionStack *countryRegionStack = [[GeoRegionStack alloc] initWithPathComponent:@"countries"
                                                                             withFieldName:@"CNTRY_NAME"
                                                                        withColorForRegion:[UIColor purpleColor]
                                                                         randomRegionColor:random];
        [self drawOverlaysWithGeoRegionStack:countryRegionStack onMapView:self.mapView];
    }
    else if (self.regionSegmentedControl.selectedSegmentIndex == 1)
    {
        GeoRegionStack *stateRegionStack = [[GeoRegionStack alloc] initWithPathComponent:@"states"
                                                                           withFieldName:@"STATE_NAME"
                                                                      withColorForRegion:[UIColor greenColor]
                                                                       randomRegionColor:random];
        [self drawOverlaysWithGeoRegionStack:stateRegionStack onMapView:self.mapView];
    }
    else if (self.regionSegmentedControl.selectedSegmentIndex == 2)
    {
        GeoRegionStack *nationalParkRegionStack = [[GeoRegionStack alloc] initWithPathComponent:@"ne_10m_parks_and_protected_lands_area"
                                                                                  withFieldName:@"Name"
                                                                             withColorForRegion:[UIColor grayColor]
                                                                              randomRegionColor:random];
        [self drawOverlaysWithGeoRegionStack:nationalParkRegionStack onMapView:self.mapView];
    }
    
}
@end

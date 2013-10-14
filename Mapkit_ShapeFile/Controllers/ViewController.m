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
                                                              withColorStringForRegion:@"yellowColor"];
    [self drawOverlaysWithGeoRegionStack:countryRegionStack onMapView:self.mapView];
}

//Change overlay with segmented control index
- (IBAction)overlayTypeValueChanged:(id)sender {
    if ([sender isKindOfClass:[UISegmentedControl class]])
    {
        //remove existing overlays
        [self.mapView removeOverlays:[self.mapView overlays]];
        UISegmentedControl *control = (UISegmentedControl *)sender;
        if (control.selectedSegmentIndex == 0)
        {
            GeoRegionStack *countryRegionStack = [[GeoRegionStack alloc] initWithPathComponent:@"countries"
                                                                                 withFieldName:@"CNTRY_NAME"
                                                                      withColorStringForRegion:@"yellowColor"];
            [self drawOverlaysWithGeoRegionStack:countryRegionStack onMapView:self.mapView];
        }
        else if (control.selectedSegmentIndex == 1)
        {
            GeoRegionStack *stateRegionStack = [[GeoRegionStack alloc] initWithPathComponent:@"states"
                                                                               withFieldName:@"STATE_NAME"
                                                                          withColorStringForRegion:@"greenColor"];
            [self drawOverlaysWithGeoRegionStack:stateRegionStack onMapView:self.mapView];
        }
        else if (control.selectedSegmentIndex == 2)
        {
            GeoRegionStack *nationalParkRegionStack = [[GeoRegionStack alloc] initWithPathComponent:@"ne_10m_parks_and_protected_lands_area" withFieldName:@"Name" withColorStringForRegion:@"grayColor"];
            [self drawOverlaysWithGeoRegionStack:nationalParkRegionStack onMapView:self.mapView];
        }
    }
}





@end

//
//  ViewController.m
//  Mapkit_ShapeFile
//
//  Created by Al Tyus on 10/13/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+MapOverlayCategory.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

#pragma mark - LifeCycle Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.mapView.delegate = self;
    [self.mapView setMapType:MKMapTypeSatellite];
    
    
    
    //NSLog(@"%@",[stateRegionStack.geoRegions[23] name]);
    
    
    
    
    
    //GeoRegionStack *nationalParkRegionStack = [[GeoRegionStack alloc] initWithPathComponent:@"ne_10m_parks_and_protected_lands_area" withFieldName:@"Name" withColorForRegion:[UIColor grayColor]];
    
    
    //[self drawOverlaysWithGeoRegionStack:nationalParkRegionStack onMapView:self.mapView];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)overlayTypeValueChanged:(id)sender {
    if ([sender isKindOfClass:[UISegmentedControl class]])
    {
        UISegmentedControl *control = (UISegmentedControl *)sender;
        if (control.selectedSegmentIndex == 0)
        {
            [self.mapView removeOverlays:[self.mapView overlays]];
            NSLog(@"Index = 0");
            GeoRegionStack *countryRegionStack = [[GeoRegionStack alloc] initWithPathComponent:@"countries"
                                                                                 withFieldName:@"CNTRY_NAME"
                                                                            withColorForRegion:[UIColor purpleColor]];
            [self drawOverlaysWithGeoRegionStack:countryRegionStack onMapView:self.mapView];
        }
        else if (control.selectedSegmentIndex ==1)
        {
            [self.mapView removeOverlays:[self.mapView overlays]];
            NSLog(@"Index = 1");
            GeoRegionStack *stateRegionStack = [[GeoRegionStack alloc] initWithPathComponent:@"states"
                                                                               withFieldName:@"STATE_NAME"
                                                                          withColorForRegion:[UIColor greenColor]];
            [self drawOverlaysWithGeoRegionStack:stateRegionStack onMapView:self.mapView];
        }
    }
}





@end

//
//  ViewController.m
//  Mapkit_ShapeFile
//
//  Created by Al Tyus on 10/13/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import "ViewController.h"
#import "GeoRegionStack.h"

#import <MapKit/MapKit.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.mapView setMapType:MKMapTypeSatellite];
    GeoRegionStack *stateRegionStack = [[GeoRegionStack alloc] initWithPathComponent:@"states"
                                                                  withFieldName:@"STATE_NAME"
                                                             withColorForRegion:[UIColor greenColor]];
    
    NSLog(@"%@",[stateRegionStack.geoRegions[23] name]);
    
    GeoRegionStack *countryRegionStack = [[GeoRegionStack alloc] initWithPathComponent:@"countries"
                                                                         withFieldName:@"CNTRY_NAME"
                                                                    withColorForRegion:[UIColor orangeColor]];
    NSLog(@"%@",[countryRegionStack.geoRegions[0] name]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

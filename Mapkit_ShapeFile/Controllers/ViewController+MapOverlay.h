//
//  ViewController+MapOverlay.h
//  Mapkit_ShapeFile
//
//  Created by Al Tyus on 10/14/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeoRegionStack.h"
#import "GeoRegion.h"
#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface UIViewController (MapOverlay)
-(void)drawOverlaysWithGeoRegionStack:(GeoRegionStack *)stack onMapView:(MKMapView *)mapView;
- (UIColor *)randomColor;
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay;

@end

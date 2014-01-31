//
//  ViewController+MapOverlay.m
//  Mapkit_ShapeFile
//
//  Created by Al Tyus on 10/14/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import "ViewController+MapOverlay.h"

@implementation ViewController (MapOverlay)

#pragma mark - Draw Overlays
-(void)drawOverlaysWithGeoRegionStack:(GeoRegionStack *)stack onMapView:(MKMapView *)mapView
{
    self.geoRegionDict = [[NSMutableDictionary alloc] init];
    
    for (GeoRegion *region in stack.geoRegions)
    {
        for (Polygon *polygon in region.polygons)
        {
            int count = [polygon.coordinates count];
            CLLocationCoordinate2D coords[count];
            
            for (int c=0; c<count; c++)
            {
                NSValue *coordValue = polygon.coordinates[c];
                CLLocationCoordinate2D coord = [coordValue MKCoordinateValue];
                coords[c] = coord;
            }
            MKPolygon *polygon = [MKPolygon polygonWithCoordinates:coords count:count];
            polygon.title = region.name;
            [self.geoRegionDict setObject:region forKey:region.name];
            [mapView addOverlay:polygon];
        }
    }
}

#pragma mark - MapViewDelegate

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolygonRenderer *renderer = [[MKPolygonRenderer alloc] initWithPolygon:overlay];
    if ([overlay isKindOfClass:[MKPolygon class]])
    {
        GeoRegion *myRegion = [self.geoRegionDict objectForKey:[(MKPolygon *)overlay title]];
        if (myRegion)
        {
            renderer.fillColor = myRegion.color;
            renderer.strokeColor = [UIColor blackColor];
            renderer.lineWidth = 1.0;
            renderer.lineCap = kCGLineCapRound;
        }
        
        return renderer;
    }
    else return nil;
    
}

@end


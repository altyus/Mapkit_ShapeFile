//
//  UIViewController+MapOverlayCategory.m
//  Mapkit_ShapeFile
//
//  Created by Al Tyus on 10/13/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import "UIViewController+MapOverlayCategory.h"

@implementation UIViewController (MapOverlayCategory)

#pragma mark - Draw Overlays
-(void)drawOverlaysWithGeoRegionStack:(GeoRegionStack *)stack onMapView:(MKMapView *)mapView
{
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
            [mapView addOverlay:polygon];
        }
    }
}

#define ALPHAVALUE  .60f
- (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *randomColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:ALPHAVALUE];
    return randomColor;
}

#pragma mark - MapViewDelegate

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolygonRenderer *renderer = [[MKPolygonRenderer alloc] initWithPolygon:overlay];
    
    if ([overlay isKindOfClass:[MKPolygon class]])
    {
        //set fillColor to region.color if you want to use a uniform color for all regions
        //renderer.fillColor = region.color;
        renderer.fillColor = [self randomColor];
        renderer.strokeColor = [UIColor blackColor];
        renderer.lineWidth = 1;
        renderer.lineCap = kCGLineCapRound;

        return renderer;
    }
    else return nil;
    
}

@end

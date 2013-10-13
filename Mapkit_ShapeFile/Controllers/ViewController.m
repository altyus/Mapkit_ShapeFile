//
//  ViewController.m
//  Mapkit_ShapeFile
//
//  Created by Al Tyus on 10/13/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) GeoRegionStack *regionStack;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.mapView setMapType:MKMapTypeSatellite];
    self.mapView.delegate = self;
    GeoRegionStack *stateRegionStack = [[GeoRegionStack alloc] initWithPathComponent:@"states"
                                                                  withFieldName:@"STATE_NAME"
                                                             withColorForRegion:[UIColor greenColor]];
    
    NSLog(@"%@",[stateRegionStack.geoRegions[23] name]);
    
    self.regionStack = [[GeoRegionStack alloc] initWithPathComponent:@"countries"
                                                                         withFieldName:@"CNTRY_NAME"
                                                                    withColorForRegion:[UIColor orangeColor]];
    NSLog(@"%@",[self.regionStack.geoRegions[0] name]);
    
    [self drawOverlaysWithGeoRegionStack:self.regionStack];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)drawOverlaysWithGeoRegionStack:(GeoRegionStack *)stack
{
    //int numRegions = [stack.geoRegions count];
    
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
            [self.mapView addOverlay:polygon];
        }
    }
    
    
}

#pragma mark - MapViewDelegate

//Deprecated in iOS 7 implementing renderer for overlay instead
//-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
//{
//    
//}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolygonRenderer *renderer = [[MKPolygonRenderer alloc] initWithPolygon:overlay];
    
    if ([overlay isKindOfClass:[MKPolygon class]])
    {
        for (GeoRegion *region in self.regionStack.geoRegions)
        {
            renderer.fillColor = region.color;
            renderer.strokeColor = [UIColor blackColor];
            renderer.lineWidth = 1;
            renderer.lineCap = kCGLineCapRound;
        }
        return renderer;
    }
    else return nil;
    
}




@end

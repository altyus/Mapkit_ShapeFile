//
//  ViewController.h
//  Mapkit_ShapeFile
//
//  Created by Al Tyus on 10/13/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ViewController+MapOverlay.h"

@interface ViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) NSMutableDictionary *geoRegionDict;

@end

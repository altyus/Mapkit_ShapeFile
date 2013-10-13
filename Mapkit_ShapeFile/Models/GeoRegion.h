//
//  GeoRegion.h
//  Mapkit_ShapeFile
//
//  Created by Al Tyus on 10/13/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "shapefil.h"
#import <MapKit/MapKit.h>

@interface GeoRegion : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *polygons;
@property (nonatomic, strong) UIColor *color;

@property (nonatomic, assign) double minLat;
@property (nonatomic, assign) double maxLat;
@property (nonatomic, assign) double minLong;
@property (nonatomic, assign) double maxLong;

-(id)initWithShapeObject:(SHPObject *)shape databaseFilePath:(NSString *)dbfPath fieldName:(NSString *)fieldName color:(UIColor *)color;

@end

@interface Polygon : NSObject

@property (nonatomic, strong) NSArray *coordinates;

@end
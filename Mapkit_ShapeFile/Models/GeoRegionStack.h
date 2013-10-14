//
//  GeoRegionStack.h
//  Mapkit_ShapeFile
//
//  Created by Al Tyus on 10/13/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeoRegionStack : NSObject

@property (readonly, nonatomic) NSArray *geoRegions; //Array of GeoRegion Objects

-(id)initWithPathComponent:(NSString *)pathComponent withFieldName:(NSString *)fieldName withColorStringForRegion:(NSString *)color;

@end

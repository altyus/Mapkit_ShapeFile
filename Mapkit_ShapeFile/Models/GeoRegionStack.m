//
//  GeoRegionStack.m
//  Mapkit_ShapeFile
//
//  Created by Al Tyus on 10/13/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import "GeoRegionStack.h"
#import "GeoRegion.h"
@interface GeoRegionStack()
@property (strong, nonatomic) NSMutableArray *geoRegions;
@end

@implementation GeoRegionStack

-(id)initWithPathComponent:(NSString *)pathComponent withFieldName:(NSString *)fieldName withColorStringForRegion:(NSString *)color
{
    self = [super init];
    if (self)
    {
        //open Database
        NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
        //NSString *shpPath = [resourcePath stringByAppendingPathComponent:@"states"];
        NSString *shpPath = [resourcePath stringByAppendingPathComponent:pathComponent];
        const char * pszPath = [shpPath cStringUsingEncoding:NSUTF8StringEncoding];
        SHPHandle shp = SHPOpen(pszPath, "rb");
        int numEntities;
        int shapeType;
        SHPGetInfo(shp, &numEntities, &shapeType, NULL, NULL);
        
        //Iterate through each GeoRegion in database
        if (color)
        {
            NSMutableArray *mutableGeoRegions = [[NSMutableArray alloc] init];
            for (int i=0; i<numEntities; i++)
            {
                SHPObject *shpObject = SHPReadObject(shp, i);
                GeoRegion *geoRegion =[[GeoRegion alloc] initWithShapeObject:shpObject
                                                                databaseFilePath:[NSString stringWithFormat:@"%@.dbf",pathComponent]
                                                                       fieldName:fieldName
                                                                           colorString:color];
                [mutableGeoRegions addObject:geoRegion];
                }
                self.geoRegions = [NSArray arrayWithArray:mutableGeoRegions];
            }
        else
        {
            NSLog(@"Can't initialize Shapes without Color");
        }
        
        
        SHPClose(shp);
    }
    return self;
}

@end

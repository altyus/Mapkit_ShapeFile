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

-(id)initWithPathComponent:(NSString *)pathComponent withFieldName:(NSString *)fieldName withColorForRegion:(UIColor *)color randomRegionColor:(BOOL)random
{
    self = [super init];
    if (self)
    {
        _randomColor = random;
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
        
            NSMutableArray *mutableGeoRegions = [[NSMutableArray alloc] init];
        
        for (int i=0; i<numEntities; i++)
        {
            SHPObject *shpObject = SHPReadObject(shp, i);
            GeoRegion *geoRegion = nil;
            
            if (_randomColor)
            {
                geoRegion =[[GeoRegion alloc] initWithShapeObject:shpObject
                                                                databaseFilePath:[NSString stringWithFormat:@"%@.dbf",pathComponent]
                                                                       fieldName:fieldName
                                                                           color:[self generateRandColor]];
            }
            else if (!random)
            {
                geoRegion =[[GeoRegion alloc] initWithShapeObject:shpObject
                                                 databaseFilePath:[NSString stringWithFormat:@"%@.dbf",pathComponent]
                                                        fieldName:fieldName
                                                            color:color];
            }
            [mutableGeoRegions addObject:geoRegion];
        }
        
        self.geoRegions = [NSArray arrayWithArray:mutableGeoRegions];
        SHPClose(shp);
    }
    return self;
}

#define ALPHAVALUE  1.0f
- (UIColor *)generateRandColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *randomColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:ALPHAVALUE];
    return randomColor;
}
@end

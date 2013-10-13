//
//  GeoRegion.m
//  Mapkit_ShapeFile
//
//  Created by Al Tyus on 10/13/13.
//  Copyright (c) 2013 Al Tyus. All rights reserved.
//

#import "GeoRegion.h"

@implementation Polygon
@end
@implementation GeoRegion

#pragma mark - Initializers

-(id)initWithShapeObject:(SHPObject *)shape databaseFilePath:(NSString *)dbfPath fieldName:(NSString *)fieldName color:(UIColor *)color
{
    self = [super init];
    if (self)
    {
        int numParts = shape->nParts;
        int totalVertexCount = shape->nVertices;
        
        _minLat = shape->dfYMin;
        _maxLat = shape->dfYMax;
        _minLong = shape->dfXMin;
        _maxLong = shape->dfXMax;
        
        _color = color;
        
        //Build Array of Polygons for shape 
        NSMutableArray *polygons = [NSMutableArray arrayWithCapacity:numParts];
        for (int n=0; n<numParts; n++)
        {
            int startVertex = shape->panPartStart[n];
            int partVertexCount = (n == numParts - 1) ? totalVertexCount - startVertex : shape->panPartStart[n+1] - startVertex;
            Polygon *polygon = [[Polygon alloc] init];
            NSMutableArray *coordinates = [NSMutableArray arrayWithCapacity:partVertexCount];
            int endIndex = startVertex + partVertexCount;
            for (int pv = startVertex; pv < endIndex; pv++)
            {
                CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(shape->padfY[pv],
                                                                          shape->padfX[pv]);
                [coordinates addObject:[NSValue valueWithMKCoordinate:coord]];
                polygon.coordinates = coordinates;
            }
            [polygons addObject:polygon];
            _polygons = polygons;
        }
        
        //initialize the region's name property
        NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
        NSString *regionDBFPath = [resourcePath stringByAppendingPathComponent:dbfPath];
        const char *pszPath = [regionDBFPath cStringUsingEncoding:NSUTF8StringEncoding];
        DBFHandle dbf = DBFOpen(pszPath, "rb");

        const char *cFieldName = [fieldName cStringUsingEncoding:NSUTF8StringEncoding];
        int nameIndex = DBFGetFieldIndex(dbf, cFieldName);
        _name = [NSString stringWithUTF8String:DBFReadStringAttribute(dbf,shape->nShapeId, nameIndex)];
        DBFClose(dbf);
    }
    return self;
}



@end

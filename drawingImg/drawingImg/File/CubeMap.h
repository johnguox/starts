//
//  CubeMap.h
//  drawingImg
//
//  Created by 郭笑兵pro on 2018/3/15.
//  Copyright © 2018年 郭笑兵pro. All rights reserved.
//

#ifndef CubeMap_h
#define CubeMap_h

#include <stdio.h>
typedef struct CubeMap CubeMap;

struct CubeMap {
    int length;
    float dimension;
    float *data;
};

struct CubeMap createCubeMap(float minHueAngle, float maxHueAngle);

#endif /* CubeMap_h */

//
//  NSString+Extension.m
//  测试
//
//  Created by 郭笑兵pro on 2018/3/19.
//  Copyright © 2018年 郭笑兵pro. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)



- (void) location2D {
    
    NSMutableArray * byte = [[NSMutableArray alloc]initWithArray:[self componentsSeparatedByString:@","]];
    int i = -1;
    
    NSInteger longdegree = [byte[1 + i] integerValue] * 256 + [byte[2 + i] integerValue];
    NSInteger longFen = [byte[3 + i] integerValue];
    NSInteger longMiao = [byte[4 + i] integerValue];
    NSInteger longMiaoX = ([byte[5 + i]integerValue] * 16777216 + [byte[6 + i]integerValue] * 65536 + [byte[7 + i]integerValue] * 256 + [byte[8 + i]integerValue]);
    
    
    double  longitude = [self converLnglat:longdegree fen:longFen miao:longMiao miaoX:longMiaoX];
    // 纬度
    NSInteger latDu = [byte[9 + i] integerValue];
    NSInteger latFen = [byte[10 + i] integerValue];
    NSInteger latMiao = [byte[11 + i] integerValue];
    
    double latMiaoX = [byte[12 + i] integerValue] * 16777216 + [byte[13 + i]integerValue] * 65536 + [byte[14 + i]integerValue] * 256 + [byte[15 + i] integerValue];
    
    double latitude = [self converLnglat:latDu fen:latFen miao:latMiao miaoX:latMiaoX];
    
    NSLog(@"经纬度  lon：%f   lat:%f",longitude,latitude);
    
    //转换GPS坐标至百度坐标(加密后的坐标)
//    NSDictionary * testdic = BMKConvertBaiduCoorFrom(CLLocationCoordinate2DMake(latitude,longitude),BMK_COORDTYPE_GPS);
    
    //解密加密后的坐标字典
//    return  BMKCoorDictionaryDecode(testdic);//转换后的百度坐标
}
- (double) converLnglat:(NSInteger) d fen: (NSInteger) f miao: (NSInteger) m miaoX : (NSInteger )x {
    
    NSString * fmStr = [NSString stringWithFormat:@"%ld.%ld", (long)m,(long)x];
    double fm = [fmStr doubleValue];
    double fx = fm / 60;
    NSString * fxStr = [NSString stringWithFormat:@"%ld.%@",(long)f,[[NSString stringWithFormat:@"%f", fx] substringFromIndex:2]];
    double dfS = [fxStr doubleValue];
    double df = dfS / 60;
    
    
    return d + df;
}

@end

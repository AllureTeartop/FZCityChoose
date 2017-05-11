//
//  AreaTool.m
//  picker
//
//  Created by nuoda on 2017/4/1.
//  Copyright © 2017年 Sylar. All rights reserved.
//

#import "AreaTool.h"
#import "AreaModel.h"

@interface AreaTool ()

@property (nonatomic, strong) NSArray *area0;
@property (nonatomic, strong) NSArray *area1;
@property (nonatomic, strong) NSArray *area2;

@end

@implementation AreaTool

+(AreaTool *)sharedInstance{
    
    static dispatch_once_t once = 0;
    static AreaTool *tool;
    dispatch_once(&once, ^{
        tool = [[AreaTool alloc] init];
    });
    return tool;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setAreaSetting];
    }
    return self;
}

-(void)setAreaSetting{
    if (self.areaList) {
        return;
    }
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"json"];
    NSData *data=[NSData dataWithContentsOfFile:jsonPath];
    NSError *error;
    NSArray *result=[NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingAllowFragments
                                                    error:&error];
    self.area0 = [result[0] objectForKey:@"province"];
    self.area1 = [result[1] objectForKey:@"city"];
    self.area2 = [result[2] objectForKey:@"area"];
    
    NSMutableDictionary *tempAreaList = [[NSMutableDictionary alloc] init];
    NSArray *provinceList = [self provinceList];
    for (int i = 0; i < provinceList.count; i ++) {
        AreaModel *provinceModel = provinceList[i];
        NSArray *cityList = [self cityListWithProvinceid:provinceModel.city_code];
        [tempAreaList setValue:cityList forKey:provinceModel.city_code];
        
        for (int j = 0; j < cityList.count; j ++) {
            AreaModel *cityModel = cityList[j];
            NSArray *areaList = [self areaListWithCityid:cityModel.city_code];
            [tempAreaList setValue:areaList forKey:cityModel.city_code];
        }
    }
    self.areaList = [[NSDictionary alloc] init];
    self.areaList = tempAreaList;
}
- (NSArray *)provinceList{
    if (_provinceList) {
        return _provinceList;
    }
    NSMutableArray *provinceArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.area0.count; i ++) {
        AreaModel *model = [[AreaModel alloc] init];
        model.city_code = [self.area0[i] objectForKey:@"areaid"];
        model.city_name = [self.area0[i] objectForKey:@"areaname"];
        [provinceArray addObject:model];
    }
    
    _provinceList = [[NSMutableArray alloc] init];
    _provinceList = provinceArray;
    return provinceArray;
}

- (NSArray *)cityListWithProvinceid:(NSString *)provinceId{
    
    if (self.areaList) {
        return [self.areaList objectForKey:provinceId];
    }
    
    NSMutableArray *cityList = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.area1.count; i ++) {
        if ([[self.area1[i] objectForKey:@"pid"]isEqualToString:provinceId]) {
            NSArray *cityArray = [self.area1[i] objectForKey:@"list"];
            for (int j = 0; j < cityArray.count; j ++) {
                AreaModel *model = [[AreaModel alloc] init];
                model.city_code = [cityArray[j] objectForKey:@"areaid"];
                model.city_name = [cityArray[j] objectForKey:@"areaname"];
                [cityList addObject:model];
            }
            return cityList;
        }
    }
    return cityList;
}

- (NSArray *)areaListWithCityid:(NSString *)cityId{
    
    if (self.areaList) {
        return [self.areaList objectForKey:cityId];
    }
    
    NSMutableArray *areaList = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.area2.count; i ++) {
        if ([[self.area2[i] objectForKey:@"pid"] isEqualToString:cityId]) {
            NSArray *areaArray = [self.area2[i] objectForKey:@"list"];
            for (int j = 0; j < areaArray.count; j ++) {
                AreaModel *model = [[AreaModel alloc] init];
                model.city_code = [areaArray[j] objectForKey:@"areaid"];
                model.city_name = [areaArray[j] objectForKey:@"areaname"];
                if (![model.city_name isEqualToString:@"市辖区"]) {
                    [areaList addObject:model];
                }
            }
            return areaList;
        }
    }
    
    return areaList;
}

- (NSInteger )indexOfProvince:(NSString *)provinceString{
    for (int i = 0; i < self.provinceList.count; i ++) {
        AreaModel *model = self.provinceList[i];
        if ([model.city_name isEqualToString:provinceString]) {
            return i;
        }
    }
    return 0;
}

- (NSInteger)indexOfCity:(NSString *)provinceCode withCityString:(NSString *)cityString{
    NSArray *cityArray = [self cityListWithProvinceid:provinceCode];
    for (int i = 0; i < cityArray.count; i ++) {
        AreaModel *model = cityArray[i];
        if ([model.city_name isEqualToString:cityString]) {
            return i;
        }
    }
    return 0;
}

- (NSInteger)indexOfArea:(NSString *)cityCode withAreaString:(NSString *)areaString{
    NSArray *areaArray = [self areaListWithCityid:cityCode];
    for (int i = 0; i < areaArray.count; i ++) {
        AreaModel *model = areaArray[i];
        if ([model.city_name isEqualToString:areaString]) {
            return i;
        }
    }
    return 0;
}



@end

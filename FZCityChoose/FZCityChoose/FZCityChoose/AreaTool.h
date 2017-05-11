//
//  AreaTool.h
//  picker
//
//  Created by nuoda on 2017/4/1.
//  Copyright © 2017年 Sylar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaTool : NSObject

//身份列表
@property (nonatomic, strong) NSMutableArray *provinceList;
//地区列表
@property (nonatomic, strong) NSDictionary *areaList;

/**
 *  单粒
 *
 *  @return userinfo实例
 */
+(AreaTool *)sharedInstance;

/*!
 *  省份列表
 *
 *  @return 省份列表
 */
- (NSArray *)provinceList;

/*!
 *  获取省份的城市列表
 *
 *  @param provinceId 省份id
 *
 *  @return 城市列表
 */
- (NSArray *)cityListWithProvinceid:(NSString *)provinceId;

/*!
 *  获取城市下的区列表
 *
 *  @param cityId 城市id
 *
 *  @return 区列表
 */
- (NSArray *)areaListWithCityid:(NSString *)cityId;

/*!
 *  返回省份数组所对应的索引
 *
 *  @param provinceString 省份字符串
 *
 *  @return 省份所在数组的索引
 */
- (NSInteger )indexOfProvince:(NSString *)provinceString;

/*!
 *  返回城市数组所对应的索引
 *
 *  @param provinceCode 省份id
 *  @param cityString   城市字符串
 *
 *  @return 城市所在数组的索引
 */
- (NSInteger)indexOfCity:(NSString *)provinceCode withCityString:(NSString *)cityString;

/*!
 *  返回地区数组所对应的索引
 *
 *  @param cityCode   城市id
 *  @param areaString 地区字符串
 *
 *  @return 地区所在数组的索引
 */
- (NSInteger)indexOfArea:(NSString *)cityCode withAreaString:(NSString *)areaString;



@end

//
//  FZCityChooseView.h
//  FZCityChoose
//
//  Created by Florence on 2017/5/11.
//  Copyright © 2017年 AllureTeartop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaModel.h"

typedef void (^SelectCityBlock) (AreaModel *province ,AreaModel *city ,AreaModel *town);

@interface FZCityChooseView : UIView
@property (nonatomic, strong) AreaModel *province;           /** 省 */
@property (nonatomic, strong) AreaModel *city;               /** 市 */
@property (nonatomic, strong) AreaModel *town;               /** 县 */
@property (nonatomic, copy) SelectCityBlock config;
//初始化方法
- (id)initWithFrame:(CGRect)frame
  andItemClickBlock:(SelectCityBlock)config;


- (void)showPickView;

- (void)hidePickView;

@end

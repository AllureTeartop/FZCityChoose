//
//  ViewController.m
//  FZCityChoose
//
//  Created by Florence on 2017/5/11.
//  Copyright © 2017年 AllureTeartop. All rights reserved.
//

#import "ViewController.h"
#import "FZCityChooseView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lable;

@property(nonatomic,strong)FZCityChooseView *chooseView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    _chooseView = [[FZCityChooseView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) andItemClickBlock:^(AreaModel *province, AreaModel *city, AreaModel *town) {
        
        NSString *cityStr = [NSString stringWithFormat:@"%@%@%@",province.city_name,city.city_name,town.city_name];
        _lable.text = cityStr;
    }];
    
    [self.view addSubview:_chooseView];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end

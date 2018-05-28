//
//  ViewController.m
//  Animate
//
//  Created by zhaoml on 2018/3/22.
//  Copyright © 2018年 赵明亮. All rights reserved.
//
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "AnimateBaseView.h"
@interface ViewController ()
@property (nonatomic,strong)AnimateBaseView *abView;
@end

@implementation ViewController


- (AnimateBaseView *)abView {
    if (!_abView) {
        _abView = [[AnimateBaseView alloc] initWithFrame:CGRectMake(0, (SCREEN_HEIGHT - SCREEN_WIDTH)/2, SCREEN_WIDTH, SCREEN_WIDTH)];
    }
    return _abView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.view addGestureRecognizer:tap];
    
    [self.view addSubview:self.abView];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)tapClick {
    self.abView.valueArr = @[@"112",@"113",@"142",@"162",@"712",@"122",@"442",@"545",@"234",@"654",@"22"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

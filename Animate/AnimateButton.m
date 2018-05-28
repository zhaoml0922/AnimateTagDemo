//
//  AnimateButton.m
//  Animate
//
//  Created by zhaoml on 2018/3/22.
//  Copyright © 2018年 赵明亮. All rights reserved.
//

#import "AnimateButton.h"
#import "UIViewExt.h"
@interface AnimateButton()
@property (nonatomic,strong)UIButton *groundBtn;
@end

@implementation AnimateButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = frame.size.width/2.0;
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    
    _groundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _groundBtn.frame = self.bounds;
    _groundBtn.center = CGPointMake(self.width/2, self.height/2);
    _groundBtn.layer.cornerRadius = self.width/2.0;
    _groundBtn.layer.masksToBounds = YES;
    UIImage *image = [UIImage imageNamed:@"图层-1"];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    [_groundBtn setBackgroundImage:image forState:UIControlStateNormal];
    [_groundBtn setBackgroundImage:image forState:UIControlStateHighlighted];
    [_groundBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [_groundBtn setTitle:@"aaa" forState:UIControlStateNormal];
    self.groundBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:_groundBtn];
    
    [self startAnimate];
}

- (void)startAnimate {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    NSMutableArray *values = [NSMutableArray array];
    int temp = arc4random()%4;
    if (temp == 0) {
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(3, 1.0, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-3, 1.0, 1.0)]];
    }else if (temp == 1) {
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-3, 1.0, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(3, 1.0, 1.0)]];
    }else if (temp == 2) {
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(1.0, -3, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(1.0, 3, 1.0)]];
    }
    else{
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(1.0, 3, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(1.0, -3, 1.0)]];
    }
    animation.values = values;
    animation.repeatCount=MAXFLOAT;
    float time = 1;
    animation.duration = time;
      animation.autoreverses = YES;
    [self.layer addAnimation:animation forKey:nil];
}
- (void)setValueString:(NSString *)valueString {
    _valueString = valueString;
    [_groundBtn setTitle:valueString forState:UIControlStateNormal];
}

- (void)btnClick {
    [self hide];
}

- (void)hide {
    CGPoint point = CGPointMake(self.left+self.width/2.0, self.top+self.height/2.0);
    CGFloat width = self.width;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.groundBtn.alpha = 0.0;
        self.frame = CGRectMake(0, 0, width*2, width*2);
        _groundBtn.frame = self.bounds;
        self.groundBtn.center = CGPointMake(width, width);
        _groundBtn.layer.cornerRadius = width;
        self.center = point;
        
        CABasicAnimation * aniScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        aniScale.fromValue = [NSNumber numberWithFloat:1];
        aniScale.toValue = [NSNumber numberWithFloat:4.0];
        aniScale.duration = 0.3;
        aniScale.removedOnCompletion = NO;
        aniScale.repeatCount = 1;
        [_groundBtn.titleLabel.layer addAnimation:aniScale forKey:@"babyCoin_scale"];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end

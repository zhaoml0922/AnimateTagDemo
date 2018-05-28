//
//  AnimateBaseView.m
//  Animate
//
//  Created by zhaoml on 2018/3/22.
//  Copyright © 2018年 赵明亮. All rights reserved.
//



#import "AnimateBaseView.h"
#import "AnimateButton.h"
@interface AnimateBaseView()

@property (nonatomic,strong)NSMutableArray *animateArray;
@property (nonatomic,assign)int buttonWidth;
@property (nonatomic,assign)int gap;
@end
@implementation AnimateBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _buttonWidth = 50;
        _gap = 5;
        self.backgroundColor = [UIColor yellowColor];
        [self startLaod];
    }
    return self;
}

- (void)startLaod {
    _animateArray = [NSMutableArray array];
}

- (void)setValueArr:(NSArray *)valueArr {
    _animateArray = [NSMutableArray array];
    for (id view in self.subviews) {
        [view removeFromSuperview];
    }
    _valueArr = valueArr;
    int width = (int)self.frame.size.width;
    int height = (int)self.frame.size.height;
    for (int i=0; i<valueArr.count; i++) {
        int x = arc4random()%(width-_buttonWidth-_gap);
        int y = arc4random()%(height-_buttonWidth-_gap);
        CGRect rect = CGRectMake(x, y, _buttonWidth, _buttonWidth);
        while ([self ifIntersectWithPosition:rect]) {
            int x = arc4random()%(width-_buttonWidth-_gap);
            int y = arc4random()%(height-_buttonWidth-_gap);
            rect = CGRectMake(x, y, _buttonWidth, _buttonWidth);
        }
        NSString *string = valueArr[i];
        AnimateButton *button = [[AnimateButton alloc] initWithFrame:rect];
        button.valueString = string;
        [self addSubview:button];
        [_animateArray addObject:button];
    }
}
///是否相交
- (BOOL)ifIntersectWithPosition:(CGRect )rect{

    for (int i=0; i<_animateArray.count; i++) {
        AnimateButton *button = _animateArray[i];
        CGRect rect1 = button.frame;
        if ([self distanceForPositionOne:rect andPositonTwo:rect1] < _buttonWidth+_gap) {
            return YES;
        }
    }
    return NO;
}

///中心点距离
- (CGFloat)distanceForPositionOne:(CGRect)rect1 andPositonTwo:(CGRect)rect2 {
    CGFloat x1 = rect1.origin.x;
    CGFloat y1 = rect1.origin.y;
    
    CGFloat x2 = rect2.origin.x;
    CGFloat y2 = rect2.origin.y;
    
    return sqrt((y1-y2) * (y1-y2) + (x1-x2) * (x1 - x2));
}

@end

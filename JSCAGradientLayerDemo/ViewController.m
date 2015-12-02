//
//  ViewController.m
//  JSCAGradientLayerDemo
//
//  Created by jhon.sun on 15/12/2.
//  Copyright © 2015年 jhon.sun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *testLabel;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (nonatomic, strong) NSArray *colorsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.colorsArray = @[(id)[UIColor redColor].CGColor, (id)[UIColor blueColor].CGColor, (id)[UIColor greenColor].CGColor];
    
    //不能添加在testLabel.layer上
    [self.view.layer addSublayer:self.gradientLayer];
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeColors)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)viewDidLayoutSubviews {
    self.gradientLayer.frame = self.testLabel.frame;
    //将testLabel设置为渐变层的mask，一旦设置，testLabel将会从父视图上移除，所以要重新设置testLabel的frame
    _gradientLayer.mask = self.testLabel.layer;
    self.testLabel.frame = self.gradientLayer.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - get
- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.colors = self.colorsArray;
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(1, 1);
    }
    return _gradientLayer;
}

- (NSArray *)colorsArray {
    _colorsArray = @[(id)[self randomColor].CGColor, (id)[self randomColor].CGColor,(id)[self randomColor].CGColor, (id)[self randomColor].CGColor, (id)[self randomColor].CGColor];
    return _colorsArray;
}

#pragma mark - private
- (void)changeColors {
    /*NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.colorsArray];
    id object = [tempArray objectAtIndex:0];
    [tempArray removeObjectAtIndex:0];
    [tempArray addObject:object];
    self.colorsArray = tempArray;*/
    self.gradientLayer.colors = self.colorsArray;
}

// 随机颜色方法
-(UIColor *)randomColor{
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

@end

//
//  ViewController.m
//  testScrollRotate
//
//  Created by donglyu on 11/13/16.
//  Copyright © 2016 donglyu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIActivityIndicatorView *indicatorView;
@property (nonatomic, weak) UIView *blueView;

@end

@implementation ViewController{
    NSNumber *lastValue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // basic view
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    scrollView.delegate  = self;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 2);
    
    // UIActivityIndicatorView
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGRect frame = indicatorView.frame;
    frame.origin = CGPointMake(100, 100);
    indicatorView.frame = frame;
    indicatorView.hidesWhenStopped = NO;
    [self.view addSubview:indicatorView];
    _indicatorView = indicatorView;
    
    
    // rectangle
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(80, 200, 80, 80)];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    _blueView = blueView;
    
    
    
    
    
    
}

#define degreesToRadians(degrees) (M_PI * degrees / 180.0)




#pragma mark - scrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offSetY = scrollView.contentOffset.y;
    NSLog(@"offset: %f", offSetY);
    

    // 1. 基础动画
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                                    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = lastValue;
    animation.toValue =  [NSNumber numberWithFloat:degreesToRadians(offSetY)];
    lastValue = [NSNumber numberWithFloat:degreesToRadians(offSetY)];
    animation.duration  = 0.02;
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.indicatorView.layer addAnimation:animation forKey:nil];
    
    
    // UIView封装动画
    // 2.1 commit方式实现.
    
//    [UIView beginAnimations:@"rotate" context:nil];
//    [UIView setAnimationDuration:0.01];
//    self.indicatorView.transform = CGAffineTransformMakeRotation(degreesToRadians(offSetY));
//    [UIView commitAnimations];
    
    
    // 2.2
    [UIView beginAnimations:@"rotate2" context:nil];
    [UIView setAnimationDuration:0.05]; // 0.01
    self.blueView.transform = CGAffineTransformMakeRotation(degreesToRadians(offSetY));
    //    testView.bounds =  CGRectMake(0,0, 240, 160);
    [UIView commitAnimations];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

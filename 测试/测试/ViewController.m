//
//  ViewController.m
//  测试
//
//  Created by 郭笑兵pro on 2018/3/19.
//  Copyright © 2018年 郭笑兵pro. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Extension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *stri = @"0,106,42,53,0,0,0,53,26,33,59,0,0,0,77";
    [stri location2D];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

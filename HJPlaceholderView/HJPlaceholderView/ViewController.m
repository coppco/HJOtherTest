//
//  ViewController.m
//  HJPlaceholderView
//
//  Created by apple on 2017/5/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+PlaceholderView.h"

@interface ViewController ()
/*<#描述#>*/
@property(nonatomic, assign)NSInteger count;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:(UIBarButtonItemStyleDone) target:self action:@selector(tap:)];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)tap:(UIBarButtonItem *)sender {
    _count += 1;
    if (_count >= 4) {
        _count = 0;
    }
    self.placeholderView.status = _count;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

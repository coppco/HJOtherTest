//
//  CodeLayoutController.m
//  XHJ-autoLayout练习
//
//  Created by coco on 16/3/25.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "CodeLayoutController.h"
#import <Masonry.h>


@interface CodeLayoutController ()

@end

@implementation CodeLayoutController
- (IBAction)home:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  @author XHJ, 16-03-25 15:03:53
     *
     *  在iOS 7中，苹果引入了一个新的属性，叫做[UIViewController setEdgesForExtendedLayout:]，它的默认值为UIRectEdgeAll。当你的容器是navigation controller时，默认的布局将从navigation bar的顶部开始。这就是为什么所有的UI元素都往上漂移了44pt。
     修复这个问题的快速方法就是在方法- (void)viewDidLoad中添加如下一行代码：
     self.edgesForExtendedLayout = UIRectEdgeNone;
     */
//    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    //UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    
    //警告Label
    UILabel *warning = [[UILabel alloc] init];
    warning.backgroundColor = [UIColor blackColor];
    warning.numberOfLines = 0;
    warning.textColor = [UIColor redColor];
    warning.textAlignment = 0;
    [scrollView addSubview:warning];
    [warning mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(10);
        make.right.mas_equalTo(self.view).offset(-10);
        warning.text =@"mas_equalTo和equalTo区别：前者比后者多了类型转换操作，支持CGSize CGPoint NSNumber UIEdgeinsets。mas_equalTo是equalTo的封装，equalTo适用于基本数据类型，而mas_equaalTo适用于类似UIEdgeInsetsMake 等复杂类型，基本上它可以替换equalTo, 当使用scrollview的时候,第一个子控件不能使用top.mas_equalTo(self.view)或者equalTo(self.view), 可以给一个具体的值如.top.mas_equalTo(10)";
    }];
    
    //说明标签
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.backgroundColor = [UIColor redColor];
    tipLabel.numberOfLines = 0;
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.textAlignment = 0;
    [scrollView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(10);
//        make.top.equalTo(self.view).offset(10);
//        make.right.equalTo(self.view).offset(-10);
//        make.left.right.top.equalTo(self.view).insets(UIEdgeInsetsMake(10, 10, 0, 10));
        make.left.mas_equalTo(10);
//        make.top.equalTo(self.view).offset(10);
        make.top.mas_equalTo(warning.mas_bottom).offset(10);
        // 注意：这里直接使用weakSelf.view，相当于weakSelf.view.mas_right
        // 另外：由于要与weakSelf.view.mas_right距离10像素，因此这里值为-10。
        make.right.mas_equalTo(self.view).offset(-10);
        tipLabel.text = @"使用Masonry的时候,如果右和下比某个view小,如果使用eaqualTo(负值)应该是负值, 使用insets的时候是正值.这个标签是使用Masonry完成的纯代码自动布局。这个标签的约束添加方式为：使左、上与父视图的左、上分别相等10，使右边与self.view的右边的相距-10，就可以确定其宽。这里不能使用使右等于scrollview的右，因为scrollview是可以滚动的，其右是不确定的。";
//        [tipLabel sizeToFit];
    }];
    
    UILabel *codeLabel = [[UILabel alloc] init];
    codeLabel.backgroundColor = [UIColor redColor];
    codeLabel.numberOfLines = 0;
    codeLabel.textColor = [UIColor whiteColor];
    codeLabel.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:codeLabel];
    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(tipLabel);  //左右和tipLabel相同
        make.top.equalTo(tipLabel.mas_bottom).offset(10);
        codeLabel.text = @"本标签的约束添加方式为：使左、右与上面的标签的左、右分别对齐，由此就可确定左、右和宽，再使顶部top等于上面的标签的bottom再加上10个像素";
    }];
    
    UIImageView *codeImageView = [[UIImageView alloc] init];
    codeImageView.image = [UIImage imageNamed:@"11.jpg"];
    [scrollView addSubview:codeImageView];
    [codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(codeLabel.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(250, 250));
    }];
    
    // 由于图片过大，需要限制。如果是图片刚好，可以不设置大小的约束，使用下面的方式。
    //  [codeImageView sizeToFit];
    
    // 平分两个控件
    UILabel *avgLabel1 = [[UILabel alloc] init];
    avgLabel1.backgroundColor = [UIColor redColor];
    avgLabel1.numberOfLines = 0;
    avgLabel1.textColor = [UIColor whiteColor];
    avgLabel1.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:avgLabel1];
    avgLabel1.text = @"本控件的约束添加方式为：使left与父视图的left相距10像素，使top=上面的图片的bottom再加40像素，使right=右边这个标签的left再减去20个像素（间隔），使height=80。";
    
    UILabel *avgLabel2 = [[UILabel alloc] init];
    avgLabel2.backgroundColor = [UIColor redColor];
    avgLabel2.numberOfLines = 0;
    avgLabel2.textColor = [UIColor whiteColor];
    avgLabel2.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:avgLabel2];
    avgLabel2.text = @"本控件的约束添加方式为：使right=self.view的right再减去10像素，然后再设置宽、top都与左右的视图一样，就可以实现水平平分了。本控件的约束添加方式为：使right=self.view的right再减去10像素，然后再设置宽、top都与左右的视图一样，就可以实现水平平分了。";
    
    [avgLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(codeImageView.mas_bottom).offset(40);
        make.right.mas_equalTo(avgLabel2.mas_left).offset(-20);
    }];
    [avgLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.width.top.mas_equalTo(avgLabel1);
    }];
    
    // 使用edges使点满整个self.view
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        
        // 如果这两个标签的内容都是不确定的，也就是不确定哪个的内容更多，那么可以这么设置。
        // 这样就可以保证使用内容最多的标签作为scrollview的contentSize参考。
        // 用于确定scrollview的contentSize.height
        make.bottom.mas_greaterThanOrEqualTo(avgLabel1.mas_bottom).offset(40);
        make.bottom.mas_greaterThanOrEqualTo(avgLabel2.mas_bottom).offset(40);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

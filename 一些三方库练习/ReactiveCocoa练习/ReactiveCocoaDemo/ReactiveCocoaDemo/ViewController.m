//
//  ViewController.m
//  ReactiveCocoaDemo
//
//  Created by coco on 16/5/13.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameL;//名字
@property (weak, nonatomic) IBOutlet UITextField *passwordL;//密码
@property (weak, nonatomic) IBOutlet UITextField *phoneL; //手机号
@property (weak, nonatomic) IBOutlet UIButton *loginB; //登录
@property (weak, nonatomic) IBOutlet UIButton *registerB; //注册
@property (weak, nonatomic) IBOutlet UILabel *descriptL;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*测试链式编程*/
    CGFloat result =  [NSObject makeCaculators:^(CaculatorMaker *maker) {
        maker.add(11).sub(10).and.with.muilt(1.1).divide(1.23);
    }];
    NSLog(@"测试链式编程=====%f", result);
    
    /*
    //简单监控用户名输入框,输入一次打印一次
    [self.nameL.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"1%@", x);
         //在这个block里面可以做一些事情,如当用户名为1234的时候清空输入框

        if ([x isEqualToString:@"1234"]) {
            self.nameL.text = nil;
        }
    }];
    */
    
    
     //过滤 当输入框长度>=3的时候才会打印,可以直接修改block的参数类型,
    [[self.nameL.rac_textSignal filter:^BOOL(NSString *text) {
        return text.length >= 3;
    }] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    

    
    /*
    //通过map 改变事件的数据,把字符串变为长度
    [[[self.nameL.rac_textSignal map:^id(NSString *value) {
        return @(value.length);
    }] filter:^BOOL(NSNumber *value) {
        return [value integerValue] >= 3;
    }] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
     */
  
    /*
    RAC(self,nameL.backgroundColor) = [RACSignal combineLatest:@[RACObserve(self.nameL, text)] reduce:^id (NSString *str){
        return str.length >= 3 && str.length <= 6 ? [UIColor blueColor] : (str.length > 6 ? [UIColor redColor] : [UIColor greenColor]);
     }];
    */
    /**
     *  @author XHJ, 16-05-16 14:05:44
     *  使某一个按钮只在用户名和密码都是6位以上才能使用
     *  如果是textfield, 使用rac_textSignal属性,如果使用RACObserve(self.nameL, text)只会走一次.   model可以使用RACObserve方法
     */
    RAC(self.loginB, enabled) = [RACSignal combineLatest:@[self.nameL.rac_textSignal, self.passwordL.rac_textSignal] reduce:^id (NSString *name, NSString *password){
        return @(name.length >= 6 && password.length >= 6);
    }];
    
    /*
     //这个一个错误的写法
    RAC(self.loginB, enabled) = [RACSignal combineLatest:@[RACObserve(self.nameL, text), RACObserve(self.passwordL, text)] reduce:^id (NSString *name, NSString *password){
        return @(name.length >= 6 && password.length >= 6);
    }];
     */
    
    //绑定name的输入框到文本显示框中
//    RAC(self.descriptL, text) = self.nameL.rac_textSignal;
    /*
     使用  @weakify(self) 和 @strongify(self) 解决循环引用问题
     */
    @weakify(self);
    RAC(self.descriptL, text) = [RACSignal combineLatest:@[self.nameL.rac_textSignal, self.passwordL.rac_textSignal] reduce:^id (NSString *name, NSString *password){
        @strongify(self);
        if (name.length == 0 && password.length == 0) {
            return @"\t使用ReactiveCocoa使用户名和密码的输入框内容和下面用于显示的文本、登录按钮绑定.\n\t当用户名和密码都大于等于6位的时候,按钮才能按.\n\t文本展示的内容是两个输入框的内容";
        }
        return [name stringByAppendingString:password];
    }];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end

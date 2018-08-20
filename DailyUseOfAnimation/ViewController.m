//
//  ViewController.m
//  DailyUseOfAnimation
//
//  Created by Jn_Kindle on 2018/8/19.
//  Copyright © 2018年 JnKindle. All rights reserved.
//

#define JnScreenWidth [UIScreen mainScreen].bounds.size.width
#define JnScreenHeight [UIScreen mainScreen].bounds.size.height

//角度转化为弧度
#define kToRadian(x) (x/180.0 * M_PI)

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UIView *redView;


@property (nonatomic, weak) UIButton *operationBtn;


@end

@implementation ViewController

-(UITextField *)textField
{
    if (!_textField) {
        UITextField *textField  = [[UITextField alloc] init];
        textField.frame = CGRectMake(100, 50, JnScreenWidth-200, 35);
        textField.placeholder = @"  请输入手机号码";
        
        textField.layer.borderColor = [UIColor blackColor].CGColor;
        textField.layer.borderWidth = 0.5;
        textField.layer.cornerRadius = 5;
        textField.layer.masksToBounds = YES;
        
        [self.view addSubview:textField];
        _textField = textField;
    }
    return _textField;
}

- (UIView *)redView
{
    if (!_redView)
    {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake((JnScreenWidth-50)/2, CGRectGetMaxY(self.textField.frame)+15, 50, 50)];
        v.backgroundColor = [UIColor redColor];
        v.layer.cornerRadius = 10;
        [self.view addSubview:v];
        
        _redView = v;
    }
    
    return _redView;
}

-(UIButton *)operationBtn
{
    if (!_operationBtn) {
        UIButton *opBtn = [[UIButton alloc] init];
        opBtn.frame = CGRectMake(100, JnScreenHeight-70, JnScreenWidth-200, 40);
        [opBtn setTitle:@"执行动画" forState:UIControlStateNormal];
        [opBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        opBtn.layer.borderColor = [UIColor blackColor].CGColor;
        opBtn.layer.borderWidth = 0.5;
        
        [opBtn addTarget:self action:@selector(opBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:opBtn];
        _operationBtn = opBtn;
    }
    return _operationBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self textField];
    [self redView];
    [self operationBtn];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

- (void)opBtnClick:(UIButton *)sender
{
    //[self addTextFieldInputErrorAnimation]; //输入框错误动画
    [self addDeleteJitterAnimation]; //删除抖动动画
}


/**
 输入框输入错误动画
 */
- (void)addTextFieldInputErrorAnimation
{
    CAKeyframeAnimation *keyAni = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    keyAni.values = @[@(5),@(0),@(-5),@(0),@(5)];
    keyAni.additive = YES; //additive 属性为 YES 能够对所有形式的需要更新的元素重用相同的动画，且无需提前知道它们的位置。
    keyAni.repeatCount = 1;
    keyAni.duration = 0.2;
    [self.textField.layer addAnimation:keyAni forKey:@"TextFieldAni"];
    
    //[self.textField.layer removeAllAnimations]; //移除所有动画
    //[self.textField.layer removeAnimationForKey:@"TextFieldAni"]; //根据指定key移除动画
}


/**
 添加删除抖动动画
 */
- (void)addDeleteJitterAnimation
{
    //视图抖动
    CAKeyframeAnimation *keyframeAni = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    keyframeAni.duration = 0.2;
    //关键部分角度
    keyframeAni.values = @[@(kToRadian(5)),@(kToRadian(0)),@(kToRadian(-5)),@(kToRadian(0)),@(kToRadian(5))];
    keyframeAni.repeatCount = MAXFLOAT;
    [self.redView.layer addAnimation:keyframeAni forKey:@"deleteJitterAnimation"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.redView.layer removeAnimationForKey:@"deleteJitterAnimation"]; //停止动画
    });
}


























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end

//
//  RootViewController.m
//  Demo
//
//  Created by Zontonec on 16/11/11.
//  Copyright © 2016年 Zontonec. All rights reserved.
//

#import "RootViewController.h"
#import "MoveInputViewWithKeyBoard.h"
//屏幕宽高
#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

#pragma mark - 使用步骤< 1 >：遵守TextField、TextView协议 -
@interface RootViewController ()<UITextFieldDelegate,UITextViewDelegate>

/** 当前编辑的控件 */
@property(nonatomic, strong) UIView *editingView;

/** 输入框TextField */
@property(nonatomic, strong) UITextView *otherTextView;

/** 输入框TextField */
@property(nonatomic, strong) UITextField *inputTextField;

/** 输入框TextView */
@property(nonatomic, strong) UITextView *inputTextView;

/** 盛放输入框的滚动视图 */
@property(nonatomic, strong) UIScrollView *tmpScrollView;

/** TextView键盘通知 */
@property(nonatomic, strong) NSNotification *notifi;

/** 保存的上次上移的高度 */
@property(nonatomic, assign) CGFloat lastHeigh;

#pragma mark - 使用步骤< 2 >：声明一个修改滚动视图位置的类的对象 -
@property(nonatomic, strong) MoveInputViewWithKeyBoard * moveInputView;

@end

@implementation RootViewController

-(void)buttonDidPress{
    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    
    CGRect rect=[self.inputTextView convertRect:self.inputTextView.bounds toView:window];
    
    NSLog(@"%.0f-%.0f-%.0f-%.0f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setFrame:CGRectMake(50, 100, 40, SCREENWIDTH - 100)];
    
    [button setBackgroundColor:[UIColor greenColor]];
    
    [button setTitle:@"点击输出控件基于屏幕的位置" forState:0];
    
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    
    [button addTarget:self action:@selector(buttonDidPress) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tmpScrollView addSubview:button];
#pragma mark - 使用步骤< 3 >：注册键盘通知 -
    [self.moveInputView AddObserverForKeyboard];
    
    [self.tmpScrollView addSubview:self.otherTextView];
    
    [self.tmpScrollView addSubview:self.inputTextView];
    
    [self.tmpScrollView addSubview:self.inputTextField];
}

#pragma mark - 使用步骤< 4 >：通过懒加载初始化对象 -
-(MoveInputViewWithKeyBoard *)moveInputView{
    
    if (!_moveInputView) {
        
        _moveInputView = [[MoveInputViewWithKeyBoard alloc]init];
    }
    return _moveInputView ;
}

#pragma mark - 使用步骤< 5 >：在键盘开始编辑的方法里面调用移动滚动视图的方法 -
///////////////////////////////////////////////////////////////////////////////////////
-(void)textFieldDidBeginEditing:(UITextField *)textField{
                                                                                     //
    [self.moveInputView MoveScrollView:self.tmpScrollView textField:textField];
}                                                                                    //
-(void)textViewDidBeginEditing:(UITextView *)textView{
                                                                                     //
    [self.moveInputView MoveScrollView:self.tmpScrollView textView:textView];
}
///////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 懒加载 -
-(UIScrollView *)tmpScrollView{
    
    if (!_tmpScrollView) {
        
        _tmpScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        
        [_tmpScrollView setBackgroundColor:[UIColor orangeColor]];
        
        [_tmpScrollView setContentSize:CGSizeMake(SCREENWIDTH, SCREENHEIGHT * 2)];
        
        [self.view addSubview:_tmpScrollView];
    }
    return _tmpScrollView ;
}
-(UITextView *)inputTextView{
    
    if (!_inputTextView) {
        
        _inputTextView = [[UITextView alloc]initWithFrame:CGRectMake(200, 500, 100, 100)];
        
        [_inputTextView setBackgroundColor:[UIColor lightGrayColor]];
        
        [_inputTextView setFont:[UIFont systemFontOfSize:17]];
        
        [_inputTextView setTextAlignment:0];
        
        [_inputTextView setDelegate:self];
        
        [_inputTextView.layer setMasksToBounds:YES];
        
        [_inputTextView.layer setCornerRadius:5];
    }
    return _inputTextView ;
}
-(UITextField *)inputTextField{
    
    if (!_inputTextField) {
        
        _inputTextField = [[UITextField alloc]initWithFrame:CGRectMake(50, 400, 100, 100)];
        
        [_inputTextField setBackgroundColor:[UIColor lightGrayColor]];
        
        [_inputTextField setFont:[UIFont systemFontOfSize:17]];
        
        [_inputTextField setTextAlignment:0];
        
        [_inputTextField setDelegate:self];
        
        [_inputTextField.layer setMasksToBounds:YES];
        
        [_inputTextField.layer setCornerRadius:5];
        
        [_inputTextField setPlaceholder:@"输入文字"];
    }
    return _inputTextField ;
}
-(UITextView *)otherTextView{
    
    if (!_otherTextView) {
        
        _otherTextView = [[UITextView alloc]initWithFrame:CGRectMake(200, 300, 100, 100)];
        
        [_otherTextView setBackgroundColor:[UIColor lightGrayColor]];
        
        [_otherTextView setFont:[UIFont systemFontOfSize:17]];
        
        [_otherTextView setTextAlignment:0];
        
        [_otherTextView setDelegate:self];
        
        [_otherTextView.layer setMasksToBounds:YES];
        
        [_otherTextView.layer setCornerRadius:5];
    }
    return _otherTextView;
}
#pragma mark - 点击滚动视图空白部分隐藏键盘 -
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
@end

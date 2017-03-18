//
//  MoveInputViewWithKeyBoard.m
//  Demo
//
//  Created by Zontonec on 17/3/7.
//  Copyright © 2017年 Zontonec. All rights reserved.
//

#import "MoveInputViewWithKeyBoard.h"

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

@interface MoveInputViewWithKeyBoard () <UITextFieldDelegate,UITextViewDelegate>


/** 当前编辑的控件 */
@property(nonatomic, strong) UIView *editingView;

/** 输入框TextField */
@property(nonatomic, strong) UITextField *inputTextField;

/** 输入框TextView */
@property(nonatomic, strong) UITextView *inputTextView;

/** 盛放输入框的滚动视图 */
@property(nonatomic, strong) UIScrollView *tmpScrollView;

/** TextView键盘通知 */
@property(nonatomic, strong) NSNotification *notifi;

/** 保存上次编辑的控件 */
@property(nonatomic, strong) UIView *lastView;

/** 是否执行了开始编辑的方法 */
@property(nonatomic, assign) NSInteger isEditing;

@end
/*  坑：
 UITextFiel编辑时弹出键盘的执行顺序是：先执行UITextFiel开始编辑的方法，再执行键盘弹出的方法；
 UITextView编辑时弹出键盘的执行顺序是：先执行弹出键盘的方法，再执行UITextView开始编辑的方法；
 */
@implementation MoveInputViewWithKeyBoard

-(void)MoveScrollView:(UIScrollView *)scrollView textField:(UIView *)inputView{
    
    self.tmpScrollView = scrollView ;
    
    self.editingView   = inputView  ;
    
    self.isEditing = 1 ;
    
    if (self.notifi) {
        
        [self keyboardWillHide:self.notifi];
    }
}
-(void)MoveScrollView:(UIScrollView *)scrollView textView:(UIView *)inputView{
    
    self.tmpScrollView = scrollView ;
    
    self.editingView   = inputView  ;
    
    self.isEditing = 1 ;
    
    if (self.notifi) {
        
        [self keyboardWillHide:self.notifi];
    }
    
    [self keyboardWillShow:self.notifi];
}
-(void)AddObserverForKeyboard{
    
    //监听当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //监听当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    if (self.isEditing == 1) {
        
        NSDictionary *userInfo = [(self.isEditing == 1 && [self.editingView isKindOfClass:[UITextView class]])? self.notifi : aNotification userInfo];
        
        //键盘弹出时间
        double duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        //获取键盘的高度
        CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        //计算控件基于屏幕的位置
        UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
        
        //（1）使用时需要修改这儿
        NSLog(@"当前编辑的控件---%@",self.editingView);
        CGRect rect=[self.editingView convertRect: self.editingView.bounds toView:window];
        
        //                屏幕高度     -     输入框最下方Y坐标     -    键盘高度
        CGFloat mark =(SCREENHEIGHT -CGRectGetMaxY(rect))-keyboardRect.size.height;
        
        if (mark<0) {
            
            [UIView animateWithDuration:duration animations:^{
                
                self.tmpScrollView.transform  =CGAffineTransformMakeTranslation(0, mark);
            }];
        }
    }
    self.notifi = aNotification ;
    
    self.isEditing = 0 ;
}
//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    NSDictionary *userInfo = [aNotification userInfo];
    
    double duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.tmpScrollView.transform  =CGAffineTransformIdentity;
    }];
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

//
//  MoveInputViewWithKeyBoard.h
//  Demo
//
//  Created by Zontonec on 17/3/7.
//  Copyright © 2017年 Zontonec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoveInputViewWithKeyBoard : NSObject

/** 注册键盘通知 */
-(void)AddObserverForKeyboard;

/** textView移动滚动视图 */
-(void)MoveScrollView:(UIScrollView *)scrollView textView:(UIView *)inputView;

/** textField移动滚动视图 */
-(void)MoveScrollView:(UIScrollView *)scrollView textField:(UIView *)inputView;

@end

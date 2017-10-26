//
//  STActionSheet.h
//  Broker-Swift
//
//  Created by 石函东 on 2017/8/31.
//  Copyright © 2017年 万圣. All rights reserved.
//

#import <UIKit/UIKit.h>
@class STActionSheet;
typedef void(^STClickBlock)(STActionSheet *sheet,NSInteger indexPath);
@interface STActionSheet : UIView

/**
 ActionSheet 展示,通过titlestring 来辨别有无headview

 @param titleSting headview的文字描述 可为nil
 @param titles 按键文字描述数组 不需要加入取消按钮
 @param imageArray 图片名字数组 可为nil
 @param colors 文字颜色数组 为为nil
 @param clickBlock 回调 从0开始
 @return <#return value description#>
 */
-(instancetype)initWithTitleString:(NSString *)titleSting WithTitles:(NSArray *)titles WithImageArray:(NSArray *)imageArray WithColors:(NSArray *)colors clickAction:(STClickBlock)clickBlock;

- (void)show;

- (void)hide;
@end

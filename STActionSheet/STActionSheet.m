//
//  STActionSheet.m
//  Broker-Swift
//
//  Created by 石函东 on 2017/8/31.
//  Copyright © 2017年 万圣. All rights reserved.
//

#import "STActionSheet.h"
#import "STActionSheetCell.h"
#define K_BackColor [UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.00]
#define K_Width  [UIScreen mainScreen].bounds.size.width
#define K_Height [UIScreen mainScreen].bounds.size.height
static NSString * const cellID = @"cellID";

@interface STActionSheet()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic , strong) UITableView *stActionsTableview;
@property (nonatomic , strong) UIButton *cancleBtn;
@property (nonatomic , strong) UIView *grayView;
@property (nonatomic , strong) NSArray *titles;
@property (nonatomic , strong) NSArray *images;
@property (nonatomic , strong) NSArray *colors;
@property (strong,nonatomic) NSString * titleString;
@property (nonatomic , copy  ) STClickBlock btnClick;

@end


@implementation STActionSheet
-(instancetype)initWithTitleString:(NSString *)titleSting WithTitles:(NSArray *)titles WithImageArray:(NSArray *)imageArray WithColors:(NSArray *)colors clickAction:(STClickBlock)clickBlock
{
    if (self = [super init]) {
        _btnClick = clickBlock;
        _titles = titles;
        _images = imageArray;
        _colors = colors;
        _titleString = titleSting;
        [self setupUI];
    }
    return self;

}
-(void)setupUI
{
    [self addSubview:self.stActionsTableview];
    [self addSubview:self.grayView];
    [self addSubview:self.cancleBtn];
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_titleString.length==0) {
        return 0.1;
    }
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_titleString.length) {
        UIView * head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_Width, 50)];
        head.backgroundColor = [UIColor whiteColor];
        UILabel * label = [[UILabel alloc] initWithFrame:head.frame];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0];
        label.text = _titleString;
        [head addSubview:label];
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, K_Width, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1/1.0];
        [head addSubview:line];
        return head;
    }
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    STActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"STActionSheetCell" owner:nil options:nil] lastObject];;
    }
    cell.titleLabel.text = _titles[indexPath.row];
    if (_images.count) {
        cell.iconImageView.image = [UIImage imageNamed:_images[indexPath.row]];
        cell.iconImageView.hidden = NO;
    }
    else
        cell.iconImageView.hidden = YES;
    
    if (_colors.count) {
        cell.titleLabel.textColor = _colors[indexPath.row];
    }
    else
        cell.titleLabel.textColor = [UIColor blackColor];
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置cell的上下行线的位置
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.btnClick) {
        self.btnClick(self , indexPath.row);
    }
    [self hide];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.frame = self.superview.bounds;
    NSInteger titleNum = _titles.count;
    if (_titleString.length) {
        self.stActionsTableview.frame = CGRectMake(0, K_Height - titleNum * 50 - 54-50, K_Width, titleNum * 50+50 );
    }
    else
        self.stActionsTableview.frame = CGRectMake(0, K_Height - titleNum * 50 - 54, K_Width, titleNum * 50 );
    
}

- (UITableView *)stActionsTableview
{
    if (!_stActionsTableview) {
        _stActionsTableview = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _stActionsTableview.delegate = self;
        _stActionsTableview.dataSource = self;
        _stActionsTableview.tableFooterView.backgroundColor = K_BackColor;
        _stActionsTableview.showsVerticalScrollIndicator = NO;
        _stActionsTableview.scrollEnabled = NO;
        _stActionsTableview.estimatedRowHeight = NO;
        _stActionsTableview.estimatedSectionFooterHeight = NO;
        _stActionsTableview.estimatedSectionHeaderHeight = NO;
        if ([_stActionsTableview respondsToSelector:@selector(setSeparatorInset:)]) {
            [_stActionsTableview setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_stActionsTableview respondsToSelector:@selector(setLayoutMargins:)]) {
            [_stActionsTableview setLayoutMargins:UIEdgeInsetsZero];
        }
//        [_stActionsTableview registerClass:[CWActionSheetTableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _stActionsTableview;
}



- (UIButton *)cancleBtn
{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectMake(0, K_Height-46, K_Width, 46);
        [_cancleBtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancleBtn setBackgroundColor:[UIColor whiteColor]];
    }
    return _cancleBtn;
}
- (UIView *)grayView
{
    if (!_grayView) {
        _grayView = [[UIView alloc]init];
        _grayView.backgroundColor = K_BackColor;
        _grayView.frame = CGRectMake(0, K_Height-54, K_Width, 8);
    }
    return _grayView;
}
- (void)cancleClick
{
    [self hide];
}

- (void)show
{
    //在主线程中弹出，不然会被遮挡，导致看不到视图。
    dispatch_async(dispatch_get_main_queue(), ^{
        self.alpha = 0.0f;
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [UIView animateWithDuration:0.35f
                              delay:0.0
             usingSpringWithDamping:0.9
              initialSpringVelocity:0.7
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.alpha = 1.0;
                             self.stActionsTableview.transform = CGAffineTransformMakeTranslation(0, -200);
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    });
}

- (void)hide
{
    [UIView animateWithDuration:0.35f
                          delay:0.0
         usingSpringWithDamping:0.9
          initialSpringVelocity:0.7
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = 0;
                         
                         NSInteger titleNum = _titles.count;
                         self.cancleBtn.frame = CGRectMake(0, K_Height+54, K_Width, 46);
                         self.grayView.frame = CGRectMake(0, K_Height+46, K_Width, 8);
                         if (_titleString.length) {
                             self.stActionsTableview.frame = CGRectMake(0, K_Height, K_Width, titleNum * 50+50);
                         }
                         else
                             self.stActionsTableview.frame = CGRectMake(0, K_Height, K_Width, titleNum * 50);
                         
                         
                     } completion:^(BOOL finished) {
                         self.alpha = 1.0f;
                         [self removeFromSuperview];
                     }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    //获取点击的点，判断是否在tableview上
    CGPoint point = [touch locationInView:self];
    if (!CGRectContainsPoint(self.stActionsTableview.frame, point))
    {
        //        if (self.btnClick)
        //        {
        //            self.btnClick(self,[NSIndexPath indexPathForRow:99 inSection:0]);
        //        }
        [self hide];
    }
}





@end

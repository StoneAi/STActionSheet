//
//  ViewController.m
//  STActionsheetDemo
//
//  Created by 石函东 on 2017/10/26.
//  Copyright © 2017年 石函东. All rights reserved.
//

#import "ViewController.h"
#import "STActionSheet.h"
@interface ViewController ()
- (IBAction)DisplayActionSheet:(id)sender;
- (IBAction)AnotherActionSheet:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)DisplayActionSheet:(id)sender {
    STActionSheet * action = [[STActionSheet alloc] initWithTitleString:@"展示头部文字描述" WithTitles:@[@"你好",@"我好"] WithImageArray:nil WithColors:nil clickAction:^(STActionSheet *sheet, NSInteger indexPath) {
        switch (indexPath) {
            case 0:
                NSLog(@"你好,我不好");
                break;
            case 1:
                NSLog(@"我好,你不好");
                break;
            default:
                break;
        }
    }];
    [action show];
    
}

- (IBAction)AnotherActionSheet:(id)sender {
    STActionSheet * action = [[STActionSheet alloc] initWithTitleString:nil WithTitles:@[@"你好",@"我好"] WithImageArray:nil WithColors:nil clickAction:^(STActionSheet *sheet, NSInteger indexPath) {
        switch (indexPath) {
            case 0:
                NSLog(@"你好,我不好");
                break;
            case 1:
                NSLog(@"我好,你不好");
                break;
            default:
                break;
        }
    }];
    [action show];
}
@end

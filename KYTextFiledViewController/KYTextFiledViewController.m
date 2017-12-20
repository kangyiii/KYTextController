//
//  KYTextFiledViewController.m
//  KYTextFiledViewController
//
//  Created by 康义 on 2017/12/20.
//  Copyright © 2017年 康义. All rights reserved.
//

#import "KYTextFiledViewController.h"
#import "KYTextField.h"
#import "PickerView.h"

@interface KYTextFiledViewController ()

@end

@implementation KYTextFiledViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //标题数组
    self.titleArr = @[@[@"1.1",@"1.2",@"1.3",@"1.4"],@[@"2.3",@"2.4"],@[@"3.1"]];
    //状态数组 @""为输入 @"请选择"为选择
    self.stateArr = @[@[@"",@"",@"",@"请选择"],@[@"",@"请选择"],@[@""]];
    self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:self.tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    //为选择的cell这里自定义选择内容
    if(indexPath.section == 0 && indexPath.row == 3){
        [PickerView showPickerWithOptions:@[@"1",@"2",@"3"] selectionBlock:^(NSString *selectedOption) {
            self.dataArr[indexPath.section][indexPath.row] = selectedOption;
            [self.tableView reloadData];
        }];
    }else if(indexPath.section == 1 && indexPath.row == 1){
        [PickerView showPickerWithOptions:@[@"33",@"22",@"11"] selectionBlock:^(NSString *selectedOption) {
            self.dataArr[indexPath.section][indexPath.row] = selectedOption;
            [self.tableView reloadData];
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if([textField isKindOfClass:[KYTextField class]]){
        KYTextField * tf = (KYTextField *)textField;
        self.dataArr[tf.section][tf.row] = tf.text;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end

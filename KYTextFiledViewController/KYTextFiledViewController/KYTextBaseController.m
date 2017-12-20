//
//  KYTextBaseController.m
//  KYTextFiledViewController
//
//  Created by 康义 on 2017/12/20.
//  Copyright © 2017年 康义. All rights reserved.
//

#import "KYTextBaseController.h"
#import "TextCell.h"
#import "KYTextField.h"

@interface KYTextBaseController ()<TextCellDelegate>

@end

@implementation KYTextBaseController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
        for(NSArray * temp in self.titleArr){
            NSMutableArray * arr = [NSMutableArray array];
            for(NSString * str in temp){
                [arr addObject:@""];
            }
            [_dataArr addObject:arr];
        }
    }
    return _dataArr;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerNib:[UINib nibWithNibName:@"TextCell" bundle:nil] forCellReuseIdentifier:@"textcell"];
    }
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * row = self.titleArr[section];
    return row.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TextCell * cell = [tableView dequeueReusableCellWithIdentifier:@"textcell"];
    cell.selectionStyle = 0;
    cell.delegate = self;
    //设置title
    NSArray * row = self.titleArr[indexPath.section];
    NSString * titleStr = row[indexPath.row];
    cell.titleLable.text = titleStr;
    NSArray * stateRow = self.stateArr[indexPath.section];
    NSString * stateStr = stateRow[indexPath.row];
    cell.textFied.delegate = self;
    cell.textFied.section = indexPath.section;
    cell.textFied.row = indexPath.row;
    if([stateStr isEqualToString:@""]){
        NSString * dataArrStr = self.dataArr[indexPath.section][indexPath.row];
        if(dataArrStr.length>0){
            cell.textFied.text = dataArrStr;
        }else{
            cell.textFied.placeholder = [NSString stringWithFormat:@"请输入%@",titleStr];
        }
        cell.textFied.userInteractionEnabled = YES;
    }else{
        NSString * dataArrStr = self.dataArr[indexPath.section][indexPath.row];
        if(dataArrStr.length>0){
            cell.textFied.text = dataArrStr;
        }else{
            cell.textFied.placeholder = @"请选择";
        }
        cell.textFied.userInteractionEnabled = NO;
    }
    return cell;
}

@end

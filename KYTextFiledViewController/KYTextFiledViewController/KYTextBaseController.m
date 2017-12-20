//
//  KYTextBaseController.m
//  KYTextFiledViewController
//
//  Created by 康义 on 2017/12/20.
//  Copyright © 2017年 康义. All rights reserved.
//

#import "KYTextBaseController.h"

@interface KYTextBaseController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation KYTextBaseController

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

@end

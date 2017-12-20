//
//  KYTextBaseController.h
//  KYTextFiledViewController
//
//  Created by 康义 on 2017/12/20.
//  Copyright © 2017年 康义. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface KYTextBaseController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong)UITableView * tableView;

/**标题数组*/
@property (nonatomic,strong)NSArray * titleArr;
/**数据源*/
@property (nonatomic,strong)NSMutableArray * dataArr;
/**状态数组 输入=@"" 选择=@"请选择"*/
@property (nonatomic,copy)NSArray * stateArr;

@end

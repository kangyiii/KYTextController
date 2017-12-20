# KYTextController
### 通过标题数组和输入的数据类型来自动创建tableView,目前支持文字输入和自定义picker,最终输入的数据会存储在self.dataArr中

#### 使用说明
1. 继承KYTextBaseController
2. 添加标题数组和类型数组
```
//标题数组
self.titleArr = @[@[@"1.1",@"1.2",@"1.3",@"1.4"],@[@"2.3",@"2.4"],@[@"3.1"]];
//状态数组 @""为输入 @"请选择"为选择
self.stateArr = @[@[@"",@"",@"",@"请选择"],@[@"",@"请选择"],@[@""]];

//在didSelectRowAtIndexPath创建自定义picker
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
```

3. 最终输入的所有数据会按照顺序存储在self.dataArr
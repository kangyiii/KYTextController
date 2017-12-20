//
//  TextCell.h
//  KYTextFiledViewController
//
//  Created by 康义 on 2017/12/20.
//  Copyright © 2017年 康义. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KYTextField.h"

@protocol TextCellDelegate <NSObject>

@end

@interface TextCell : UITableViewCell

@property (weak, nonatomic)id<TextCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet KYTextField *textFied;


@end

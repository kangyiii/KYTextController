//
//  PickerView.m
//  <>
//
//  Created by Naveen Shan.
//  Copyright © 2015. All rights reserved.
//

#import "PickerView.h"

#pragma mark - Picker Controller

@interface PickerAlertController : UIAlertController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSString *pickerTitle;
@property (nonatomic, strong) UIBarButtonItem *titleButton;

@property (nonatomic, strong) NSArray *options;
@property (nonatomic, strong) NSString *selectedOption;
@property (nonatomic, copy) void (^pickerDoneBlock)(NSString *selectedOption);

@end

@implementation PickerAlertController

- (instancetype)init    {
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-40, 40)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 5, 50, 30);
    [btn addTarget:self action:@selector(pickerCancel:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 5, 50, 30);
    [btn2 addTarget:self action:@selector(pickerDone:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"确定" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:14.f];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithCustomView:btn2];
    
    self.titleButton = [[UIBarButtonItem alloc] initWithTitle:self.pickerTitle style:UIBarButtonItemStylePlain target:nil action:nil];
    self.titleButton.tintColor = [UIColor blackColor];
    
    NSArray * buttonsArray = [NSArray arrayWithObjects:cancelBtn,btnSpace,self.titleButton,btnSpace,doneBtn,nil];
    [topView setItems:buttonsArray];
    [self.view addSubview:topView];
    
    [self createPickerView];
}

- (void)createPickerView {
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width-20, 180)];
    self.pickerView.clipsToBounds = YES;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    self.pickerView.showsSelectionIndicator = YES;
    [self.view addSubview:self.pickerView];
}

- (void)setOptions:(NSArray *)options {
    _options = options;
    
    if ([options count] > 0) {
        self.selectedOption = self.options.firstObject;
    }
}

- (void)setPickerTitle:(NSString *)pickerTitle {
    _pickerTitle = pickerTitle;
    
    self.titleButton.title = pickerTitle;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

#pragma mark - UIPickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.options.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component   {
    return self.options[row];
}

#pragma mark - UIPickerView Delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component  {
    self.selectedOption = self.options[row];
}

#pragma mark -

- (void)pickerDone:(id)sender {
    if (self.pickerDoneBlock) {
        self.pickerDoneBlock(self.selectedOption);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pickerCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

#pragma mark - DatePicker Controller

@interface DatePickerController : PickerAlertController

@property (nonatomic, strong) UIDatePicker *datePickerView;
@property (nonatomic, copy) void (^datePickerDoneBlock)(NSDate *selectedDate);

@end

@implementation DatePickerController

- (void)createPickerView {
    self.datePickerView = [[UIDatePicker alloc] init];
    self.datePickerView.clipsToBounds = YES;
    [self.view addSubview:self.datePickerView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat screenWidth = self.view.frame.size.width;
    self.datePickerView.frame = CGRectMake(0, 40, screenWidth, 180);
}

#pragma mark -

- (void)pickerDone:(id)sender {
    if (self.datePickerDoneBlock) {
        self.datePickerDoneBlock(self.datePickerView.date);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

#pragma mark - Picker View

@implementation PickerView

+ (UIViewController *)presentationContorller    {
    UIViewController *presentationContorller = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (presentationContorller == nil) {
        presentationContorller = [[[UIApplication sharedApplication] windows] firstObject].rootViewController;
    }
    
    if (![presentationContorller isMemberOfClass:[UIViewController class]]) {
        if ([presentationContorller isKindOfClass:[UITabBarController class]]) {
            presentationContorller = ((UITabBarController *)presentationContorller).selectedViewController;
        } else if ([presentationContorller isKindOfClass:[UINavigationController class]]) {
            presentationContorller = ((UINavigationController *)presentationContorller).topViewController;
        }
        else {
            presentationContorller = presentationContorller.presentedViewController;
        }
    }
    
    return presentationContorller;
}

#pragma mark -

+ (void)showPickerWithOptions:(NSArray *)options selectionBlock:(void (^)(NSString *selectedOption))block  {
    [[self class] showPickerWithOptions:options title:nil selectionBlock:block];
}

+ (void)showPickerWithOptions:(NSArray *)options title:(NSString *)title selectionBlock:(void (^)(NSString *selectedOption))block  {
    PickerAlertController *alertController = [PickerAlertController alertControllerWithTitle:title message:@"\n\n\n\n\n\n\n\n\n\n\n"preferredStyle:UIAlertControllerStyleActionSheet];
    alertController.options = options;
    alertController.pickerTitle = title;
    [alertController setPickerDoneBlock:block];
    
    [[[self class] presentationContorller] presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -

+ (void)showDatePickerWithTitle:(NSString *)title dateMode:(UIDatePickerMode)mode selectionBlock:(void (^)(NSDate *selectedDate))block  {
    DatePickerController *alertController = [DatePickerController alertControllerWithTitle:title message:@"\n\n\n\n\n\n\n\n\n\n\n"preferredStyle:UIAlertControllerStyleActionSheet];
    alertController.pickerTitle = title;
    alertController.datePickerView.datePickerMode = mode;
    [alertController setDatePickerDoneBlock:block];
    
    [[[self class] presentationContorller] presentViewController:alertController animated:YES completion:nil];
}


@end

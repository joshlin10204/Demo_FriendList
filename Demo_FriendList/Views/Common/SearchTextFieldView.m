//
//  SearchTextFieldView.m
//  Demo_FriendList
//
//  Created by Josh on 2025/2/13.
//

#import "SearchTextFieldView.h"
@interface SearchTextFieldView ()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *searchImage;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIButton *addButton;

@end

@implementation SearchTextFieldView

- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"%s",__func__);
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        [self initSearchImage];
        [self initSearchTextField];
        [self initAddButton];
    }
    return self;
}


- (void)initSearchImage{
    CGFloat height = 14;
    CGFloat width = 14;
    CGFloat x = 10;
    CGFloat y = self.frame.size.height*0.5 - height*0.5;
    self.searchImage =  [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    self.searchImage.image  = [UIImage imageNamed:@"icSearchBarSearchGray"];
    [self addSubview:self.searchImage];
}

- (void)initAddButton{
    
    CGFloat width = 24;
    CGFloat height = 24;
    CGFloat x = self.frame.size.width - width - 10 ;
    CGFloat y = self.frame.size.height*0.5 - height*0.5;
    self.addButton = [[UIButton alloc]initWithFrame:CGRectMake(x,y ,width,height)];
    [self.addButton setImage:[UIImage imageNamed:@"icBtnAddFriends"] forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(onClikcAddButton) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:self.addButton];
}



- (void)initSearchTextField{
    
    CGFloat width = self.frame.size.width*0.8;
    CGFloat height = self.frame.size.height;
    CGFloat x = 32;
    CGFloat y = self.frame.size.height*0.5 - height*0.5;
    
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(x,y,width,height)];
    self.searchTextField.placeholder = @"想轉一筆給誰呢?" ;
    self.searchTextField.minimumFontSize = 14;
    self.searchTextField.textColor = [UIColor colorWithRed:(142/255.0) green:(142/255.0) blue:(147/255.0) alpha:1];
    self.searchTextField.keyboardType = UIKeyboardTypeDefault;
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    self.searchTextField.delegate = self;
    [self.searchTextField addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];

     [self addSubview:self.searchTextField];
}


- (void)onClikcAddButton{
    
    NSLog(@"AddButton");
}


- (void) textFieldDidBeginEditing:(UITextField*)textField {
    [self.delegate textFieldDidBeginEditing:textField];

}
 
// 可能進入結束編輯狀態
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return true;
}
 
// 結束編輯狀態(意指完成輸入或離開焦點)
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.delegate textFieldDidEndEditing:textField];

}
 
// 按下Return後會反應的事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //利用此方式讓按下Return後會Toogle 鍵盤讓它消失
    [textField resignFirstResponder];
    [self.delegate didSearchText:self.searchTextField.text];
    return false;
}

// 編輯中
- (void)textFieldDidChange:(UITextField *)textField {
    NSLog(@"輸入中：%@",textField.text);
    [self.delegate didSearchText:self.searchTextField.text];

}
 
@end

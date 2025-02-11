//
//  CustomSegmentedView.m
//  Demo_FriendList
//
//  Created by Josh on 2025/2/11.
//

#import "CustomSegmentedView.h"

#define underlineX self.frame.size.width *0.25
#define underlineX2 self.frame.size.width *0.75

@interface CustomSegmentedView ()
@property (nonatomic, strong) UIButton *friendBtn;
@property (nonatomic, strong) UIButton *chatBtn;

@property (nonatomic, strong) UIView *underlineView;





@end

@implementation CustomSegmentedView

- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"%s",__func__);
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSelectItems];
        [self initUnderlineView];

    }
    return self;
}
-(void) initSelectItems {
    
    CGFloat btnWidth = self.frame.size.width*0.5;
    CGFloat btnHeight = self.frame.size.height;
    self.friendBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0 ,btnWidth,btnHeight)];
    [self.friendBtn setTitle:@"好友" forState:UIControlStateNormal];
    [self.friendBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [self.friendBtn setTitleColor:[UIColor colorWithRed:(71/255.0) green:(71/255.0) blue:(71/255.0) alpha:1] forState:UIControlStateNormal];
    [self.friendBtn addTarget:self action:@selector(onClickFriendButton) forControlEvents:UIControlEventTouchUpInside];

    self.chatBtn = [[UIButton alloc]initWithFrame:CGRectMake(btnWidth,0 ,btnWidth,btnHeight)];
    [self.chatBtn setTitle:@"聊天" forState:UIControlStateNormal];
    [self.chatBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.chatBtn setTitleColor:[UIColor colorWithRed:(71/255.0) green:(71/255.0) blue:(71/255.0) alpha:1] forState:UIControlStateNormal];
    [self.chatBtn addTarget:self action:@selector(onClickChatButton) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:self.friendBtn];
    [self addSubview:self.chatBtn];
}

- (void) initUnderlineView{
    CGFloat width = self.frame.size.width*0.15;
    CGFloat height = self.frame.size.height*0.1;
    CGFloat x = underlineX - width*0.5;
    CGFloat y = self.frame.size.height - height;

    self.underlineView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    self.underlineView.backgroundColor =  [UIColor colorWithRed:(236/255.0) green:(0/255.0) blue:(140/255.0) alpha:1];
    self.underlineView .layer.cornerRadius = height*0.5;
    [self addSubview:self.underlineView];
}

- (void)onClickFriendButton{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.underlineView.frame;
        rect.origin.x = underlineX - rect.size.width*0.5;
        self.underlineView.frame = rect;
        [self.chatBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self.friendBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];

        
    }];
    
    [self.delegate didSelectSegmentAtIndex:0];

}

- (void)onClickChatButton{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.underlineView.frame;
        rect.origin.x = underlineX2 - rect.size.width*0.5;
        self.underlineView.frame = rect;
        [self.chatBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [self.friendBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];

        
    }];
    [self.delegate didSelectSegmentAtIndex:1];
    
}



@end

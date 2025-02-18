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
@property (nonatomic, strong) UIButton *friendButton;
@property (nonatomic, strong) UIButton *chatButton;
@property (nonatomic, strong) UILabel *friendBadgeLabel;
@property (nonatomic, strong) UILabel *chatBadgeLabel;

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
        [self initFriendBadgeView];
        [self initChatBadgeView];

    }
    return self;
}
#pragma mark - Init

-(void) initSelectItems {
    
    CGFloat btnWidth = self.frame.size.width*0.5;
    CGFloat btnHeight = self.frame.size.height;
    self.friendButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0 ,btnWidth,btnHeight)];
    [self.friendButton setTitle:@"好友" forState:UIControlStateNormal];
    [self.friendButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [self.friendButton setTitleColor:[UIColor colorWithRed:(71/255.0) green:(71/255.0) blue:(71/255.0) alpha:1] forState:UIControlStateNormal];
    [self.friendButton addTarget:self action:@selector(onClickFriendButton) forControlEvents:UIControlEventTouchUpInside];

    self.chatButton = [[UIButton alloc]initWithFrame:CGRectMake(btnWidth,0 ,btnWidth,btnHeight)];
    [self.chatButton setTitle:@"聊天" forState:UIControlStateNormal];
    [self.chatButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.chatButton setTitleColor:[UIColor colorWithRed:(71/255.0) green:(71/255.0) blue:(71/255.0) alpha:1] forState:UIControlStateNormal];
    [self.chatButton addTarget:self action:@selector(onClickChatButton) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:self.friendButton];
    [self addSubview:self.chatButton];
}

- (void) initUnderlineView{
    CGFloat width = self.frame.size.width*0.2;
    CGFloat height = self.frame.size.height*0.1;
    CGFloat x = underlineX - width*0.5;
    CGFloat y = self.frame.size.height - height;

    self.underlineView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    self.underlineView.backgroundColor =  [UIColor colorWithRed:(236/255.0) green:(0/255.0) blue:(140/255.0) alpha:1];
    self.underlineView .layer.cornerRadius = height*0.5;
    [self addSubview:self.underlineView];
}

- (void) initFriendBadgeView{
    
    self.friendBadgeLabel = [[UILabel alloc] init];
    self.friendBadgeLabel.hidden = YES;
    self.friendBadgeLabel.text = @"";
    self.friendBadgeLabel.font = [UIFont boldSystemFontOfSize:12];
    self.friendBadgeLabel.textColor = [UIColor whiteColor];
    self.friendBadgeLabel.textAlignment = NSTextAlignmentCenter;
    self.friendBadgeLabel.backgroundColor = [UIColor colorWithRed:1.0 green:0.7 blue:0.85 alpha:1.0]; // 粉色
    self.friendBadgeLabel.layer.cornerRadius = 10;
    self.friendBadgeLabel.layer.masksToBounds = YES;

     // 設定適合的寬度
    CGSize textSize = [self.friendBadgeLabel.text sizeWithAttributes:@{NSFontAttributeName: self.friendBadgeLabel.font}];
    CGFloat width = MAX(textSize.width + 10, 20); // 確保有足夠的間距
    
    CGSize buttonSize = [self.friendButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.friendButton.titleLabel.font}];
    CGFloat x = (self.friendButton.frame.size.width - buttonSize.width)/2 + buttonSize.width;
    self.friendBadgeLabel.frame = CGRectMake(x, 0, width, 20);
     
    
    [self addSubview:self.friendBadgeLabel];
}

- (void) initChatBadgeView{
    
    self.chatBadgeLabel = [[UILabel alloc] init];
    self.chatBadgeLabel.hidden = YES;
    self.chatBadgeLabel.text = @"";
    self.chatBadgeLabel.font = [UIFont boldSystemFontOfSize:12];
    self.chatBadgeLabel.textColor = [UIColor whiteColor];
    self.chatBadgeLabel.textAlignment = NSTextAlignmentCenter;
    self.chatBadgeLabel.backgroundColor = [UIColor colorWithRed:1.0 green:0.7 blue:0.85 alpha:1.0]; // 粉色
    self.chatBadgeLabel.layer.cornerRadius = 10;
    self.chatBadgeLabel.layer.masksToBounds = YES;

     // 設定適合的寬度
    CGSize textSize = [self.chatBadgeLabel.text sizeWithAttributes:@{NSFontAttributeName: self.chatBadgeLabel.font}];
    CGFloat width = MAX(textSize.width + 10, 20); // 確保有足夠的間距
    
    CGSize buttonSize = [self.chatButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.chatButton.titleLabel.font}];
    CGFloat x = (self.chatButton.frame.size.width - buttonSize.width)/2 + buttonSize.width +self.chatButton.frame.origin.x;
    self.chatBadgeLabel.frame = CGRectMake(x, 0, width, 20);
     
    
    [self addSubview:self.chatBadgeLabel];
}
#pragma mark - On Click


- (void)onClickFriendButton{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.underlineView.frame;
        rect.origin.x = underlineX - rect.size.width*0.5;
        self.underlineView.frame = rect;
        [self.chatButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self.friendButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];

    }];
    
    [self.delegate didSelectSegmentAtIndex:0];

}

- (void)onClickChatButton{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.underlineView.frame;
        rect.origin.x = underlineX2 - rect.size.width*0.5;
        self.underlineView.frame = rect;
        [self.chatButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [self.friendButton.titleLabel setFont:[UIFont systemFontOfSize:16]];

        
    }];
    [self.delegate didSelectSegmentAtIndex:1];
    
}


- (void)updatFriendBadge:(NSInteger)friendBadgeCount withChatBadge:(NSInteger)chatBadgeCount{
    
    if(friendBadgeCount>0){
        self.friendBadgeLabel.hidden =NO;
        
        NSString *countString = (friendBadgeCount > 99) ? @"99+" : [NSString stringWithFormat:@"%ld", (long)friendBadgeCount];
        self.friendBadgeLabel.text = countString;
        
        CGSize textSize = [self.friendBadgeLabel.text sizeWithAttributes:@{NSFontAttributeName: self.friendBadgeLabel.font}];
        CGFloat width = MAX(textSize.width + 10, 20); // 確保有足夠的間距

        self.friendBadgeLabel.frame = CGRectMake(self.friendBadgeLabel.frame.origin.x,
                                                 self.friendBadgeLabel.frame.origin.y,
                                                 width,
                                                 self.friendBadgeLabel.frame.size.height);
    }
    
    if(chatBadgeCount>0){
        self.chatBadgeLabel.hidden =NO;
        NSString *countString = (chatBadgeCount > 99) ? @"99+" : [NSString stringWithFormat:@"%ld", (long)chatBadgeCount];
        self.chatBadgeLabel.text = countString;
        
        CGSize textSize = [self.chatBadgeLabel.text sizeWithAttributes:@{NSFontAttributeName: self.chatBadgeLabel.font}];
        CGFloat width = MAX(textSize.width + 10, 20); // 確保有足夠的間距

        self.chatBadgeLabel.frame = CGRectMake(self.chatBadgeLabel.frame.origin.x,
                                                 self.chatBadgeLabel.frame.origin.y,
                                                 width,
                                               self.chatBadgeLabel.frame.size.height);
    }
    
}

@end

//
//  FriendListEmptyView.m
//  Demo_FriendList
//
//  Created by Josh on 2025/2/14.
//

#import "FriendListEmptyView.h"
@interface FriendListEmptyView ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *basicView;

@property (nonatomic, strong) UIImageView *emptyImage;
@property (nonatomic, strong) UILabel *emptyTitleLabel;
@property (nonatomic, strong) UILabel *emptySubTitleLabel;
@property (nonatomic, strong) UIView *addFriendButton;
@property (nonatomic, strong) UILabel *searchHintLabel;
@end
@implementation FriendListEmptyView

- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"%s",__func__);
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initBasicView];
        [self initEmptyImage];
        [self initEmptyTitleLabel];
        [self initEmptySubTitleLabel];
        [self initAddFriendButton];
        [self initSearchHintLabel];
    }
    return self;
}

- (void)initBasicView{
    CGFloat width = self.bounds.size.width*0.7;
    CGFloat height = 410;
    CGFloat x = self.bounds.size.width*0.5 - width*0.5;
    CGFloat y = self.bounds.size.height*0.4 - height*0.5;
    self.basicView = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [self addSubview:self.basicView];
    
}
- (void)initEmptyImage{
    CGFloat width = 245;
    CGFloat height = 172;
    CGFloat x = self.basicView.frame.size.width*0.5 - width*0.5;
    CGFloat y = 30;

    self.emptyImage =  [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    self.emptyImage.image  = [UIImage imageNamed:@"imgFriendsEmpty"];
    
    [self.basicView addSubview:self.emptyImage];

}

- (void)initEmptyTitleLabel{
    CGFloat width = 287;
    CGFloat height = 29;
    CGFloat x = self.basicView.frame.size.width*0.5 - width*0.5;
    CGFloat y = 243;
    self.emptyTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
    self.emptyTitleLabel.text = @"就從加好友開始吧：）";
    self.emptyTitleLabel.font = [UIFont boldSystemFontOfSize:21];
    self.emptyTitleLabel.textColor = [UIColor colorWithRed:(71/255.0) green:(71/255.0) blue:(71/255.0) alpha:1];
    self.emptyTitleLabel.textAlignment = NSTextAlignmentCenter;

    [self.basicView addSubview:self.emptyTitleLabel];

}
- (void)initEmptySubTitleLabel{
    CGFloat width = 287;
    CGFloat height = 40;
    CGFloat x = self.basicView.frame.size.width*0.5 - width*0.5;
    CGFloat y = 280;
    self.emptySubTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
    self.emptySubTitleLabel.text = @"與好友們一起用 KOKO 聊起來！\n還能互相收付款、發紅包喔：）";
    self.emptySubTitleLabel.font = [UIFont systemFontOfSize:14];
    self.emptySubTitleLabel.textColor = [UIColor colorWithRed:(153/255.0) green:(153/255.0) blue:(153/255.0) alpha:1];
    self.emptySubTitleLabel.numberOfLines = 0;
    self.emptySubTitleLabel.textAlignment = NSTextAlignmentCenter;

    [self.basicView addSubview:self.emptySubTitleLabel];

}
- (void)initAddFriendButton{
    CGFloat width = 192;
    CGFloat height = 40;
    CGFloat x = self.basicView.frame.size.width*0.5 - width*0.5;
    CGFloat y = 345;
    self.addFriendButton = [[UIView alloc]initWithFrame:CGRectMake(x,y ,width,height)];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, width, height);
    gradientLayer.colors =@[(__bridge id)[UIColor colorWithRed:86/255.0 green:179/255.0 blue:11/255.0 alpha:1.0].CGColor,
                           (__bridge id)[UIColor colorWithRed:166/255.0 green:204/255.0 blue:66/255.0 alpha:1.0].CGColor,];
     gradientLayer.startPoint = CGPointMake(0, 0.5); // 左側開始
     gradientLayer.endPoint = CGPointMake(1, 0.5);   // 右側結束
     gradientLayer.cornerRadius = height * 0.5;
    [self.addFriendButton.layer insertSublayer:gradientLayer atIndex:0];
    

    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    titleLabel.text = @"加好友";
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;

    
    UIImageView *iconImage =  [[UIImageView alloc]initWithFrame:CGRectMake(width - 32, height*0.5-12, 24, 24)];
    iconImage.image  = [UIImage imageNamed:@"icAddFriendWhite"];
    

    UITapGestureRecognizer *singleFingerTap =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(onClickAddFriendButton)];
    [self.addFriendButton addGestureRecognizer:singleFingerTap];
    
    
    [self.basicView addSubview:self.addFriendButton];
    [self.addFriendButton addSubview: titleLabel];
    [self.addFriendButton addSubview: iconImage];

}
- (void)initSearchHintLabel{
    
    CGFloat width = 289;
    CGFloat height = 18;
    CGFloat x = self.basicView.frame.size.width*0.5 - width*0.5;
    CGFloat y = 422;

    self.searchHintLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    self.searchHintLabel.userInteractionEnabled = YES;  // 允許點擊
    self.searchHintLabel.textAlignment = NSTextAlignmentCenter;
    self.searchHintLabel.font = [UIFont boldSystemFontOfSize:13];


    NSString *fullText = @"幫助好友更快找到你？ 設定 KOKO ID";
    NSString *clickableText = @"設定 KOKO ID";
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:fullText];

    [attributedText addAttribute:NSForegroundColorAttributeName value: [UIColor colorWithRed:(153/255.0) green:(153/255.0) blue:(153/255.0) alpha:1] range:NSMakeRange(0, fullText.length)];

    NSRange range = [fullText rangeOfString:clickableText];
    [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:236/255.0 green:0/255.0 blue:140/255.0 alpha:1.0] range:range];
    [attributedText addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range]; // 底線

    self.searchHintLabel.attributedText = attributedText;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickSetingKoKoIdButton)];
    [ self.searchHintLabel addGestureRecognizer:tapGesture];
    
    [self.basicView addSubview: self.searchHintLabel];


}


- (void)onClickAddFriendButton{
    NSLog(@"onClickAddFriendButton");
}

- (void)onClickSetingKoKoIdButton{
    NSLog(@"onClickSetingKoKoIdButton");
}
@end

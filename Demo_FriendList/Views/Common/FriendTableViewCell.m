//
//  FriendTableViewCell.m
//  Demo_FriendList
//
//  Created by Josh on 2025/2/12.
//

#import "FriendTableViewCell.h"

@interface FriendTableViewCell ()
@property (nonatomic, strong) UIImageView *starImageView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *transferButton;
@property (nonatomic, strong) UIButton *moreButton;


@end

@implementation FriendTableViewCell


// 設定 Cell 資料
- (void)configureWithFriendModel:(FriendModel *)model  {
    self.nameLabel.text = model.name;
    
    bool isTop = model.isTop;
    if(isTop){
        [self.starImageView setHidden:NO];
    }else{
        [self.starImageView setHidden:YES];

    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self initStarImage];
    [self initAvatarImage];
    [self initNameLabel];
    [self initTransferButton];
    [self initMoreButton];


}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.transferButton.frame = CGRectMake(frame.size.width - self.transferButton.frame.size.width- self.moreButton.frame.size.width -10,
                                           FriendTableViewCellHeight * 0.5 - self.transferButton.frame.size.height * 0.5,
                                           self.transferButton.frame.size.width,
                                           self.transferButton.frame.size.height);
    self.moreButton.frame = CGRectMake(frame.size.width - self.moreButton.frame.size.width,
                                          FriendTableViewCellHeight * 0.5 - self.moreButton.frame.size.height * 0.5,
                                          self.moreButton.frame.size.width,
                                          self.moreButton.frame.size.height);

}
- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void) initStarImage{
    
    CGFloat height = 14;
    CGFloat width = 14;
    CGFloat x = 10;
    CGFloat y = FriendTableViewCellHeight*0.5 - height*0.5;
    self.starImageView =  [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    self.starImageView.image  = [UIImage imageNamed:@"icFriendsStar"];
    [self.starImageView setHidden:YES];
    [self addSubview:self.starImageView];
}
- (void) initAvatarImage{
    CGFloat height = 40;
    CGFloat width = 40;
    CGFloat x = 30;
    CGFloat y = FriendTableViewCellHeight*0.5 - height*0.5;
    self.avatarImageView =  [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    self.avatarImageView.image  = [UIImage imageNamed:@"imgFriendsFemaleDefault"];
//    self.avatarImageView.layer.cornerRadius = 20;
//    self.avatarImageView.clipsToBounds = YES;

    [self addSubview:self.avatarImageView];
}
- (void) initNameLabel{

    CGFloat width = self.frame.size.width*0.3;
    CGFloat height = 22;
    CGFloat x = 85;
    CGFloat y = FriendTableViewCellHeight*0.5 - height*0.5;
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
    self.nameLabel.text = @"";
    self.nameLabel.font = [UIFont boldSystemFontOfSize:16];
    self.nameLabel.textColor = [UIColor colorWithRed:(71/255.0) green:(71/255.0) blue:(71/255.0) alpha:1];

    [self addSubview:self.nameLabel];

}

- (void)initTransferButton{
    CGFloat width = 47;
    CGFloat height = 24;
    CGFloat x = self.contentView.bounds.size.width - width;
    CGFloat y = FriendTableViewCellHeight*0.5 - height*0.5;
    self.transferButton = [[UIButton alloc]initWithFrame:CGRectMake(x,y ,width,height)];
    [self.transferButton setTitle:@"轉帳" forState:UIControlStateNormal];
    [self.transferButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [self.transferButton setTitleColor:[UIColor colorWithRed:(236/255.0) green:(0/255.0) blue:(140/255.0) alpha:1] forState:UIControlStateNormal];

    [self.transferButton.layer setCornerRadius:2];
    [self.transferButton.layer setBorderWidth:1.2];
    [self.transferButton.layer setBorderColor: [UIColor colorWithRed:(236/255.0) green:(0/255.0) blue:(140/255.0) alpha:1].CGColor];

    [self addSubview:self.transferButton];
}

- (void)initMoreButton{
    CGFloat width = 18;
    CGFloat height = 4;
    CGFloat x = self.contentView.bounds.size.width ;
    CGFloat y = FriendTableViewCellHeight*0.5 - height*0.5;
    self.moreButton = [[UIButton alloc]initWithFrame:CGRectMake(x,y ,width,height)];
    [self.moreButton setImage:[UIImage imageNamed:@"icFriendsMore"] forState:UIControlStateNormal];

    [self addSubview:self.moreButton];

}




@end

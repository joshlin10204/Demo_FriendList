//
//  InviteTableViewCell.m
//  Demo_FriendList
//
//  Created by Josh on 2025/2/18.
//

#import "InviteTableViewCell.h"
@interface InviteTableViewCell ()
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancelButton;


@end
@implementation InviteTableViewCell

- (void)configureWithFriendModel:(FriendModel *)model  {
    self.nameLabel.text = model.name;
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
    [self initAvatarImage];
    [self initNameLabel];
    [self initMessageLabel];
    [self initConfirmButton];
    [self initCancelButton];
}
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.confirmButton.frame = CGRectMake(frame.size.width - self.confirmButton.frame.size.width- self.cancelButton.frame.size.width -10,
                                          InviteTableViewCellHeight * 0.5 - self.confirmButton.frame.size.height * 0.5,
                                           self.confirmButton.frame.size.width,
                                           self.confirmButton.frame.size.height);
    self.cancelButton.frame = CGRectMake(frame.size.width - self.cancelButton.frame.size.width,
                                         InviteTableViewCellHeight * 0.5 - self.cancelButton.frame.size.height * 0.5,
                                          self.cancelButton.frame.size.width,
                                          self.cancelButton.frame.size.height);

}

- (void) initAvatarImage{
    CGFloat height = 40;
    CGFloat width = 40;
    CGFloat x = 30;
    CGFloat y = InviteTableViewCellHeight*0.5 - height*0.5;
    self.avatarImageView =  [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    self.avatarImageView.image  = [UIImage imageNamed:@"imgFriendsFemaleDefault"];

    [self addSubview:self.avatarImageView];
}
- (void) initNameLabel{

    CGFloat width = self.frame.size.width*0.4;
    CGFloat height = 22;
    CGFloat x = 85;
    CGFloat y = InviteTableViewCellHeight*0.5 - height;
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
    self.nameLabel.text = @"";
    self.nameLabel.font = [UIFont boldSystemFontOfSize:16];
    self.nameLabel.textColor = [UIColor colorWithRed:(71/255.0) green:(71/255.0) blue:(71/255.0) alpha:1];

    [self addSubview:self.nameLabel];

}

- (void) initMessageLabel{

    CGFloat width = self.frame.size.width*0.4;
    CGFloat height = 18;
    CGFloat x = 85;
    CGFloat y = InviteTableViewCellHeight*0.5;
    self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
    self.messageLabel.text = @"邀請你成為好友：)";
    self.messageLabel.font = [UIFont systemFontOfSize:13];
    self.messageLabel.textColor = [UIColor colorWithRed:(153/255.0) green:(153/255.0) blue:(153/255.0) alpha:1];

    [self addSubview:self.messageLabel];

}

- (void)initConfirmButton{
    CGFloat width = 30;
    CGFloat height = width;
    CGFloat x = self.contentView.bounds.size.width ;
    CGFloat y = InviteTableViewCellHeight*0.5 - height*0.5;
    self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(x,y ,width,height)];
    [self.confirmButton setImage:[UIImage imageNamed:@"btnFriendsAgree"] forState:UIControlStateNormal];

    [self addSubview:self.confirmButton];

}

- (void)initCancelButton{
    CGFloat width = 30;
    CGFloat height = width;
    CGFloat x = self.contentView.bounds.size.width ;
    CGFloat y = InviteTableViewCellHeight*0.5 - height*0.5;
    self.cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(x,y ,width,height)];
    [self.cancelButton setImage:[UIImage imageNamed:@"btnFriendsDelet"] forState:UIControlStateNormal];

    [self addSubview:self.cancelButton];

}


@end

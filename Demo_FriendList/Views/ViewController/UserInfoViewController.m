//
//  UserInfoViewController.m
//  Demo_FriendList
//
//  Created by Josh on 2025/2/10.
//

#import "UserInfoViewController.h"
#import "UserViewModel.h"

@interface UserInfoViewController ()
@property (nonatomic, strong) UserViewModel *userViewModel;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *kokoIDLabel;
@property (nonatomic, weak) NSString *userName;
@property (nonatomic, weak) NSString *kokoID;


@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadUserInfoData];
    // Do any additional setup after loading the view.
//    [self.view setBackgroundColor:[UIColor lightGrayColor]];
//    [self initKOKOIDTitleLabel];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initUserNameLabel];
    [self initKOKOIDLabel];
    [self initAvatarImage];

}

- (void)reloadUserInfoData{
    self.userViewModel = [[UserViewModel alloc]init];
    [self.userViewModel fetchUserDataWithSuccess:^{
        self.userName = self.userViewModel.userInfo.name;
        self.kokoID = self.userViewModel.userInfo.kokoid;
        [self updateUserInfo];
        } withFail:^{
            
        }];
}

- (void)updateUserInfo{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.userNameLabel.text = self.userName;
        self.kokoIDLabel.text = [NSString stringWithFormat:@"KOKO ID : %@", self.kokoID?:@""];

    });
}

- (void) initUserNameLabel{

    CGFloat widht = self.view.frame.size.width*0.5;
    CGFloat height = self.view.frame.size.height*0.25;
    CGFloat x = self.view.frame.size.width*0.04;
    CGFloat y = self.view.frame.size.height*0.5 - height;
    self.userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, y, widht, height)];
    self.userNameLabel.text = _userName?:@"";
    self.userNameLabel.font = [UIFont boldSystemFontOfSize:17];
    self.userNameLabel.textColor = [UIColor colorWithRed:(71/255.0) green:(71/255.0) blue:(71/255.0) alpha:1];

    [self.view addSubview:self.userNameLabel];

}
- (void) initKOKOIDLabel{
    CGFloat widht = self.view.frame.size.width*0.5;
    CGFloat height = self.view.frame.size.height*0.25;
    CGFloat x = self.view.frame.size.width*0.04;
    CGFloat y = self.view.frame.size.height*0.5;
    self.kokoIDLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, y, widht, height)];
    self.kokoIDLabel.text = [NSString stringWithFormat:@"KOKO ID : %@", _kokoID?:@""];
    self.kokoIDLabel.font = [UIFont systemFontOfSize:17];
    self.kokoIDLabel.textColor = [UIColor colorWithRed:(71/255.0) green:(71/255.0) blue:(71/255.0) alpha:1];
//    [self.kokoIDLabel sizeToFit];
    [self.view addSubview:self.kokoIDLabel];
    
    
}
- (void) initAvatarImage{
    CGFloat height = self.view.frame.size.height*0.6;
    CGFloat widht = height;
    CGFloat x = self.view.frame.size.width - widht;
    CGFloat y = self.view.frame.size.height*0.5 - widht*0.5;
    UIImageView *imageView =  [[UIImageView alloc]initWithFrame:CGRectMake(x, y, widht, height)];
    imageView.image  = [UIImage imageNamed:@"imgFriendsFemaleDefault"];
    
    [self.view addSubview:imageView];
}



@end

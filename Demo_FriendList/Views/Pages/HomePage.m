//
//  HomeViewController.m
//  Demo_FriendList
//
//  Created by Josh on 2025/2/10.
//

#import "HomePage.h"
#import "FriendsPage.h"




@interface HomePage (){
    
    DemoType _currentDemoType;

}

@end

@implementation HomePage


- (void)viewDidLoad {
    [super viewDidLoad];
    _currentDemoType = DemoTypeNoFriend;
    // Do any additional setup after loading the view.
    [self initDemoButton:DemoTypeNoFriend];
    [self initDemoButton:DemoTypeHasFriend];
    [self initDemoButton:DemoTypeInviteFriend];
    
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(236/255.0) green:(0/255.0) blue:(140/255.0) alpha:1];

}


- (void)initDemoButton:(DemoType)type{
    
    CGFloat width = self.view.frame.size.width*0.35;
    CGFloat height = width * 0.35;
    CGFloat x  = self.view.center.x - width*0.5 ;
    CGFloat y = self.view.center.y + height*0.5;
    UIColor* color = [UIColor colorWithRed:(236/255.0) green:(0/255.0) blue:(140/255.0) alpha:1];
    NSString* title =[[NSString alloc]init];
    
    switch (type) {
        case DemoTypeNoFriend:
            y = self.view.center.y - height*2;
            title = @"無好友畫面";
            color = [UIColor colorWithRed:(236/255.0) green:(0/255.0) blue:(140/255.0) alpha:1];
            break;
        case DemoTypeHasFriend:
            y = self.view.center.y - height*0.5;
            title = @"好友列表";
            color = [UIColor colorWithRed:(236/255.0) green:(0/255.0) blue:(140/255.0) alpha:1];
            break;
        case DemoTypeInviteFriend:
            y = self.view.center.y + height*1;
            title = @"好友列表+邀請";
            color = [UIColor colorWithRed:(236/255.0) green:(0/255.0) blue:(140/255.0) alpha:1];
            break;
        default:
            title = @"";
            break;
    }


    UIButton* button = [[UIButton alloc]initWithFrame:CGRectMake(x,y ,width,height)];
    button.tag = type;
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];

    [button.layer setCornerRadius:height*0.5 ];
    [button setBackgroundColor:color];
    [button addTarget:self action:@selector(onClickDemoButton:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];
}

- (void)onClickDemoButton:(UIButton*)sender{
    switch (sender.tag) {
        case DemoTypeNoFriend:
            _currentDemoType = DemoTypeNoFriend;
            break;
        case DemoTypeHasFriend:
            _currentDemoType = DemoTypeHasFriend;
            break;
        case DemoTypeInviteFriend:
            _currentDemoType = DemoTypeInviteFriend;
            break;
        default:
            break;
    }

    FriendsPage *friendsPage  = [FriendsPage initFriendsPageWithDemoType:_currentDemoType];
    [self.navigationController pushViewController:friendsPage animated:YES];

    
}
@end

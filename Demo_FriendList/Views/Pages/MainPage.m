//
//  HomePage.m
//  Demo_FriendList
//
//  Created by Josh on 2025/2/18.
//

#import "MainPage.h"
#import "FriendsPage.h"
#import "HomePage.h"

@interface MainPage ()
@property (nonatomic, strong) FriendsPage * friendsPage;
@property (nonatomic, strong) UIViewController * productPage;
@property (nonatomic, strong) HomePage * homePage;
@property (nonatomic, strong) UIViewController * managePage;
@property (nonatomic, strong) UIViewController * settingPage;


@end

@implementation MainPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavigationBarItem];
    [self initFriendsPage];
    [self initProductPage];
    [self initHomePage];
    [self initManagePage];
    [self initSettingPage];
    
    
    self.viewControllers=@[self.productPage,self.friendsPage,self.homePage,self.managePage,self.settingPage];
    [self setSelectedIndex:1];

}

- (void)initNavigationBarItem{
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icNavibarBack"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickBackItem)];
    
    UIBarButtonItem *atmItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icNavPinkWithdraw"]style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *transferItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icNavPinkTransfer"]style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *scanItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icNavPinkScan"]style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItems = @[backButtonItem,atmItem,transferItem];
    self.navigationItem.rightBarButtonItem = scanItem;
    
}
- (void)onClickBackItem{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)initFriendsPage{
    
    self.friendsPage  = [[FriendsPage alloc]init];
    UIImage *image = [[UIImage imageNamed:@"icTabbarFriendsOff"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:@"icTabbarFriendsOn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.friendsPage.tabBarItem = [[UITabBarItem alloc] initWithTitle:@""image:image selectedImage:selectedImage];

}

- (void)initProductPage{
    self.productPage = [[UIViewController alloc] init];
    UIImage *image = [[UIImage imageNamed:@"icTabbarProductsOff"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:@"icTabbarProductsOn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.productPage.tabBarItem = [[UITabBarItem alloc] initWithTitle:@""image:image selectedImage:selectedImage];
}
- (void)initHomePage{
    self.homePage = [[HomePage alloc] init];
    UIImage *image = [[UIImage imageNamed:@"icTabbarHomeOff"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:@"icTabbarHomeOn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.homePage.tabBarItem = [[UITabBarItem alloc] initWithTitle:@""image:image selectedImage:selectedImage];
}
- (void)initManagePage{
    self.managePage = [[UIViewController alloc] init];
    UIImage *image = [[UIImage imageNamed:@"icTabbarManageOff"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:@"icTabbarManageOn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.managePage.tabBarItem = [[UITabBarItem alloc] initWithTitle:@""image:image selectedImage:selectedImage];
}
- (void)initSettingPage{
    self.settingPage = [[UIViewController alloc] init];
    UIImage *image = [[UIImage imageNamed:@"icTabbarSettingOff"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:@"icTabbarSettingOn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.settingPage.tabBarItem = [[UITabBarItem alloc] initWithTitle:@""image:image selectedImage:selectedImage];
}


@end

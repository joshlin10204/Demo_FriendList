//
//  SubFriendListViewController.m
//  Demo_FriendList
//
//  Created by Josh on 2025/2/11.
//

#import "FriendListViewController.h"
#import "FriendTableViewCell.h"
#import "SearchTextFieldView.h"
#import "FriendListEmptyView.h"
#import "FriendModel.h"
#import "FriendsViewModel.h"


#define SearchTextFieldViewHeight 36
#define SearchTextFieldViewPositionY 15

@interface FriendListViewController ()<SearchTextFieldViewDelegate,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) SearchTextFieldView *searchTextFieldView;
@property (nonatomic, strong) FriendListEmptyView *friendListEmptyView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<FriendModel*> *friendsArray;
@property (nonatomic, strong) NSMutableArray<FriendModel*> *showFriendsArray;


@end

@implementation FriendListViewController


+(FriendListViewController*) initFriendListViewControllerWithFriendModelList:(NSArray<FriendModel*>*)list{
    
    FriendListViewController *friendListViewController  = [[FriendListViewController alloc]init];
    friendListViewController.friendsArray = list;
    friendListViewController.showFriendsArray = [list mutableCopy];
    return  friendListViewController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    


}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewWillLayoutSubviews{
    [super viewDidLayoutSubviews];
    if(self.friendsArray.count ==0){
        [self initEmptyFriendView];
    }else{
        [self initSearchTextFieldView];
        [self initFriendListTableView];
    }
    


}

#pragma mark - Init

- (void)initSearchTextFieldView{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = SearchTextFieldViewHeight;
    CGFloat x = 0;
    CGFloat y = SearchTextFieldViewPositionY;
    self.searchTextFieldView = [[SearchTextFieldView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    self.searchTextFieldView.delegate = self;
    [self.view addSubview:self.searchTextFieldView];
}


- (void)initFriendListTableView{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - SearchTextFieldViewHeight - SearchTextFieldViewPositionY -10;
    CGFloat x = 0;
    CGFloat y = SearchTextFieldViewHeight+SearchTextFieldViewPositionY+10;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[FriendTableViewCell class] forCellReuseIdentifier:@"FriendCell"];
    [self.view addSubview:self.tableView];
}

- (void) initEmptyFriendView{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGFloat x = 0;
    CGFloat y = 0;
    self.friendListEmptyView = [[FriendListEmptyView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [self.view addSubview:self.friendListEmptyView];
    
}

#pragma mark - SearchTextField Delegate

- (void) didSearchText:(NSString*)text{
    
    if(text.length ==0){
        self.showFriendsArray = [self.friendsArray mutableCopy];
    }else{
        
        FriendsViewModel *viewModel = [[FriendsViewModel alloc]init];
        self.showFriendsArray = [[viewModel searchFriendWithSearchString:text withFriendsList:self.friendsArray]mutableCopy];
    }
    [self.tableView reloadData];    
    NSLog(@"%@",text);
}
- (void) textFieldDidBeginEditing:(UITextField*)textField{
    NSLog(@"textFieldDidBeginEditing");

}
- (void) textFieldDidEndEditing:(UITextField*)textField{
    NSLog(@"textFieldDidEndEditing");

}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FriendTableViewCellHeight;  // 設定 Cell 高度為 80
}

// 設定 TableView 有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.showFriendsArray.count;
}

// 設定 Cell 內容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell" forIndexPath:indexPath];

    FriendModel *friendModel = self.showFriendsArray[indexPath.row];
    [cell configureWithFriendModel:friendModel];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO; // 禁止左滑編輯（刪除）
}


@end

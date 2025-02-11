//
//  SubFriendListViewController.m
//  Demo_FriendList
//
//  Created by Josh on 2025/2/11.
//

#import "FriendListViewController.h"
#import "FriendTableViewCell.h"

@interface FriendListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *friendsArray;

@end

@implementation FriendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.friendsArray = [NSMutableArray arrayWithArray:@[
         @{@"name": @"Alice", @"avatar": @"avatar1", @"isOnline": @YES},
         @{@"name": @"Bob", @"avatar": @"avatar2", @"isOnline": @NO},
         @{@"name": @"Charlie", @"avatar": @"avatar3", @"isOnline": @YES},
     ]];

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initFriendListTableView];
 

}

- (void)initFriendListTableView{

    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[FriendTableViewCell class] forCellReuseIdentifier:@"FriendCell"];
    [self.view addSubview:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FriendTableViewCellHeight;  // 設定 Cell 高度為 80
}

// 設定 TableView 有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friendsArray.count;
}

// 設定 Cell 內容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell" forIndexPath:indexPath];

    NSDictionary *friendData = self.friendsArray[indexPath.row];
    NSString *name = friendData[@"name"];
 
    [cell configureWithName:name];

    return cell;
}

#pragma mark - UITableViewDelegate

// 點擊 Cell 事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *friendData = self.friendsArray[indexPath.row];
    NSLog(@"點擊了好友: %@", friendData[@"name"]);
    
    // 取消選中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// 支援刪除行
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 刪除數據並刷新表格
        [self.friendsArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


@end

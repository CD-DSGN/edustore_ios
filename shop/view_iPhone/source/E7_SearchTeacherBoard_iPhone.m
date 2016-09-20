//
//  E7_SearchTeacherBoard_iPhone.m
//  shop
//
//  Created by guangnian dashu on 16/9/14.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "E7_SearchTeacherBoard_iPhone.h"

#import "D0_SearchInput_iPhone.h"

#import "AppBoard_iPhone.h"

#import "CommonPullLoader.h"
#import "ECMobileManager.h"

@implementation E7_SearchTeacherBoard_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

DEF_OUTLET( BeeUITextField, searchInput );
DEF_MODEL( UserModel, userModel );

- (void)load
{
    self.searchHistory = [NSArray array];
    self.userResult = [NSMutableArray array];
    self.teacherId = [NSMutableArray array];
    self.isFollowed = [NSMutableArray array];
    
    self.history = [UITableView alloc];
    self.result = [UITableView alloc];
    
    self.userModel = [UserModel modelWithObserver:self];
}

- (void)unload
{
    self.searchHistory = nil;
    self.userResult = nil;
    self.teacherId = nil;
    self.isFollowed = nil;
    
    self.history = nil;
    self.result = nil;
    
    SAFE_RELEASE_MODEL( self.userModel );
}

#pragma mark -

ON_CREATE_VIEWS( signal )
{
    CGFloat height = [[UIScreen mainScreen]bounds].size.height;
    CGFloat width = [[UIScreen mainScreen]bounds].size.width;
    // init history tableView
    [self.history initWithFrame:CGRectMake(0, 70, width, height-70)];
    self.history.delegate = self;
    self.history.dataSource = self;
    [self.view addSubview:self.history];
    // init search result of user tableView
    [self.result initWithFrame:CGRectMake(0, 70, width, height-70)];
    self.result.delegate = self;
    self.result.dataSource = self;
    [self.view addSubview:self.result];
    
    [self showSearchHistory];
}

ON_DELETE_VIEWS( signal )
{
    
}

ON_LAYOUT_VIEWS( signal )
{
}

ON_WILL_APPEAR( signal )
{
    [self getHistory];
    [self.history reloadData];
}

ON_DID_APPEAR( signal )
{
}

ON_WILL_DISAPPEAR( signal )
{
}

ON_DID_DISAPPEAR( signal )
{
}

#pragma mark - 从本地文件获取搜索历史
- (void)getHistory
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    // [userDefaults removeObjectForKey:@"searchHistory"];
    NSMutableArray * history = [userDefaults mutableArrayValueForKey:@"searchHistory"];
    if ( history.count == 0  )
    {
        [history addObject:@"历史记录"];
    }
    self.searchHistory = history;
    // self.searchHistory = [userDefaults arrayForKey:@"searchHistory"];
}

#pragma mark - do search
- (void)doSearch:(NSString *)keyword
{
    [self.searchInput resignFirstResponder];
    [self.userModel searchUserByName:keyword andCourseId:self.course_id andUserId:self.user_id];
    [self addKeywordToLocal:keyword];
}

- (void)addKeywordToLocal:(NSString *)keyword
{
    keyword = [keyword trim];
    BOOL keywordExistInLocal = NO;
    NSInteger temp = 0;
    // 判断本地是否有当前搜索内容
    for ( int i = 0; i < self.searchHistory.count; i++ )
    {
        if ( [[self.searchHistory objectAtIndex:i]isEqualToString:keyword] )
        {
            keywordExistInLocal = YES;
            temp = i;
        }
    }
    // 不为空且不存在本地本地
    if ( ![keyword isEqualToString:@""] && !keywordExistInLocal )
    {
        NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
        NSMutableArray * history = [[NSMutableArray alloc]init];
        if ( self.searchHistory )
        {
            history = [self.searchHistory mutableCopy];
        }
        // 最多存9条历史记录，1条清除历史记录
//        if ( history.count == 0 )
//        {
//            [history addObject:@"删除历史记录"];
//            [history addObject:keyword];
//        }
        if ( history.count == 10 )
        {
            [history removeObjectAtIndex:1];
        }
        [history addObject:keyword];
        [userDefault setObject:history forKey:@"searchHistory"];
    }
    // 存在本地，重新对本地数组进行排序
    else if ( keywordExistInLocal )
    {
        NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
        NSMutableArray * history = [[NSMutableArray alloc]init];
        if ( self.searchHistory )
        {
            history = [self.searchHistory mutableCopy];
        }
        for ( NSInteger i = temp; i < history.count - 1; i++ )
        {
            history[i] = history[i+1];
        }
        history[history.count-1] = keyword;
        [userDefault setObject:history forKey:@"searchHistory"];
    }
}

- (void)deleteCell:(UIButton *)button
{
    NSArray * visiblecells = [self.history visibleCells];
    for ( UITableViewCell * cell in visiblecells )
    {
        if ( cell.tag == button.tag )
        {
            NSMutableArray * history = [[NSMutableArray alloc]init];
            NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
            if ( self.searchHistory )
            {
                history = [self.searchHistory mutableCopy];
            }
            [history removeObjectAtIndex:(history.count - cell.tag - 1)];
            [userDefaults setObject:history forKey:@"searchHistory"];
            [self getHistory];
            [self.history reloadData];
        }
    }
}

// 根据查询出来的teacher tableView的关注按钮进行关注
- (void)follow:(UIButton *)button
{
    [self.userModel addFollowByTeacherId:self.teacherId[button.tag] studentId:self.user_id courseId:self.course_id];
}

- (void)cancelFollow:(UIButton *)button
{
    [self.userModel cancelFollowByStudentId:self.user_id courseId:self.course_id];
}

- (void)showSearchHistory
{
    [self getHistory];
    [self.history reloadData];
    [self.history setHidden:NO];
    [self.result setHidden:YES];
}
- (void)showUserResult
{
    [self.result reloadData];
    [self.history setHidden:YES];
    [self.result setHidden:NO];
}

#pragma mark - keyboard return get search result
ON_SIGNAL2( BeeUITextField, signal )
{
    BeeUITextField * textField = (BeeUITextField *)signal.source;
    [self showSearchHistory];
    if ( [signal is:BeeUITextField.RETURN] )
    {
        [textField endEditing:YES];
        
        [self doSearch:textField.text];
    }
}

ON_SIGNAL3( E7_SearchTeacherBoard_iPhone, back, signal )
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"back");
    }];
}

#pragma mark - POST search user
// 二维数组？？没有二维数组，先暂时用两个数组代替，之后会换为结构体！！！
ON_MESSAGE3( API, search_user, msg )
{
    if ( msg.sending )
    {
        // TODO:查询教师中，等待结果
    }
    else if ( msg.succeed )
    {
        NSArray * data = msg.GET_OUTPUT(@"data");
        [self.userResult removeAllObjects];
        [self.teacherId removeAllObjects];
        if ( data.count == 0 )
        {
            // 当搜索结果为空时，记得消除关注按钮
            [self.userResult addObject:__TEXT(@"null")];
        }
        else
        {
            for ( TEACHER_INFO * user in data )
            {
                [self.teacherId addObject:user.user_id];
                [self.userResult addObject:user.real_name];
                [self.isFollowed addObject:user.isFollowed];
            }
        }
        [self showUserResult];
    }
    // 查询失败的错误处理
    else if ( msg.failed )
    {
    }
    else if (msg.cancelled )
    {
    }
}

ON_MESSAGE3( API, add_follow, msg )
{
    if ( msg.sending )
    {
        // TODO:关注动作执行中
        [self presentMessageTips:@"关注中"];
    }
    else if ( msg.succeed )
    {
        NSString * followed = msg.GET_OUTPUT(@"data");
        if ( [followed isEqualToString:@"1"] )
        {
            // 已关注过其他教师
            [self presentFailureTips:@"您已关注过其他教师"];
            NSLog(@"fault");
        }
        else if( [followed isEqualToString:@"0"] )
        {
            // 关注成功
            [self presentMessageTips:@"success"];
            [self dismissViewControllerAnimated:YES completion:^{}];
            NSLog(@"success");
        }
    }
    // 查询失败的错误处理
    else if ( msg.failed )
    {
    }
    else if (msg.cancelled )
    {
    }
}

ON_MESSAGE3( API, cancel_follow, msg )
{
    if( msg.sending )
    {
        // 取消关注中
        [self presentMessageTips:@"取消中"];
    }
    else if( msg.succeed )
    {
        // 取消关注后刷新
        [self dismissViewControllerAnimated:YES completion:^{}];
        
    }
    else if ( msg.failed )
    {
        
    }
    else if ( msg.cancelled )
    {
    }
}

#pragma mark 实现tableView的代理
// 共有几行tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( tableView == self.history )
    {
        return [self.searchHistory count];
    }
    else if ( tableView == self.result )
    {
        return [self.userResult count];
    }
    return 0;
}
// 每个tableCell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( tableView == self.history )
    {
        return 50;
    }
    else if ( tableView == self.result )
    {
        return 50;
    }
    return 0;
}
// 每行tableView的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( tableView == self.history )
    {
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.frame = CGRectMake(0, 0, 320, 50);
        // 历史记录存在数组中，数组是倒序展示的
        cell.textLabel.text = [self.searchHistory objectAtIndex:(self.searchHistory.count - indexPath.row - 1)];
        cell.textLabel.font = [UIFont fontWithName:UIFontTextStyleBody size:8];
        cell.imageView.image = [UIImage imageNamed:@"searcher_new_search_icon.png"];
        cell.tag = [indexPath row];
        
        if ( (self.searchHistory.count - indexPath.row - 1) > 0 )
        {
            UIButton * selected = [[UIButton alloc]init];
            selected.frame = CGRectMake(290, 17.5f, 15, 15);
            selected.tag = indexPath.row;
            selected.backgroundImage = [UIImage imageNamed:@"icon_rightArrow_selected.png"];
            [selected addTarget:self action:@selector(deleteCell:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:selected];
        }
        return cell;
    }
    else if ( tableView == self.result )
    {
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.selectionStyle = NO;
        cell.frame = CGRectMake(0, 0, 320, 50);
        // 查询结果为空
        if ( [[self.userResult objectAtIndex:0] isEqualToString:__TEXT(@"null")] )
        {
            
        }
        else
        {
            // 右侧按钮,目标实现点击关注与取消关注
            UIButton * follow = [[UIButton alloc] init];
            follow.frame = CGRectMake(280, 10, 20, 20);
            follow.tag = indexPath.row;
            // follow.backgroundImage = [UIImage imageNamed:@"follow.png"];
            NSNumber * followed = [self.isFollowed objectAtIndex:indexPath.row];
            if ( followed.intValue == 1 )   // 该学生正在关注该教师
            {
                follow.backgroundColor = [UIColor blueColor];
                [follow addTarget:self action:@selector(cancelFollow:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                follow.backgroundColor = [UIColor orangeColor];
                [follow addTarget:self action:@selector(follow:) forControlEvents:UIControlEventTouchUpInside];
            }
            [cell.contentView addSubview:follow];
        }
        // user name or some describtion
        cell.textLabel.text = [self.userResult objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [self.userResult objectAtIndex:indexPath.row];
        // user header image
        cell.imageView.image = [UIImage imageNamed:@"item_info_buy_entry_loading_header_close_icon.png"];
        return cell;
    }
    return nil;
}

// 选择cell事件
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( tableView == self.history )
    {
        if ( (self.searchHistory.count - indexPath.row - 1) > 0 )
        {
            UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            NSString * keyword = cell.textLabel.text;
            [self doSearch:keyword];
        }
    }
    else if ( tableView == self.result )
    {
        // TODO：查看用户的详细资料
    }
}

// 额。。。找了半天。。。滑动隐藏键盘
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchInput resignFirstResponder];
}

@end

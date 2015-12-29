//
//  RootViewController.m
//  Aoaola
//
//  Created by Peter on 15/12/21.
//  Copyright © 2015年 Scofield. All rights reserved.
//

#import "RootViewController.h"
#import "AdditionsMacro.h"
#import "MainViewController.h"

@interface RootViewController ()

@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIButton *searchCancleBtn;
@end

@implementation RootViewController

-(void)viewWillAppear:(BOOL)animated{
    //将搜索条放在一个UIView上
    _searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, NAVIGATIONBAR_HEIGHT)];
    _searchView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = _searchView;
    
    //导航条的搜索条
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0,_searchView.width,NAVIGATIONBAR_HEIGHT)];
    _searchBar.tag = 100;
    [_searchBar setSearchBarStyle:UISearchBarStyleMinimal];
    _searchBar.delegate = self;
    _searchBar.backgroundColor = [UIColor clearColor];
    [_searchBar setPlaceholder:@"搜索"];
    [_searchView addSubview:_searchBar];
    
}

- (void)cancleSearch:(UIButton *)sender{
//    [UISearchDisplayController setActive:NO animated:YES];
    [UIView animateWithDuration:0.5 animations:^{
        _searchBar.frame = CGRectMake(0,NAVIGATIONBAR_HEIGHT/5,SCREEN_WIDTH-20,NAVIGATIONBAR_HEIGHT/2);
        _searchCancleBtn.alpha = 0;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    MainViewController *mainView = [[MainViewController alloc] init];
    mainView.view.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self addChildViewController:mainView];
    [self.view addSubview:mainView.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchBarDelegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
    
    for (UIView *view in [[_searchBar.subviews lastObject] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancelBtn = (UIButton *)view;
            [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
    
    return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar endEditing:YES];
    [searchBar setShowsCancelButton:NO animated:YES];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_searchBar setShowsCancelButton:NO animated:YES];
    [_searchBar endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

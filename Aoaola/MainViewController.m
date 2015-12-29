//
//  MainViewController.m
//  Aoaola
//
//  Created by Peter on 15/12/21.
//  Copyright © 2015年 Scofield. All rights reserved.
//

#import "MainViewController.h"
#import "AdditionsMacro.h"


#define kImageWidth   SCREEN_WIDTH/3
#define kImageHeight  SCREEN_WIDTH/3
@interface MainViewController ()
{
    NSArray *titleStrArr;
}

@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    titleStrArr = [[NSArray alloc] initWithObjects:@"洁面",@"乳液",@"面霜",@"精华",@"化妆水",@"面膜",@"防晒",@"卸妆",@"全部", nil];
    
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _mainTableView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    [self.view addSubview:_mainTableView];
    _mainTableView.dataSource = self;
    _mainTableView.separatorColor = [UIColor clearColor];
    _mainTableView.delegate = self;
    _mainTableView.backgroundColor = [UIColor getColor:@"C6C6C6"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row>=3) {
        return kImageWidth*2;
    }
    return kImageWidth;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //九宫格效果
        if (indexPath.row<3) {
            for (int i=0; i<3; i++) {
                UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kImageWidth, kImageHeight)];
                buttonView.backgroundColor = [UIColor whiteColor];
                buttonView.layer.masksToBounds = YES;
                buttonView.layer.borderColor = [[UIColor getColor:@"C6C6C6"] CGColor];
                buttonView.layer.borderWidth = .5;
                [cell addSubview:buttonView];
                buttonView.center = CGPointMake(kImageWidth *( 0.5 + i) , kImageWidth * 0.5);
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.bounds = CGRectMake(0, 0, kImageWidth*100/124, kImageWidth*100/124);
                button.center = CGPointMake(buttonView.width/2, buttonView.height/2 - 10);
                button.tag = 100+indexPath.row*3+i;
                [button addTarget:self action:@selector(imageItemClick:) forControlEvents:UIControlEventTouchUpInside];
                [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"mainproduct_%d",(indexPath.row+1)*(i+1)]] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"mainproduct_%d",(indexPath.row+1)*(i+1)]] forState:UIControlStateHighlighted];
                [buttonView addSubview:button];
                
                UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kImageWidth, 20)];
                title.text = titleStrArr[indexPath.row*3+i];
                title.textAlignment = NSTextAlignmentCenter;
                title.font = [UIFont systemFontOfSize:14];
                title.center = CGPointMake(buttonView.width/2, button.y+button.height+5);
                [buttonView addSubview:title];
            }
        }else{
            //广告展示栏
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kImageWidth*2-20)];
            image.center = CGPointMake(SCREEN_WIDTH/2, kImageWidth);
            image.image = [UIImage imageNamed:@"maintablepic1"];
            [cell addSubview:image];
        }
    }
    return cell;
}

-(void)imageItemClick:(UIButton *)button{
    NSLog(@"........%@",titleStrArr[button.tag-100]);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<3) {
        return;
    }
}

@end

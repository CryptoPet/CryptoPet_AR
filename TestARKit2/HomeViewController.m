//
//  HomeViewController.m
//  TestARKit2
//
//  Created by Junchao Yu on 2018/1/27.
//  Copyright © 2018年 silver6wings. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) UIScrollView * sv;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,
                                                             self.view.bounds.size.width,
                                                             self.view.bounds.size.height)];
    self.sv.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width * 2.656);
    [self.view addSubview:self.sv];
    
    UIImageView * imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       self.view.bounds.size.width,
                                                                       self.view.bounds.size.width * 2.656)];
    imgv.image = [UIImage imageNamed:@"page-1-4"];
    [self.sv addSubview:imgv];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 80, 80);
    [button addTarget:self action:@selector(btClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)btClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

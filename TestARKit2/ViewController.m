//
//  ViewController.m
//  TestARKit2
//
//  Created by Junchao Yu on 2018/1/27.
//  Copyright © 2018年 silver6wings. All rights reserved.
//

#import "ViewController.h"
#import "Scene.h"
#import "InfoViewController.h"
#import "HomeViewController.h"

@interface ViewController () <ARSKViewDelegate>

@property (nonatomic, strong) ARSKView *sceneView;
@property (nonatomic, strong) UIImageView *dogView;

@end


@implementation ViewController

BOOL showDog = false;

- (void)loadView {
    [super loadView];
    ARSKView * skView = [[ARSKView alloc] initWithFrame:self.view.bounds];
    self.sceneView = skView;
    [self.view addSubview:skView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"宠物蛋";
    
    self.sceneView.delegate = self;
    Scene *scene = (Scene *)[SKScene nodeWithFileNamed:@"Scene"];
    [self.sceneView presentScene:scene];
    
    [self addLayer];
    
    UIButton * bt = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 80,
                                                               self.view.bounds.size.height - 80,
                                                               70, 70)];
    bt.backgroundColor = [UIColor clearColor];
    [bt setImage:[UIImage imageNamed:@"Group"] forState:UIControlStateNormal];
    bt.clipsToBounds = YES;
    bt.layer.cornerRadius = 5;
    [bt addTarget:self action:@selector(btClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
    
    UIButton * bt3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,
                                                                self.view.bounds.size.width, 500)];
    bt3.backgroundColor = [UIColor clearColor];
    bt3.clipsToBounds = YES;
    bt3.layer.cornerRadius = 5;
    [bt3 addTarget:self action:@selector(btClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt3];
    
    UIButton * bt2 = [[UIButton alloc] initWithFrame:CGRectMake(10,
                                                               self.view.bounds.size.height - 80,
                                                               70, 70)];
    bt2.backgroundColor = [UIColor clearColor];
    [bt2 setImage:[UIImage imageNamed:@"Group2"] forState:UIControlStateNormal];
    bt2.clipsToBounds = YES;
    bt2.layer.cornerRadius = 5;
    [bt2 addTarget:self action:@selector(bt2Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt2];
    
    self.dogView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dog.png"]];
    self.dogView.frame = CGRectMake(self.view.bounds.size.width / 2 - 100,
                                    self.view.bounds.size.height - 240,
                                    200, 200);
    self.dogView.hidden = YES;
    [self.view addSubview:self.dogView];
    
}

- (void)addLayer {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0,
                                     [UIScreen mainScreen].bounds.size.height-64,
                                     [UIScreen mainScreen].bounds.size.width,
                                     64);  // 设置显示的frame
    gradientLayer.colors = @[
                             (id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0].CGColor,
                             (id)[UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor
                             ];  // 设置渐变颜色
    //    gradientLayer.locations = @[@0.0, @0.2, @0.5];    // 颜色的起点位置，递增，并且数量跟颜色数量相等
    gradientLayer.startPoint = CGPointMake(0, 0);   //
    gradientLayer.endPoint = CGPointMake(0, 1);     //
    [self.view.layer addSublayer:gradientLayer];
}

- (void)btClick {
    InfoViewController * vc = [[InfoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    showDog = YES;
}

- (void)bt2Click {
    HomeViewController * vc = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//     [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
    [self.sceneView.session runWithConfiguration:configuration];
    
    self.dogView.hidden = !showDog;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.sceneView.session pause];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - ARSKViewDelegate

- (SKNode *)view:(ARSKView *)view nodeForAnchor:(ARAnchor *)anchor {
    
    NSString * fileName = [NSString stringWithFormat:@"egg%d.png", (int)(arc4random() % 5)];
    
    SKTexture * all = [SKTexture textureWithImageNamed:fileName];
    SKTexture * texture = [SKTexture textureWithRect:CGRectMake(0, 0, 1, 1) inTexture:all];
    
    SKSpriteNode * node = [SKSpriteNode spriteNodeWithTexture:texture];
    node.size = CGSizeMake(30, 30);

    return node;
}

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
}

- (void)sessionWasInterrupted:(ARSession *)session {
}

- (void)sessionInterruptionEnded:(ARSession *)session {
}

@end

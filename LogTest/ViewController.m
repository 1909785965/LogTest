//
//  ViewController.m
//  LogTest
//
//  Created by tpv tpv on 17/12/6.
//  Copyright © 2017年 xumxum. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    DDLogDebug(@"DDLogDebug");
//    DDLogWarn(@"DDLogWarn");
//    DDLogVerbose(@"DDLogVerbose");
//    DDLogError(@"DDLogVerbose");
//    DDLogInfo(@"DDLogInfo");
//    
//    AppLogD(@"AppLogD");
//    AppLogE(@"AppLogE");
//    AppLogI(@"AppLogI");
//    AppLogV(@"AppLogV");
//    AppLogW(@"AppLogW");
//    
//    DLog(@"DLog");
    
    SecViewController * vc = [[SecViewController alloc]init];
    [self.view addSubview:vc.view];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

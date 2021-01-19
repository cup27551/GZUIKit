//
//  ViewController.m
//  GZUIKitDemo
//
//  Created by quark on 2021/1/5.
//

#import "ViewController.h"
#import "GZAlertView.h"
#import "GZAlertApiConfig.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    
    [GZAlertView sheetAlertViewWithTitles:@[@"233",@"23123"] cancelTitle:@"sss" fromView:self.view action:^(NSInteger index) {
        NSLog(@"%ld",index);
    }];
    
    
}


@end

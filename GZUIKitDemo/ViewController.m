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

    self.view.backgroundColor = [UIColor darkGrayColor];
    
    
    GZAlertApiConfig *config = [GZAlertApiConfig shardInstance];
    config.isDarkStyle = YES;
    config.isCenter = YES;
    
    [GZAlertView showNormalAlertView:@"sdfsdfsdfsdfsdfsfsdfsdfssdfsdfsdfsdfsdfsfsdfsdfssdfsdfsdfsdfsdfsfsdfsdfssdfsdfsdfsdfsdfsfsdfsdfssdfsdfsdfsdfsdfsfsdfsdfssdfsdfsdfsdfsdfsfsdfsdfssdfsdfsdfsdfsdfsfsdfsdfs" delay:5];
    
    
}


@end

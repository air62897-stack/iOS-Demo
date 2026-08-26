//
//  ViewController.m
//  LBAppBaseFrameworkOCTest
//
//  Created by ksnowlv on 2024/9/10.
//

#import "ViewController.h"
#import <LBAppBaseFramework/LBAppBaseFramework.h>
#import <LBAppBaseFramework/LBAppBaseFramework-Swift.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    BClass * b = [BClass new];
    [BClass showInfomation:@"aaaa"];
    LBNSTimer* timer =  [LBNSTimer new];
    [timer start];
    
    
}


@end

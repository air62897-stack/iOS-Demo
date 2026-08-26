//
//  ViewController.m
//  LBAppBaseFrameworkTest
//
//  Created by ksnowlv on 2024/9/10.
//

#import "ViewController.h"

#import <LBAppBaseFramework/LBAppBaseFramework.h>
#import <LBAppBaseFramework/LBAppBaseFramework-Swift.h>
#import "LBAppBaseFrameworkTest-Bridging-Header.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [BClass showInfomation:@"mssss"];
    

    AClass* a = [AClass new];
    [a testAClass:@"aclass"];
}


@end

//
//  BClass.m
//  LBAppBaseFramework
//
//  Created by ksnowlv on 2024/9/10.
//

#import "BClass.h"
#import <LBAppBaseFramework/LBAppBaseFramework-Swift.h>

@implementation BClass

+ (void)showInfomation:(NSString*)message {
    NSLog(@"BClass:showInfomation:%@",message);
    AClass *a = [AClass new];
    [a testAClass:@"aclass"];
}

@end

//
//  BYExtensionConfig.m
//  BYBestThink
//
//  Created by lby on 2017/6/13.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYExtensionConfig.h"
#import <MJExtension.h>
#import "BYHome.h"

@implementation BYExtensionConfig

+ (void)load
{
    [BYHome mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"imgId" : @"id", @"imgName" : @"name"};
    }];
}

@end

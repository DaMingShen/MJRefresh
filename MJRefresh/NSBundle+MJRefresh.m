//
//  NSBundle+MJRefresh.m
//  MJRefreshExample
//
//  Created by MJ Lee on 16/6/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "NSBundle+MJRefresh.h"
#import "MJRefreshComponent.h"
#import "MJRefreshConfig.h"

@implementation NSBundle (MJRefresh)
+ (instancetype)mj_refreshBundle
{
    static NSBundle *refreshBundle = nil;
    if (refreshBundle == nil) {
        // 这里不使用mainBundle是为了适配pod 1.x和0.x
        refreshBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[MJRefreshComponent class]] pathForResource:@"MJRefresh" ofType:@"bundle"]];
    }
    return refreshBundle;
}

+ (UIImage *)mj_arrowImage
{
    static UIImage *arrowImage = nil;
    if (arrowImage == nil) {
        arrowImage = [[UIImage imageWithContentsOfFile:[[self mj_refreshBundle] pathForResource:@"arrow@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return arrowImage;
}

+ (NSString *)mj_localizedStringForKey:(NSString *)key
{
    return [self mj_localizedStringForKey:key value:nil];
}

/**
 项目中用到的语言
 @"zh-Hans"   //.简体
 @"zh-Hant"   //.繁体
 @"en"        //.英语
 @"vi"        //.越南语
 @"hu"        //.匈牙利语
 @"it"        //.意大利语
 @"ru"        //.俄语
 @"fr"        //.法语
 @"pt"        //.葡萄牙语
 @"de"        //.德语
 @"lt"        //.立陶宛语
 @"es"        //.西班牙语
 @"pl"        //.波兰语 Polski pl-CN
 @"he"        //希伯来语
 @"ar"        //阿拉伯语ar-CN
 @"cs"        //.捷克语
 @"nl"        //.荷兰
 @"ko"        //.韩语
 @"uk"        //.乌克兰
 */
+ (NSString *)mj_localizedStringForKey:(NSString *)key value:(NSString *)value
{
    NSString *language = MJRefreshConfig.defaultConfig.languageCode;
    // 如果配置中没有配置语言
    if (!language) {
        // （iOS获取的语言字符串比较不稳定）目前框架只处理en、zh-Hans、zh-Hant三种情况，其他按照系统默认处理
        language = [NSLocale preferredLanguages].firstObject;
    }
    // 从MJRefresh.bundle中查找资源
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mj_refreshBundle] pathForResource:language ofType:@"lproj"]];
    return [bundle localizedStringForKey:key value:value table:nil];
}

@end

//
//  UCXAppConfiguration.m
//  Pods
//
//  Created by huyujin on 2017/8/25.
//
//

#import "UCXAppConfiguration.h"
#import <WeexSDK/WXAppConfiguration.h>

#import "UCXUtil.h"
#import "UCXDebugTool.h"

@interface UCXAppConfiguration ()

/** 存储路径 */
@property (nonatomic, strong) NSString *cachePath;

@property (nonatomic, assign) NSInteger maxCacheVersionNumber;

@end

@implementation UCXAppConfiguration

+ (instancetype)shared {
    static dispatch_once_t once = 0;
    static UCXAppConfiguration *instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (NSInteger)maxCacheVersionNumber {
    UCXAppConfiguration *instance = [UCXAppConfiguration shared];
    NSInteger number = instance.maxCacheVersionNumber<=0 ? 2:instance.maxCacheVersionNumber;
    return number;
}

+(void)setMaxCacheVersionNumber:(NSInteger)number {
    UCXAppConfiguration *instance = [UCXAppConfiguration shared];
    instance.maxCacheVersionNumber = number;
}

#pragma mark -
+ (NSString *)cachePath{
    NSString *tmpPath;
    //
    UCXAppConfiguration *instance = [UCXAppConfiguration shared];
    if (instance.cachePath) {
        tmpPath = instance.cachePath;
    }else {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSArray *weexArr = [userDefaults objectForKey:UCX_US_UCAR_WEEX_KEY];
        if (weexArr && weexArr.count>0) {
            
            NSDictionary *packageInfo = [weexArr lastObject];
            tmpPath = [packageInfo objectForKey:UCX_UNZIP_FILE_PATH];
            tmpPath = [UCXDownloadDir stringByAppendingPathComponent:tmpPath];
            //赋值内存
            instance.cachePath = tmpPath;
        }
    }
    return tmpPath;
}

+ (NSString *)jsBundlePath {
    NSString *cachePath = [UCXAppConfiguration cachePath];
    //cachepath+jsBundle
    NSString *jsBundlePath = [NSString stringWithFormat:@"file://%@/%@",cachePath,@"jsBundle/views/"];
    if ([UCXDebugTool isDebug] && [UCXDebugTool isRemote]) {
        jsBundlePath = [[UCXDebugTool webUrl] stringByAppendingPathComponent:@"views/"];
    }
    return jsBundlePath;
}

+ (NSString *)imagePath {
    NSString *cachePath = [UCXAppConfiguration cachePath];
    //cachepath+res+image
    NSString *jsBundlePath = [NSString stringWithFormat:@"%@/%@/%@",cachePath,@"res",@"image"];
    if ([UCXDebugTool isDebug] && [UCXDebugTool isRemote]) {
        jsBundlePath = [UCXDebugTool webUrl];
        //直接访问资源文件目录
        jsBundlePath = [jsBundlePath stringByReplacingOccurrencesOfString:@"/dist/native" withString:@"/src/assets/image/"];
    }
    return jsBundlePath;
}

#pragma mark - business configuration
+ (NSString *)appGroup {
    return [WXAppConfiguration appGroup];
}
+ (void)setAppGroup:(NSString *)appGroup {
    [WXAppConfiguration setAppGroup:appGroup];
}

+ (NSString *)appName {
    return [WXAppConfiguration appName];
}
+ (void)setAppName:(NSString *)appName {
    [WXAppConfiguration setAppName:appName];
}

+ (NSString *)appVersion {
    return [WXAppConfiguration appVersion];
}
+ (void)setAppVersion:(NSString *)appVersion {
    [WXAppConfiguration setAppVersion:appVersion];
}

+ (NSString *)jsVersion {
    NSString *ver = [UCXAppConfiguration appVersion];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *weexArr = [userDefaults objectForKey:UCX_US_UCAR_WEEX_KEY];
    if (weexArr && weexArr.count>0) {
        NSDictionary *packageInfo = [weexArr lastObject];
        NSString *tmp = [packageInfo objectForKey:@"versionNameIos"];
        if (tmp) {
            ver = tmp;
        }
    }
    return ver;
}

+ (NSDictionary *)versionInfo {
    NSDictionary *dict = [NSDictionary dictionary];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *weexArr = [userDefaults objectForKey:UCX_US_UCAR_WEEX_KEY];
    if (weexArr && weexArr.count>0) {
        NSDictionary *packageInfo = [weexArr lastObject];
        if ([packageInfo count]>0) {
            dict = [packageInfo copy];
        }
    }
    return dict;
}

@end

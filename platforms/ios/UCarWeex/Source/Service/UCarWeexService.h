//
//  UCarWeexEngine.h
//  Pods
//
//  Created by huyujin on 2017/8/11.
//  Copyright © 2017年 ucarinc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeexSDK/WXLog.h>
#import "UCXHotUpdate.h"

@interface UCarWeexService : NSObject

+ (void)initUCarWeexService;

#pragma mark - 热更新相关

/**
 * 默认配置下热更新
 */
+ (void)hotUpdate;
/**
 *
 */
+ (void)hotUpdate:(UCXHotUpdateType)type options:(NSDictionary *)options callback:(void (^)(NSError *error))callback;

#pragma mark - 注册模块相关
/**
 *  @abstract Register a module for a given name
 *
 *  @param name The module name to register
 *
 *  @param clazz  The module class to register
 *
 **/
+ (void)registerModule:(NSString *)name withClass:(Class)clazz;

/**
 * @abstract Registers a component for a given name
 *
 * @param name The component name to register
 *
 * @param clazz The WXComponent subclass to register
 *
 **/
+ (void)registerComponent:(NSString *)name withClass:(Class)clazz;

/**
 * @abstract Registers a handler for a given handler instance and specific protocol
 *
 * @param handler The handler instance to register
 *
 * @param protocol The protocol to confirm
 *
 */
+ (void)registerHandler:(id)handler withProtocol:(Protocol *)protocol;

#pragma mark - 业务配置相关
/**
 * @abstract Group or organization of your app, default value is nil.
 */
+ (NSString *)appGroup;
+ (void)setAppGroup:(NSString *) appGroup;

/**
 * @abstract Name of your app, default is value for CFBundleDisplayName in main bundle.
 */
+ (NSString *)appName;
+ (void)setAppName:(NSString *)appName;

/**
 * @abstract Version of your app, default is value for CFBundleShortVersionString in main bundle.
 */
+ (NSString *)appVersion;
+ (void)setAppVersion:(NSString *)appVersion;

#pragma mark - 日志相关
/**
 *  log level
 */
+ (void)setLogLevel:(WXLogLevel)level;

@end

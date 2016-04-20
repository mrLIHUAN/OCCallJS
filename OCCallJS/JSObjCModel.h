//
//  OCCallJS.h
//  OCCallJS
//
//  Created by apple on 16/3/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>
@protocol JavaScriptObjectiveCDelegate <JSExport>
/**
 *  @author 李欢, 16-03-23 11:03:50
 *
 *  JS调用OC不带参数
 */
- (void)JScallObjc;

/**
 *  @author 李欢, 16-03-23 11:03:50
 *
 *  JS调用OC带参数
 *
 *  @param params JS传过来的字典类型的数据
 */
- (void)callWithDict:(NSDictionary *)params;
/**
 *  @author 李欢, 16-03-23 11:03:17
 *
 *  调用系统Alert
 *
 *  @param title title
 *  @param msg   msg
 */
- (void)show:(NSString *)title alert:(NSString *)msg;


@end

@protocol JSCallOCWithArgumentsDelegate <NSObject>
/**
 *  @author 李欢, 16-03-23 11:03:32
 *
 *  传递参数
 *
 *  @param params  参数
 *  @param isAlert 是不是Alert
 */
-(void)JSCallOCWithArguments:(NSDictionary*)params isAlert:(BOOL)isAlert;
/**
 *  @author 李欢, 16-03-23 11:03:35
 *
 *  没有参数
 */
-(void)JSCallOCWithNoneArguments;
@end
@interface JSObjCModel : NSObject <JavaScriptObjectiveCDelegate>
@property(nonatomic,weak) JSContext *jsContext;
@property(nonatomic,assign) id<JSCallOCWithArgumentsDelegate> delegate;

/**
 *  @author 李欢, 16-03-23 11:03:12
 *
 *  OC调用JS
 *
 *  @param name     JS方法名
 *  @param params   参数
 *  @param isparams 判断是否有参数
 */
-(void)OCCallJSWithMethodName:(NSString *)name Arguments:(NSDictionary*)params isparams:(BOOL)isparams;
@end



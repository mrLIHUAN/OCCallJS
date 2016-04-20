//
//  OCCallJS.m
//  OCCallJS
//
//  Created by apple on 16/3/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "JSObjCModel.h"
//实现JavaScriptObjectiveCDelegate中的方法
@implementation JSObjCModel
-(void)JScallObjc{
    if ([_delegate respondsToSelector:@selector(JSCallOCWithNoneArguments)]) {
        [_delegate JSCallOCWithNoneArguments];
    }
}
-(void)show:(NSString *)title alert:(NSString *)msg{
    
    NSDictionary *dic = @{@"title":title,
                          @"alert":msg
                          };
    if ([_delegate respondsToSelector:@selector(JSCallOCWithArguments:isAlert:)]) {
        
        [_delegate JSCallOCWithArguments:dic isAlert:YES];
        
        
    }
}
-(void)callWithDict:(NSDictionary *)params{
    if ([_delegate respondsToSelector:@selector(JSCallOCWithArguments:isAlert:)]) {
        [_delegate JSCallOCWithArguments:params isAlert:NO];
    }
}

-(void)OCCallJSWithMethodName:(NSString *)name Arguments:(NSDictionary *)params isparams:(BOOL)isparams{
    
//    NSLog(@"\n++%@\n++%@",name,params);
    JSValue *jsParamFunc = self.jsContext[name];
    if (isparams) {
        [jsParamFunc callWithArguments:@[params]];
    }else{
        
        [jsParamFunc callWithArguments:nil];
    }
    
    
}
//json转字典
-(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    
    return responseJSON;
    
}
//字典转json
- (NSString*)dictionaryToJson:(NSDictionary *)dic{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end


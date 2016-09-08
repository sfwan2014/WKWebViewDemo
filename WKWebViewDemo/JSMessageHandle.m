//
//  JSMessageHandle.m
//  WKWebViewDemo
//
//  Created by DBC on 16/9/6.
//  Copyright © 2016年 DBC. All rights reserved.
//

#import "JSMessageHandle.h"
#import "JSONKit.h"

@implementation JSMessageHandle
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"name:%@ body:%@",message.name, message.body);
    NSString *body = message.body;
    NSDictionary *actionDic = [body objectFromJSONString];
    NSString *action = [[actionDic allKeys] firstObject];
    if ([action isEqualToString:@"addNewElement"]) {
        if ([self.delegate respondsToSelector:@selector(addNewElement:)]) {
            NSString *element = actionDic[action];
            [self.delegate addNewElement:element];
        }
    }
}
@end

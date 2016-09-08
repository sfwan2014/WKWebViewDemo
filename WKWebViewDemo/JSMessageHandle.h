//
//  JSMessageHandle.h
//  WKWebViewDemo
//
//  Created by DBC on 16/9/6.
//  Copyright © 2016年 DBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@protocol JSMessageHandleDelegate <NSObject>

-(void)addNewElement:(NSString *)element;

@end

@interface JSMessageHandle : NSObject<WKScriptMessageHandler>

@property (nonatomic, assign) id<JSMessageHandleDelegate> delegate;

@end
